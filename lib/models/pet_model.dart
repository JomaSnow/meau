class CreatePetModel {
  CreatePetModel(
    this.nome,
    this.especie,
    this.sexo,
    this.porte,
    this.idade,
    this.temperamento,
    this.saude,
    this.doencas,
    this.exigencias,
    this.sobre,
    this.ownerId,
    this.isAdopt,
    this.isFoster,
    this.isHelp,
  );

  final String nome;
  final String especie;
  final String sexo;
  final String porte;
  final String idade;
  final String temperamento;
  final String saude;
  final String doencas;
  final String exigencias;
  final String sobre;
  final String ownerId;
  final bool isAdopt;
  final bool isFoster;
  final bool isHelp;
}
