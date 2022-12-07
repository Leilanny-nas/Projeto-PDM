class AuthResponse {
  final bool error;
  final String message;
  final dynamic body;

  AuthResponse({
    this.error = false,
    this.message = "",
    this.body,
  });

  static final Map<String, String> _errorMessagesMap = {
    "USER_NOT_FOUND": "Usuário não encontrado",
    "USER_CPF_ALREADY_IN_USE": "Este CPF já está em uso",
    "EMAIL_NOT_FOUND": "Usuário não encontrado",
    "EMAIL_EXISTS": "Email já está sendo usado por outra conta",
    "INVALID_PASSWORD": "Senha inválida",
    "TOO_MANY_ATTEMPTS_TRY_LATER":
        "Houve várias tentativas de acesso a essa conta sem sucesso, e foi temporariamente desativada. Tente novamente mais tarde"
  };

  static String getMessage(String code) {
    if (code.contains(':')) {
      code = code.split(':')[0].trim();
    }

    String message = _errorMessagesMap[code] ?? "Erro desconhecido!";
    return message;
  }

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "body": body,
      };
}
