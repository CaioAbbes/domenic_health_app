import 'package:domenic_health/repositories/orgao_sistema_repository.dart';
import 'package:domenic_health/views/cadastro_artigo_page.dart';
import 'package:flutter/material.dart';
import 'package:domenic_health/repositories/artigo_repository.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ArtigoRepository artigoRepository = ArtigoRepository();
  final OrgaoSistemaRepository orgaoSistemaRepository = OrgaoSistemaRepository();

  List<Map<String, dynamic>> artigos = [];

  @override
  void initState() {
    super.initState();
    carregarArtigos();
  }

  Future<void> carregarArtigos() async {
    try {
      List<Map<String, dynamic>> listaArtigos = await artigoRepository.selecionarArtigos();
      setState(() {
        artigos = listaArtigos;
      });
    } catch (e) {
      print('Erro ao carregar artigos: $e');
    }
  }

  Future<String> obterNomeOrgaoSistema(int idOrgaoSistema) async {
    try {
      Map<String, dynamic> orgaoData = await orgaoSistemaRepository.selecionarOrgaoSistemaId(idOrgaoSistema);
      String nomeOrgao = orgaoData['nome'];
      return nomeOrgao;
    } catch (e) {
      return 'Erro ao obter o nome do orgão do sistema: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text('Lista de Artigos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              carregarArtigos();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: artigos.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artigos[index]['nome'],
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Data de Publicação: ${artigos[index]['data_publicacao']}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Descrição: ${artigos[index]['descricao']}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Autor: ${artigos[index]['autor']}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  FutureBuilder<String>(
                    future: obterNomeOrgaoSistema(artigos[index]['id_orgao_sistema']),
                    builder: (context, snapshot) {
                        return Text(
                          'Categoria: ${snapshot.data}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CadastroArtigo()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
