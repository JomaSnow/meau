class LoginValidations {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Usuário não pode ser vazio.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha não pode ser vazia.';
    }

    return null;
  }
}

class RegisterValidations {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nome não pode ser vazio.';
    }

    if (value.length > 40) {
      return 'Nome não pode exceder 40 caracteres.';
    }

    return null;
  }

  static String? validateIdade(String? value) {
    if (value == null || value.isEmpty) {
      return 'Idade não pode ser vazia.';
    }

    int? intValue = int.tryParse(value);

    if (intValue == null) {
      return 'Informe um valor numérico.';
    }

    if (intValue > 999 || intValue < 0) {
      return 'Informe um número entre 0 e 999.';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email não pode ser vazio.';
    }

    if (!RegExp(r"[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+").hasMatch(value)) {
      return 'Informe um email válido.';
    }

    return null;
  }

  static String? validateEstado(String? value) {
    if (value == null || value.isEmpty) {
      return 'Estado não pode ser vazio.';
    }

    if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
      return 'Utilize apenas letras.';
    }

    if (value.trim().length > 2) {
      return 'Favor informar apenas a sigla.';
    }

    return null;
  }

  static String? validateCidade(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cidade não pode ser vazia.';
    }

    if (value.length > 30) {
      return 'Cidade não pode exceder 30 caracteres.';
    }

    return null;
  }

  static String? validateEndereco(String? value) {
    if (value == null || value.isEmpty) {
      return 'Endereço não pode ser vazio.';
    }

    if (value.length > 50) {
      return 'Endereço não pode exceder 50 caracteres.';
    }

    return null;
  }

  static String? validateTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefone não pode ser vazio.';
    }

    if (value.trim().length > 12 || value.trim().length < 10) {
      return 'Informe um telefone com DDD, apenas números.';
    }

    int? intValue = int.tryParse(value);

    if (intValue == null || intValue.isNegative) {
      return 'Utilize apenas números.';
    }

    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Usuário não pode ser vazio.';
    }

    if (!RegExp(r"^[a-zA-Z0-9_\.-]+$").hasMatch(value)) {
      return 'Nomes de usuário devem conter apenas letras, números e os caracteres especiais [_ . -]';
    }

    if (value.trim().length > 20) {
      return 'Nome de usuário não pode exceder 20 caracteres.';
    }

    if (value.trim().length < 3) {
      return 'Nome de usuário deve ter ao menos 3 caracteres.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha não pode ser vazia.';
    }

    if (value.trim().length < 6) {
      return 'Senha deve ter ao menos 6 caracteres.';
    }

    return null;
  }

  static String? validatePasswordConfirm(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirmação de senha não pode ser vazia.';
    }

    if (value.trim().length < 6) {
      return 'Confirmação deve ter ao menos 6 caracteres.';
    }

    return null;
  }
}

class UpdateValidations {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length > 40) {
      return 'Nome não pode exceder 40 caracteres.';
    }

    return null;
  }

  static String? validateIdade(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    int? intValue = int.tryParse(value);

    if (intValue == null) {
      return 'Informe um valor numérico.';
    }

    if (intValue > 999 || intValue < 0) {
      return 'Informe um número entre 0 e 999.';
    }

    return null;
  }

  static String? validateEstado(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
      return 'Utilize apenas letras.';
    }

    if (value.trim().length > 2) {
      return 'Favor informar apenas a sigla.';
    }

    return null;
  }

  static String? validateCidade(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length > 30) {
      return 'Cidade não pode exceder 30 caracteres.';
    }

    return null;
  }

  static String? validateEndereco(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length > 50) {
      return 'Endereço não pode exceder 50 caracteres.';
    }

    return null;
  }

  static String? validateTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.trim().length > 12 || value.trim().length < 10) {
      return 'Informe um telefone com DDD, apenas números.';
    }

    int? intValue = int.tryParse(value);

    if (intValue == null || intValue.isNegative) {
      return 'Utilize apenas números.';
    }

    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (!RegExp(r"^[a-zA-Z0-9_\.-]+$").hasMatch(value)) {
      return 'Nomes de usuário devem conter apenas letras, números e os caracteres especiais [_ . -]';
    }

    if (value.trim().length > 20) {
      return 'Nome de usuário não pode exceder 20 caracteres.';
    }

    if (value.trim().length < 3) {
      return 'Nome de usuário deve ter ao menos 3 caracteres.';
    }

    return null;
  }
}

class PetRegisterValidations {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nome não pode ser vazio.';
    }

    if (value.length > 40) {
      return 'Nome não pode exceder 40 caracteres.';
    }

    return null;
  }

  static String? validateDoenca(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe as doenças do animal.';
    }

    if (value.length > 50) {
      return 'Doenças não podem exceder 50 caracteres.';
    }

    return null;
  }

  static String? validateMedicamento(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe o medicamento.';
    }

    if (value.length > 40) {
      return 'Medicamento não pode exceder 40 caracteres.';
    }

    return null;
  }

  static String? validateObjetos(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe os objetos.';
    }

    if (value.length > 50) {
      return 'Objetos não podem exceder 50 caracteres.';
    }

    return null;
  }

  static String? validateSobre(String? value) {
    if (value == null || value.isEmpty) {
      return 'Fale um pouco sobre o animal.';
    }

    if (value.length > 140) {
      return 'História do animal não pode exceder 140 caracteres.';
    }

    return null;
  }
}
