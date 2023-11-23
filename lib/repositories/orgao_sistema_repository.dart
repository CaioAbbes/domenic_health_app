import 'dart:convert';

import 'package:http/http.dart' as http; 
import 'package:domenic_health/api/api.dart';

/// Classe responsável por interagir com a API para operações relacionadas aos órgão_sistema
class OrgaoSistemaRepository {
  
  /// Método assíncrono que faz uma requisição para obter a lista de órgão_sistema.
  Future<List<Map<String, dynamic>>> selecionarOrgaoSistema() async {
    final response = await http.get(Uri.parse('${Api.endpoint}/selecionar_orgao_sistema'));

    if (response.statusCode == 200) {
      // Decodifica o corpo da resposta JSON em uma lista de mapas.
      List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      // Lança uma exceção em caso de falha na requisição.
      throw Exception('Falha ao buscar os órgão_sistema');
    }
  }

  /// Método assíncrono que faz uma requisição para obter um órgão_sistema por ID.
  Future<Map<String, dynamic>> selecionarOrgaoSistemaId(int idOrgaoSistema) async{
    final response = await http.get(
      Uri.parse('${Api.endpoint}/selecionar_orgao_sistema_id?id_orgao_sistema=$idOrgaoSistema'),
    );

    if (response.statusCode == 200) {
      // Decodifica o corpo da resposta JSON em um mapa.
      return jsonDecode(response.body);
    } else {
      // Lança uma exceção em caso de falha na requisição.
      throw Exception('Falha ao buscar o órgão_sistema por ID');
    }
  }

}
