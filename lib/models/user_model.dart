class CreateUserModel {
  CreateUserModel(
      this.nome,
      this.idade,
      this.email,
      this.estado,
      this.cidade,
      this.endereco,
      this.telefone,
      this.username,
      this.password,
      this.passwordConfirm);

  final String nome;
  final String idade;
  final String email;
  final String estado;
  final String cidade;
  final String endereco;
  final String telefone;
  final String username;
  final String password;
  final String passwordConfirm;
}
