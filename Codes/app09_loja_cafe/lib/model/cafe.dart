/*Modelo de dados que sera usado para encapsular os dados recuperados do Cloud Firestore */

class Cafe {
  //Atributos = campos do documento

  late String id, nome, preco;

  //Construtor
  Cafe(this.id, this.nome, this.preco);

  //Converter Documento em um Objeto
  Cafe.fromJson(Map<String, dynamic> mapa, String id) {
    this.id = id;
    this.nome = mapa['nome'];
    this.preco = mapa['preco'];
  }

//Converte um objeto em um documento
  Map<String, dynamic> toJson() {
    return {'id': this.id, 'nome': this.nome, 'preco': this.preco};
  }
}
