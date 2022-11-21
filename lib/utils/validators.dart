const emailPattern =
    r"^([_a-zA-Z0-9-].)+(.[a-zA-Z0-9-]+)@[a-z]+(.[a-z0-9-]+)+(.[a-z]{2,4})$";
final emailRegExp = RegExp(emailPattern);

String? loginValidation(String? field, String? value) {
  if (value == null || value.isEmpty) {
    return 'Preencha este campo';
  } else if (field == "cpf") {
    const pattern = r"^\d{3}\.\d{3}\.\d{3}\-\d{2}$";
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return "Insira um CPF válido, no formato 000.000.000-00";
    }
  } else if (field == "password") {
    if (value.length < 8) {
      return "A senha deve ter pelo menos 8 caracteres";
    }
  }

  return null;
}

String? signUpValidation(String? field, String? value) {
  if (value == null || value.isEmpty) {
    return 'Preencha este campo';
  } else if (field == "cpf") {
    const pattern = r"^\d{3}\.\d{3}\.\d{3}\-\d{2}$";
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return "Insira um CPF válido, no formato 000.000.000-00";
    }
  } else if (field == "email" && !emailRegExp.hasMatch(value)) {
    return "Informe um email válido, ex: usuario@gmail.com";
  } else if (field == "password" || field == "confirm-password") {
    if (value.length < 8) {
      return "A senha deve ter pelo menos 8 caracteres";
    }
  }

  return null;
}
