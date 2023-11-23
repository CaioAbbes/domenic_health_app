/// Classe que representa um artigo.
class Artigo {
  
  /// Identificador único do artigo.
  int? idArtigo;
  
  /// Nome do artigo.
  String nome;
  
  /// Descrição do artigo.
  String descricao;
  
  /// Data de publicação do artigo.
  String dataPublicacao;
  
  /// Autor do artigo.
  String autor;
  
  /// Identificador do órgão ou sistema associado ao artigo.
  int idOrgaoSistema;

  /// Construtor para criar uma instância de Artigo.
  Artigo({
    this.idArtigo,
    required this.nome,
    required this.descricao,
    required this.dataPublicacao,
    required this.autor,
    required this.idOrgaoSistema,
  });

  /// Construtor alternativo para criar uma instância de Artigo a partir de um mapa de dados.
  Artigo.fromMap(Map<String, dynamic> map) :
        idArtigo = map['id_artigo'],
        nome = map['nome'],
        descricao = map['descricao'],
        dataPublicacao = map['data_publicacao'],
        autor = map['autor'],
        idOrgaoSistema = map['id_orgao_sistema'];
  
  /// Método que converte a instância de Artigo para um mapa de dados.
  Map<String, dynamic> toMap() {
    return {
      'id_artigo': idArtigo,
      'nome': nome,
      'descricao': descricao,
      'data_publicacao': dataPublicacao,
      'autor': autor,
      'id_orgao_sistema': idOrgaoSistema
    };
  }
}
