import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uru_bank/components/bottom_modal.dart';
import 'package:uru_bank/components/buttons.dart';
import 'package:uru_bank/components/inputs.dart';
import 'package:uru_bank/components/snackbar_message.dart';
import 'package:uru_bank/model/account_model.dart';
import 'package:uru_bank/model/user_model.dart';
import 'package:uru_bank/routes/app_routes.dart';
import 'package:uru_bank/services/auth_service.dart';
import 'package:uru_bank/services/firebase_service.dart';
import 'package:uru_bank/utils/formatted_time.dart';
import 'package:uru_bank/utils/styles.dart';
import 'package:uru_bank/utils/validators.dart';
import 'package:uru_bank/views/main_stack_views/home_view.dart';
import 'package:provider/provider.dart';
import 'package:uru_bank/providers/user.dart';

Widget formHeader({
  bool showOnlyLogo = false,
  bool showOnlyTitle = false,
  double logoHeight = 130,
}) {
  return Column(
    children: [
      if (!showOnlyTitle)
        SizedBox(
          width: double.infinity,
          height: logoHeight,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
      if (!showOnlyLogo)
        const Text(
          'UruBank',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
    ],
  );
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLogging = false;

  void handleSubmitLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      setState(() => _isLogging = true);

      final cpf = _cpfController.text.replaceAll(RegExp(r'(\D)'), '');
      final password = _passwordController.text;

      AuthService.login(cpf, password).then((response) {
        if (response.error) {
          showSnackbarMessage(
            context: context,
            message: response.message,
            error: true,
            ok: true,
            duration: 5,
          );

          setState(() => _isLogging = false);
        } else {
          setState(() => _isLogging = false);
          Provider.of<UserData>(context, listen: false)
              .setUser(response.body['user']);
          Provider.of<UserData>(context, listen: false).listen();

          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            ModalRoute.withName(AppRoutes.home),
            arguments: response.body['user'],
          );
        }
      });
    } else {
      setState(() => _isLogging = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 55, bottom: 26),
                  child: formInput(
                      placeholder: "CPF",
                      prefixIcon: const Icon(
                        Icons.person_outline_rounded,
                        color: Colors.white,
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (String? value) {
                        if (_cpfController.text.isEmpty) {
                          return loginValidation('cpf', value);
                        } else if (_cpfController.text.length == 14 &&
                            !CPFValidator.isValid(value)) {
                          return "CPF inválido";
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter(),
                      ],
                      controller: _cpfController),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: formInput(
                    placeholder: "Senha",
                    prefixIcon: const Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.white,
                    ),
                    validator: (String? value) =>
                        loginValidation('password', value),
                    obscureText: !_isPasswordVisible,
                    sufixIcon: Icon(
                      !_isPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.white,
                    ),
                    suffixIconPressed: () {
                      setState(() => _isPasswordVisible = !_isPasswordVisible);
                    },
                    sufixIconPadding: const EdgeInsets.only(right: 3),
                    controller: _passwordController,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: _isLogging
                      ? animatedButton(
                          context: context,
                          color: Styles.buttonPrimaryColor,
                          borderRadius: 10,
                        )
                      : elevatedButton(
                          context: context,
                          callback: () => handleSubmitLogin(context),
                          borderRadius: 10,
                          height: 18,
                          color: Styles.buttonPrimaryColor,
                          text: "Entrar",
                          textStyle: const TextStyle(
                            color: Color(0xffE1E1E6),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: const ButtonStyle(
                          overlayColor:
                              MaterialStatePropertyAll(Colors.transparent),
                        ),
                        child: const Text(
                          "Esqueceu sua senha ?",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.recover);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isPasswordConfirmationVisible = false;
  bool isTermsAccepted = false;
  bool isSigning = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _clearInputValues(TextEditingController controller) {
    setState(() => controller.clear());
  }

  void handleSignup(BuildContext context) {
    if (formKey.currentState!.validate()) {
      setState(() => isSigning = true);

      UrubankUser user = UrubankUser(
        name: _nameController.text,
        email: _emailController.text,
        cpf: _cpfController.text.replaceAll(RegExp(r'(\D)'), ''),
        phoneNumber: _telefoneController.text,
        birthDate: _birthDateController.text,
        account: Account(number: Account.genNumber).toJson(),
      );

      AuthService.signup(user, _passwordController.text).then((response) {
        if (response.error) {
          showSnackbarMessage(
            context: context,
            message: response.message,
            error: true,
            ok: true,
            duration: 10,
          );

          setState(() => isSigning = false);
        } else {
          setState(() => isSigning = false);
          Provider.of<UserData>(context, listen: false)
              .setUser(response.body["user"]);
          Provider.of<UserData>(context, listen: false).listen();

          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            ModalRoute.withName(AppRoutes.home),
            arguments: response.body['user'],
          );
        }
      });
    } else {
      setState(() => isSigning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 55, bottom: 20),
              child: formInput(
                placeholder: "Nome completo",
                prefixIcon: const Icon(
                  Icons.person_outline_rounded,
                  color: Colors.white,
                ),
                validator: (String? value) => signUpValidation('name', value),
                controller: _nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: formInput(
                placeholder: "Email",
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                validator: (String? value) => signUpValidation('email', value),
                sufixIconPadding: const EdgeInsets.only(right: 3),
                controller: _emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: formInput(
                placeholder: 'Data de nascimento',
                keyboardType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
                ),
                inputFormatters: [
                  MaskTextInputFormatter(
                    mask: '##/##/####',
                  ),
                ],
                suffixIconPressed: () =>
                    _clearInputValues(_birthDateController),
                controller: _birthDateController,
                validator: (String? value) =>
                    signUpValidation('birthdate', value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: formInput(
                placeholder: "Telefone",
                prefixIcon: const Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                keyboardType: const TextInputType.numberWithOptions(),
                validator: (String? value) => loginValidation('phone', value),
                inputFormatters: [
                  TelefoneInputFormatter(),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: _telefoneController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: formInput(
                placeholder: "CPF",
                prefixIcon: const Icon(
                  Icons.person_outline_rounded,
                  color: Colors.white,
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (String? value) {
                  if (_cpfController.text.isEmpty) {
                    return loginValidation('cpf', value);
                  } else if (_cpfController.text.length == 14 &&
                      !CPFValidator.isValid(value)) {
                    return "CPF inválido";
                  } else {
                    return null;
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                controller: _cpfController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
              ),
              child: formInput(
                placeholder: "Senha",
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                ),
                validator: (String? value) =>
                    loginValidation('password', value),
                obscureText: !isPasswordVisible,
                sufixIcon: Icon(
                  !isPasswordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.white,
                ),
                controller: _passwordController,
                suffixIconPressed: () {
                  setState(() => isPasswordVisible = !isPasswordVisible);
                },
                sufixIconPadding: const EdgeInsets.only(right: 3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: formInput(
                placeholder: "Confirmar senha",
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                ),
                controller: _confirmPasswordController,
                validator: (value) {
                  if (_confirmPasswordController.text.length >= 8 &&
                      _confirmPasswordController.text !=
                          _passwordController.text) {
                    return "Senhas não conferem!";
                  } else {
                    return signUpValidation('confirm-password', value);
                  }
                },
                obscureText: !isPasswordConfirmationVisible,
                sufixIcon: Icon(
                  !isPasswordConfirmationVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.white,
                ),
                suffixIconPressed: () {
                  setState(() => isPasswordConfirmationVisible =
                      !isPasswordConfirmationVisible);
                },
                sufixIconPadding: const EdgeInsets.only(right: 3),
              ),
            ),
            isSigning
                ? animatedButton(
                    context: context,
                    color: Styles.buttonPrimaryColor,
                    borderRadius: 10,
                  )
                : elevatedButton(
                    context: context,
                    callback: () => handleSignup(context),
                    borderRadius: 10,
                    height: 20,
                    color: Styles.buttonPrimaryColor,
                    text: "Cadastrar",
                    textStyle: const TextStyle(
                      color: Color(0xffE1E1E6),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class SendMoneyForm extends StatefulWidget {
  const SendMoneyForm({super.key});

  @override
  State<SendMoneyForm> createState() => _SendMoneyFormState();
}

class _SendMoneyFormState extends State<SendMoneyForm> {
  final formKey = GlobalKey<FormState>();
  final _transferValueController = TextEditingController();
  final _bankController = TextEditingController();
  final _agencyController = TextEditingController();
  final _accountController = TextEditingController();

  bool _isSending = false;
  bool missingAccountFields = false;

  void onTransferSuccesful(BuildContext context) {
    showBottomModal(
      context,
      height: 300,
      backgroundColor: Colors.white,
      topBorderRadius: 10,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Transferência enviada com succeso!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Styles.buttonPrimaryColor,
              ),
            ),
            Text(
              "Obrigado por utilizar nossos serviços.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Styles.appBackgroundColor,
              ),
            ),
            elevatedButton(
              context: context,
              callback: () => Navigator.popUntil(
                  context, ModalRoute.withName(AppRoutes.home)),
              borderRadius: 10,
              height: 18,
              color: Styles.buttonPrimaryColor,
              text: "Ok",
              textStyle: const TextStyle(
                color: Color(0xffE1E1E6),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearAllFields() {
    _transferValueController.clear();
    _bankController.clear();
    _agencyController.clear();
    _accountController.clear();
  }

  Future<void> handleTranferValue(
    BuildContext context,
    Account destAccount,
  ) async {
    double valueToTransfer = destAccount.balance + .0;
    UrubankUser? sender = Provider.of<UserData>(context, listen: false).user;

    UrubankUser? receiver =
        await FirebaseService().getUserByAccountNumber(destAccount.number);

    if (receiver != null && sender != null) {
      double senderBalance = sender.account['balance'] + .0;

      if (senderBalance >= valueToTransfer) {
        sender.account['balance'] -= valueToTransfer;
        receiver.account['balance'] += valueToTransfer;

        Account senderAccount = Account.fromJson(sender.account);
        Account receiverAccount = Account.fromJson(receiver.account);

        senderAccount.history.add(AccountHistory(
          date: "${LocalDate.day} ${LocalDate.strMonth()}",
          type: AccountHistoryType.debit,
          value: valueToTransfer,
          message: "Transferência enviada para ${receiver.name}",
        ).toJson());

        sender.account = senderAccount.toJson();

        receiverAccount.history.add(AccountHistory(
          date: "${LocalDate.day} ${LocalDate.strMonth()}",
          type: AccountHistoryType.entrance,
          value: valueToTransfer,
          message: "Transferência recebida de ${sender.name}",
        ).toJson());

        receiver.account = receiverAccount.toJson();

        await FirebaseService().updateUserData(sender.toJson());
        await FirebaseService().updateUserData(receiver.toJson());

        onTransferSuccesful(context);
      } else {
        showSnackbarMessage(
          context: context,
          message: "Saldo insuficiente!",
          error: true,
          ok: true,
          duration: 5,
        );
      }
    } else if (receiver == null) {
      showSnackbarMessage(
        context: context,
        message: "Conta de destino não encontrada!",
        error: true,
        ok: true,
        duration: 5,
      );
    }
    clearAllFields();
  }

  void handleSubmitTransfer(BuildContext context) {
    if (formKey.currentState!.validate()) {
      setState(() => _isSending = true);

      handleTranferValue(
        context,
        Account(
          number: _accountController.text,
          agency: _agencyController.text,
          bank: _bankController.text,
          balance: double.parse(
            _transferValueController.text.replaceAll("R\$", "").trim(),
          ),
        ),
      ).then((value) => setState(() => _isSending = false));
    } else {
      if (_bankController.text.isEmpty ||
          _agencyController.text.isEmpty ||
          _accountController.text.isEmpty) {
        setState(() => missingAccountFields = true);
        return;
      }
      setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 55, bottom: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Valor da transferência",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Divider(),
                formInput(
                  placeholder: "R\$ 0,00",
                  prefixIcon: const Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.white,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (String? value) {
                    if (_transferValueController.text.isEmpty) {
                      return "Informe um valor";
                    } else {
                      return null;
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    RealInputFormatter(moeda: true)
                  ],
                  controller: _transferValueController,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Banco",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Divider(),
                          formInput(
                            placeholder: "0000",
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            inputFormatters: [
                              MaskTextInputFormatter(mask: '####'),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: _bankController,
                          )
                        ],
                      ),
                    ),
                    const VerticalDivider(),
                    SizedBox(
                      width: 65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Agência",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Divider(),
                          formInput(
                              placeholder: "0000",
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                MaskTextInputFormatter(mask: '####'),
                              ],
                              controller: _agencyController)
                        ],
                      ),
                    ),
                    const VerticalDivider(),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Conta",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Divider(),
                          formInput(
                              placeholder: "00000000-0",
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              inputFormatters: [
                                // FilteringTextInputFormatter.digitsOnly,
                                MaskTextInputFormatter(mask: '########-#'),
                              ],
                              controller: _accountController)
                        ],
                      ),
                    ),
                  ],
                ),
                if (missingAccountFields)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    child: Text(
                      "Preencha todas as informações da conta",
                      style: TextStyle(
                        color: Styles.errorTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Mensagem",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Opcional",
                      style: TextStyle(
                        color: Styles.buttonPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                formInput(height: 200, maxLines: 5)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: _isSending
                ? animatedButton(
                    context: context,
                    color: Styles.buttonPrimaryColor,
                    borderRadius: 10,
                  )
                : elevatedButton(
                    context: context,
                    callback: () => handleSubmitTransfer(context),
                    borderRadius: 10,
                    height: 18,
                    color: Styles.buttonPrimaryColor,
                    text: "Enviar",
                    textStyle: const TextStyle(
                      color: Color(0xffE1E1E6),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
