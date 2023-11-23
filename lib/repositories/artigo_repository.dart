import 'dart:convert';
import 'package:domenic_health/api/api.dart';
import 'package:domenic_health/models/artigo.dart';
import 'package:http/http.dart' as http; 

/// Classe responsável por interagir com a API para operações relacionadas aos artigos.
class ArtigoRepository {

  /// Método assíncrono que faz uma requisição para inserir um novo artigo na API.
  Future<void> inserirArtigo(Artigo artigo) async {
    final response = await http.post(
      Uri.parse('${Api.endpoint}/inserir_artigo'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(artigo.toMap()), 
    );

    if (response.statusCode != 200) {
      // Lança uma exceção em caso de falha na requisição.
      throw Exception('Falha ao inserir o artigo');
    }
  }

  /// Método assíncrono que faz uma requisição para obter a lista de artigos da API.
  Future<List<Map<String, dynamic>>> selecionarArtigos() async {
    final response = await http.get(Uri.parse('${Api.endpoint}/selecionar_artigos'));

    if (response.statusCode == 200) {
      // Decodifica o corpo da resposta JSON em uma lista de mapas.
      List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      // Lança uma exceção em caso de falha na requisição.
      throw Exception('Falha ao buscar os artigos');
    }
  }

  /// Método assíncrono que faz uma requisição para obter um artigo da API por ID.
  Future<Map<String, dynamic>> selecionarArtigoPorId(int idArtigo) async {
    final response = await http.get(
      Uri.parse('${Api.endpoint}/selecionar_artigo_id?id_artigo=$idArtigo'),
    );

    if (response.statusCode == 200) {
      // Decodifica o corpo da resposta JSON em um mapa.
      return jsonDecode(response.body);
    } else {
      // Lança uma exceção em caso de falha na requisição.
      throw Exception('Falha ao buscar o artigo por ID');
    }
  }
}
