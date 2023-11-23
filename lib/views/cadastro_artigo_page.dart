import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:domenic_health/models/artigo.dart';
import 'package:domenic_health/repositories/artigo_repository.dart';
import 'package:domenic_health/repositories/orgao_sistema_repository.dart';
import 'package:domenic_health/views/home_page.dart';

class CadastroArtigo extends StatefulWidget {
  const CadastroArtigo({Key? key}) : super(key: key);

  @override
  State<CadastroArtigo> createState() => _CadastroArtigoState();
}

class _CadastroArtigoState extends State<CadastroArtigo> {
  late TextEditingController _nomeController;
  late TextEditingController _descricaoController;
  late TextEditingController _autorController;
  late DateTime _dataPublicacao;
  late List<Map<String, dynamic>> _orgaos; // Lista para armazenar os órgãos
  Map<String, dynamic>? _orgaoSelecionado; // Órgão selecionado no DropDown

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _descricaoController = TextEditingController();
    _autorController = TextEditingController();
    _dataPublicacao = DateTime.now();
    _orgaos = []; // Inicializa a lista de órgãos vazia
    _carregarOrgaos(); // Chama o método para carregar os órgãos
  }

  // Método para carregar os órgãos
  void _carregarOrgaos() async {
    OrgaoSistemaRepository orgaoRepository = OrgaoSistemaRepository();
    List<Map<String, dynamic>> orgaos = await orgaoRepository.selecionarOrgaoSistema();
    setState(() {
      _orgaos = orgaos;
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _autorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text('Cadastro de Artigo'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _descricaoController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: TextEditingController(
                    text: DateFormat('dd/MM/yyyy').format(_dataPublicacao),
                  ),
                  decoration: const InputDecoration(labelText: 'Data de Publicação'),
                  onTap: () async {
                    DateTime? pickedDate = (await showDatePicker(
                      context: context,
                      initialDate: _dataPublicacao,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    ));
                    if (pickedDate == null) {
                      pickedDate = _dataPublicacao;
                    } else if (pickedDate != _dataPublicacao) {
                      setState(() {
                        _dataPublicacao = pickedDate as DateTime;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _autorController,
                  decoration: const InputDecoration(labelText: 'Autor'),
                ),
                const SizedBox(height: 16.0),
                Container(
                  width: double.infinity, // Define a largura máxima
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Órgão',
                          border: OutlineInputBorder(),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Map<String, dynamic>>(
                            value: _orgaoSelecionado,
                            items: _orgaos.map((orgao) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: orgao,
                                child: Text(orgao['nome']),
                              );
                            }).toList(),
                            onChanged: (orgao) {
                              setState(() {
                                _orgaoSelecionado = orgao;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Artigo artigo = Artigo(
                      nome: _nomeController.text,
                      descricao: _descricaoController.text,
                      dataPublicacao: DateFormat('dd/MM/yyyy').format(_dataPublicacao),
                      autor: _autorController.text,
                      idOrgaoSistema: _orgaoSelecionado!['id_orgao_sistema'],
                    );
                    ArtigoRepository artigoRepository = ArtigoRepository();
                    artigoRepository.inserirArtigo(artigo);
                    artigoRepository.selecionarArtigos();

                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(200, 50),
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
