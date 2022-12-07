import 'package:firebase_auth/firebase_auth.dart';
import 'package:uru_bank/model/auth_response_model.dart';
import 'package:uru_bank/model/user_model.dart';
import 'package:uru_bank/services/firebase_service.dart';

class _AuthController {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<UserCredential> signup(String email, String password) async {
    UserCredential response = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return response;
  }

  static Future<UserCredential> signin(String email, String password) async {
    UserCredential response =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    return response;
  }

  static Future<void> signout() async {
    await auth.signOut();
  }
}

class AuthService {
  static Future<AuthResponse> login(String cpf, String password) async {
    UrubankUser? user = await FirebaseService().getUserByCpf(cpf);

    if (user != null) {
      try {
        await _AuthController.signin(user.email, password);
        return AuthResponse(error: false, body: {"user": user});
      } catch (error) {
        final errorCode = error.toString();
        if (errorCode.contains("invalid-email") ||
            errorCode.contains("user-not-found")) {
          return AuthResponse(
            error: true,
            message: AuthResponse.getMessage("USER_NOT_FOUND"),
          );
        } else if (errorCode.contains("wrong-password")) {
          return AuthResponse(
            error: true,
            message: AuthResponse.getMessage("INVALID_PASSWORD"),
          );
        }
      }
    }

    return AuthResponse(
      error: true,
      message: AuthResponse.getMessage("USER_NOT_FOUND"),
    );
  }

  static Future<AuthResponse> signup(UrubankUser user, String password) async {
    bool userAlreadyExists =
        await FirebaseService().getUserByCpf(user.cpf) != null;

    if (userAlreadyExists) {
      return AuthResponse(
        error: true,
        message: AuthResponse.getMessage("USER_CPF_ALREADY_IN_USE"),
      );
    } else {
      try {
        UserCredential response = await _AuthController.signup(
          user.email,
          password,
        );

        user.id = response.user?.uid;

        UrubankUser? updatedUserData = await FirebaseService().setUserData(
          user.toJson(),
        );

        return AuthResponse(error: false, body: {"user": updatedUserData});
      } catch (error) {
        if (error.toString().contains("email-already-in-use")) {
          return AuthResponse(
            error: true,
            message: AuthResponse.getMessage("EMAIL_EXISTS"),
          );
        }
      }

      return AuthResponse(
        error: true,
        message: "Houve um erro! Tente novamente",
      );
    }
  }

  static Future<AuthResponse> recover(String cpf, String email) async {
    UrubankUser? user = await FirebaseService().getUserByCpf(cpf);

    if (user != null) {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        await auth.sendPasswordResetEmail(email: email);

        return AuthResponse(
          error: false,
          message: "Verfique seu email.",
        );
      } catch (error) {
        final errorCode = error.toString();

        if (errorCode.contains("user-not-found")) {
          return AuthResponse(
            error: true,
            message: "Não foi encontado usuário para o email especificado.",
          );
        }
      }
    }

    return AuthResponse(
      error: true,
      message: AuthResponse.getMessage("USER_NOT_FOUND"),
    );
  }

  static Future<AuthResponse> logout() async {
    await _AuthController.signout();

    return AuthResponse(
      error: false,
      message: "Logout com sucesso!",
    );
  }
}
