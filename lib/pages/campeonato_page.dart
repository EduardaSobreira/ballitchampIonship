import 'package:ballet_championship/partida.dart';
import 'package:ballet_championship/time.dart';
import 'package:flutter/material.dart';
import 'package:ballet_championship/campeonato.dart';
import 'dart:io';
import 'partida_page.dart';
import 'historico_partidas_page.dart';

class CampeonatoPage extends StatefulWidget {
  final Campeonato campeonato;

  CampeonatoPage({required this.campeonato});

  @override
  _CampeonatoPageState createState() => _CampeonatoPageState();
}

class _CampeonatoPageState extends State<CampeonatoPage> {
  List<List<Time>> partidas = [];

  @override
  void initState() {
    super.initState();
    partidas = widget.campeonato.sortearPartidas();
  }

  void _finalizarPartida(Time vencedor, Time perdedor) {
    setState(() {
      widget.campeonato.registrarPartida(Partida(
        timeA: vencedor,
        timeB: perdedor,
        vencedor: vencedor,
        blotsA: vencedor.blots,
        blotsB: perdedor.blots,
        plifsA: vencedor.plifs,
        plifsB: perdedor.plifs,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campeonato - Fase 1'),
      ),
      body: Stack(
        children: [
          // Adicionando a imagem de fundo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/fundoDragao.png"), // Certifique-se de que o caminho para a imagem esteja correto
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: partidas.length,
                  itemBuilder: (context, index) {
                    final partida = partidas[index];
                    final timeA = partida[0];
                    final timeB = partida[1];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  if (timeA.logo != null)
                                    Image.file(
                                      File(timeA.logo!),
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  SizedBox(width: 8),
                                  Text(timeA.nome),
                                ],
                              ),
                              Text('vs'),
                              Row(
                                children: [
                                  Text(timeB.nome),
                                  SizedBox(width: 8),
                                  if (timeB.logo != null)
                                    Image.file(
                                      File(timeB.logo!),
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PartidaPage(
                                  timeA: timeA,
                                  timeB: timeB,
                                  onFinalizarPartida: _finalizarPartida,
                                  campeonato: widget.campeonato,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoricoPartidasPage(campeonato: widget.campeonato),
                        ),
                      );
                    },
                    child: Text('Histórico de Partidas', style: TextStyle(color: Colors.white)), // Texto do botão branco
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
