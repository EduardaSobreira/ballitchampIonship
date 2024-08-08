import 'package:ballet_championship/campeonato.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class HistoricoPartidasPage extends StatelessWidget {
  final Campeonato campeonato;

  HistoricoPartidasPage({required this.campeonato});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Partidas'),
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
          FutureBuilder(
            future: campeonato.carregarPartidas(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: campeonato.historicoDePartidas.length,
                  itemBuilder: (context, index) {
                    final partida = campeonato.historicoDePartidas[index];
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
                                  if (partida.timeA.logo != null)
                                    Image.file(
                                      File(partida.timeA.logo!),
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.cover,
                                    ),
                                  SizedBox(width: 8),
                                  Text(partida.timeA.nome),
                                ],
                              ),
                              Text('vs'),
                              Row(
                                children: [
                                  Text(partida.timeB.nome),
                                  SizedBox(width: 8),
                                  if (partida.timeB.logo != null)
                                    Image.file(
                                      File(partida.timeB.logo!),
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.cover,
                                    ),
                                ],
                              ),
                            ],
                          ),
                          subtitle: Text(
                            'Vencedor: ${partida.vencedor?.nome} | Blots: ${partida.blotsA}-${partida.blotsB} | Plifs: ${partida.plifsA}-${partida.plifsB} | Advrunghs: ${partida.advrunghsA}-${partida.advrunghsB}',
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
