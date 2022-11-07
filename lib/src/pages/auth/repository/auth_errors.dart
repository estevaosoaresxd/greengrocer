String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return "Email e/ou senha inválidos.";

    case 'Invalid session token':
      return "Token inválido. \nSessão Expirada.";

    case 'INVALID_FULLNAME':
      return "Ocorreu um erro ao cadastra usuário: Nome inválido";

    case 'INVALID_PHONE':
      return "Ocorreu um erro ao cadastra usuário: Telefone inválido";

    case 'INVALID_CPF':
      return "Ocorreu um erro ao cadastra usuário: CPF inválido";

    default:
      return "Um erro indefinido ocorreu.";
  }
}
