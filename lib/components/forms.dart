import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uru_bank/components/buttons.dart';
import 'package:uru_bank/components/inputs.dart';
import 'package:uru_bank/routes/app_routes.dart';
import 'package:uru_bank/utils/styles.dart';
import 'package:uru_bank/utils/validators.dart';
import 'package:uru_bank/views/auth_stack_views/reset_accountI.dart';
import 'package:uru_bank/views/main_stack_views/home_view.dart';

Widget formHeader() {
  return Column(
    children: [
      SizedBox(
        width: double.infinity,
        height: 130,
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
        ),
      ),
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

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 55, bottom: 26, left: 20, right: 20),
                child: formInput(
                  placeholder: "CPF",
                  prefixIcon: const Icon(
                    Icons.person_outline_rounded,
                    color: Colors.white,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  borderRadius: 4,
                  validator: (String? value) => loginValidation('cpf', value),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: formInput(
                    placeholder: "Senha",
                    prefixIcon: const Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.white,
                    ),
                    borderRadius: 4,
                    validator: (String? value) =>
                        loginValidation('password', value),
                    obscureText: !isPasswordVisible,
                    sufixIcon: Icon(
                      !isPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.white,
                    ),
                    suffixIconPressed: () {
                      setState(() => isPasswordVisible = !isPasswordVisible);
                    },
                    sufixIconPadding: const EdgeInsets.only(right: 3)),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 35,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                child: elevatedButton(
                  context: context,
                  callback: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const Home(),
                        ),
                        ModalRoute.withName(AppRoutes.home),
                      );
                    }
                  },
                  borderRadius: 4,
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
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text(
                        "Esqueceu sua senha?",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RecuperarContaStepI(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
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
  final TextEditingController _validityDateController = TextEditingController();

  bool isPasswordVisible = false;
  bool isPasswordConfirmationVisible = false;
  bool isTermsAccepted = false;

  // TODO: add controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _clearInputValues(TextEditingController controller) {
    setState(() => controller.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 55, bottom: 26, left: 20, right: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 55,
                bottom: 26,
              ),
              child: formInput(
                placeholder: "Nome completo",
                prefixIcon: const Icon(
                  Icons.person_outline_rounded,
                  color: Colors.white,
                ),
                borderRadius: 4,
                validator: (String? value) => signUpValidation('name', value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: formInput(
                placeholder: 'Data de nascimento',
                keyboardType: const TextInputType.numberWithOptions(),
                prefixIcon: const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white70,
                ),
                sufixIcon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white70,
                  size: 15,
                ),
                inputFormatters: [
                  MaskTextInputFormatter(
                    mask: '##/##/####',
                  ),
                ],
                suffixIconPressed: () =>
                    _clearInputValues(_validityDateController),
                controller: _validityDateController,
                validator: (String? value) =>
                    signUpValidation('birthdate', value),
              ),
            ),

            // TODO: Add telephon field
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
                borderRadius: 4,
                validator: (String? value) => loginValidation('cpf', value),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
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
                borderRadius: 4,
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
                borderRadius: 4,
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
            elevatedButton(
              context: context,
              callback: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const Home(),
                    ),
                    ModalRoute.withName(AppRoutes.home),
                  );
                }
              },
              borderRadius: 4,
              height: 18,
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
        // TextFormField(
        //   // controller: _cpf,
        //   autofocus: true,
        //   style: const TextStyle(color: Colors.purple, fontSize: 20),
        //   decoration: const InputDecoration(
        //       icon: Icon(Icons.person),
        //       labelText: "Nome completo",
        //       labelStyle: TextStyle(color: Colors.white)),
        //   validator: (String? value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Nome obrigatório';
        //     }
        //   },
        //   inputFormatters: [
        //     FilteringTextInputFormatter.digitsOnly,
        //     CpfInputFormatter(),
        //   ],
        // ),
        // const Divider(),
        // TextFormField(
        //   // controller: _cpf,
        //   autofocus: true,
        //   style: const TextStyle(color: Colors.purple, fontSize: 20),
        //   decoration: const InputDecoration(
        //       icon: Icon(Icons.person),
        //       labelText: "CPF",
        //       labelStyle: TextStyle(color: Colors.white)),
        //   validator: (String? value) {
        //     if (value == null || value.isEmpty) {
        //       return 'CPF obrigatório';
        //     }
        //   },
        //   inputFormatters: [
        //     FilteringTextInputFormatter.digitsOnly,
        //     CpfInputFormatter(),
        //   ],
        // ),
        // TextFormField(
        //   // controller: _cpf,
        //   autofocus: true,
        //   style: const TextStyle(color: Colors.purple, fontSize: 20),
        //   decoration: const InputDecoration(
        //       icon: Icon(Icons.calendar_month),
        //       labelText: "Data de nascimento",
        //       labelStyle: TextStyle(color: Colors.white)),
        //   validator: (String? value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Data obrigatória';
        //     }
        //   },
        //   inputFormatters: [
        //     FilteringTextInputFormatter.digitsOnly,
        //     CpfInputFormatter(),
        //   ],
        // ),
        // const Divider(),
        // TextFormField(
        //   autofocus: true,
        //   keyboardType: TextInputType.text,
        //   style: const TextStyle(color: Colors.purple, fontSize: 20),
        //   decoration: const InputDecoration(
        //       icon: Icon(Icons.email),
        //       labelText: "Email",
        //       labelStyle: TextStyle(
        //         color: Colors.white,
        //       )),
        //   validator: (String? value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Email obrigatório';
        //     }
        //   },
        // ),
        // const Divider(),
        // TextFormField(
        //   autofocus: true,
        //   keyboardType: TextInputType.text,
        //   style: const TextStyle(color: Colors.purple, fontSize: 20),
        //   decoration: const InputDecoration(
        //       icon: Icon(Icons.phone),
        //       labelText: "Telefone",
        //       labelStyle: TextStyle(
        //         color: Colors.white,
        //       )),
        //   validator: (String? value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Telefone obrigatório';
        //     }
        //   },
        //   inputFormatters: [
        //     FilteringTextInputFormatter.digitsOnly,
        //     TelefoneInputFormatter(),
        //   ],
        // ),
        // const Divider(),
        // TextFormField(
        //   autofocus: true,
        //   obscureText: true,
        //   keyboardType: TextInputType.text,
        //   style: const TextStyle(color: Colors.purple, fontSize: 20),
        //   decoration: const InputDecoration(
        //       icon: Icon(Icons.visibility_off_rounded),
        //       labelText: "Senha",
        //       labelStyle: TextStyle(
        //         color: Colors.white,
        //       )),
        //   validator: (String? value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Senha obrigatória';
        //     }
        //   },
        // ),
        // const Divider(),
        // TextFormField(
        //   autofocus: true,
        //   obscureText: true,
        //   keyboardType: TextInputType.text,
        //   style: const TextStyle(color: Colors.purple, fontSize: 20),
        //   decoration: const InputDecoration(
        //       icon: Icon(Icons.visibility_off_rounded),
        //       labelText: "Confirmar senha",
        //       labelStyle: TextStyle(
        //         color: Colors.white,
        //       )),
        //   validator: (String? value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Senha obrigatória';
        //     }
        //   },
        // ),
        // const Divider(),
        // Row(
        //   children: [
        //     Checkbox(
        //       side: const BorderSide(color: Colors.white),
        //       value: isTermsAccepted,
        //       onChanged: (bool) {
        //         setState(() => isTermsAccepted = bool!);
        //       },
        //     ),
        //     const Expanded(
        //       child: Text(
        //           'Li e concordo com os termos de condições e politicas de privacidade',
        //           style: TextStyle(
        //             color: Colors.white,
        //           )),
        //     ),
        //   ],
        // ),
        // const Divider(),
        // ButtonTheme(
        //   height: 60,
        //   child: ElevatedButton(
        //     style: ButtonStyle(
        //       minimumSize: MaterialStateProperty.all(const Size(10, 50)),
        //     ),
        //     onPressed: () {
        //       // formKey.currentState?.validate();
        //     },
        //     child: const Text(
        //       "Criar conta",
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        // )
        // ],
        // ),
      ),
    );
  }
}
