import 'package:ballet_championship/campeonato.dart';
import 'package:ballet_championship/pages/cadastroPremiosPage.dart';
import 'package:ballet_championship/pages/campeonato_page.dart';
import 'package:ballet_championship/time.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CadastroTimesPage extends StatefulWidget {
  @override
  _CadastroTimesPageState createState() => _CadastroTimesPageState();
}

class _CadastroTimesPageState extends State<CadastroTimesPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _gritoController = TextEditingController();
  final _anoController = TextEditingController();
  File? _logo;

  Campeonato campeonato = Campeonato();

  @override
  void initState() {
    super.initState();
    _carregarTimes();
  }

  Future<void> _carregarTimes() async {
    await campeonato.carregarTimes();
    setState(() {});
  }

  Future<void> _escolherLogo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _logo = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  void _cadastrarTime() {
    if (_formKey.currentState!.validate()) {
      if (campeonato.times.length >= 16) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Número máximo de 16 times atingido.')),
        );
        return;
      }

      final time = Time(
        nome: _nomeController.text,
        gritoDeGuerra: _gritoController.text,
        anoDeFundacao: int.parse(_anoController.text),
        logo: _logo?.path,
      );
      campeonato.cadastrarTime(time).then((_) {
        setState(() {
          _nomeController.clear();
          _gritoController.clear();
          _anoController.clear();
          _logo = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Time cadastrado com sucesso!')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar o time: $error')),
        );
      });
    }
  }

  void _excluirTime(Time time) {
    if (time.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir o time: ID inválido.')),
      );
      return;
    }

    campeonato.excluirTime(time).then((_) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Time excluído com sucesso!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir o time: $error')),
      );
    });
  }

  String? _validateAno(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o ano de fundação';
    }
    try {
      int.parse(value);
    } catch (e) {
      return 'Por favor, insira um ano válido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    bool mostrarMensagemPar = campeonato.times.length > 8 && campeonato.times.length % 2 != 0;
    bool mostrarMensagemMinimo = campeonato.times.length < 8;

    return Scaffold(
      backgroundColor: Color(0xFF1C1C1C),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/img/fundo.png"), // Certifique-se de que o caminho para a imagem esteja correto
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'CADASTRO DE TIMES',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 10, 11, 10)),
                          ),
                          SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: _escolherLogo,
                                  child: _logo != null
                                      ? Image.file(
                                          _logo!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          width: 100,
                                          height: 100,
                                          color: Color(0xFF3C3C3C),
                                          child: Center(
                                            child: Text(
                                              'Logo do Time Aqui',
                                              style: TextStyle(color:  Color.fromARGB(255, 255, 255, 255)),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  key: const Key('nomeTimeField'),
                                  controller: _nomeController,
                                  decoration: InputDecoration(
                                    labelText: 'Nome do Time',
                                    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                                    filled: true,
                                    fillColor: Color(0xFF3C3C3C),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, insira o nome do time';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  key: const Key('gritoDeGuerraField'),
                                  controller: _gritoController,
                                  decoration: InputDecoration(
                                    labelText: 'Grito de Guerra',
                                    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                                    filled: true,
                                    fillColor: Color(0xFF3C3C3C),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, insira o grito de guerra';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  key: const Key('anoFundacaoField'),
                                  controller: _anoController,
                                  decoration: InputDecoration(
                                    labelText: 'Ano de Fundação',
                                    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                                    filled: true,
                                    fillColor: Color(0xFF3C3C3C),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.number,
                                  validator: _validateAno,
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _cadastrarTime,
                                  child: Text('Cadastrar Time', style: TextStyle(color: const Color.fromARGB(255, 243, 243, 243))),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Times Cadastrados: ${campeonato.times.length}',
                                  style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                if (mostrarMensagemPar)
                                  Text(
                                    'O número de times deve ser par para o sorteio.',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                if (mostrarMensagemMinimo)
                                  Text(
                                    'O campeonato deve ter pelo menos 8 times.',
                                    style: TextStyle(color: Colors.red),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/campeonato.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Times Cadastrados',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 12, 12, 12)),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListView.builder(
                              itemCount: campeonato.times.length,
                              itemBuilder: (context, index) {
                                final time = campeonato.times[index];
                                return ListTile(
                                  leading: time.logo != null
                                      ? Image.file(File(time.logo!))
                                      : Container(
                                          width: 20,
                                          height: 20,
                                          color: Color.fromARGB(255, 15, 12, 12),
                                          child: Center(
                                            child: Text(
                                              'Foto do Time Aqui',
                                              style: TextStyle(color: const Color.fromARGB(255, 45, 112, 47)),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                  title: Text(time.nome),
                                  subtitle: Text('${time.gritoDeGuerra}, ${time.anoDeFundacao}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => _excluirTime(time),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        if (campeonato.verificarTimes())
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CampeonatoPage(campeonato: campeonato)),
                                );
                              },
                              child: Text('Começar Campeonato', style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                textStyle: TextStyle(fontSize: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
