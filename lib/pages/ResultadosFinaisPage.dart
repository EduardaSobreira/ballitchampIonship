import 'package:ballet_championship/campeonato.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ResultadosFinaisPage extends StatelessWidget {
  final Campeonato campeonato;

  const ResultadosFinaisPage({required this.campeonato});

  @override
  Widget build(BuildContext context) {
    campeonato.times.sort((a, b) => b.pontos.compareTo(a.pontos));
    final campeao = campeonato.times.isNotEmpty ? campeonato.times[0] : null;
    final segundoLugar = campeonato.times.length > 1 ? campeonato.times[1] : null;
    final terceiroLugar = campeonato.times.length > 2 ? campeonato.times[2] : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados Finais'),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Time')),
                        DataColumn(label: Text('Blots')),
                        DataColumn(label: Text('Plifs')),
                        DataColumn(label: Text('Advrunghs')),
                        DataColumn(label: Text('Pontos')),
                      ],
                      rows: campeonato.times.map((time) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Row(
                                children: [
                                  if (time.logo != null)
                                    Image.file(
                                      File(time.logo!),
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  SizedBox(width: 8),
                                  Text(time.nome),
                                ],
                              ),
                            ),
                            DataCell(Text(time.blots.toString())),
                            DataCell(Text(time.plifs.toString())),
                            DataCell(Text(time.advrunghs.toString())),
                            DataCell(Text(time.pontos.toString())),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(width: 50), // Espaço entre a tabela e a coluna de texto
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      if (campeao != null) ...[
                        Text(
                          'Grito de Guerra do Campeão: ${campeao.gritoDeGuerra}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20), // Espaço entre o grito de guerra e os prêmios
                      ],
                      Text(
                        'Prêmios:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      if (campeao != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.emoji_events, color: Colors.amber),
                            SizedBox(width: 8),
                            Text(
                              '1º Lugar: ${campeao.nome} - R\$2000',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      if (segundoLugar != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.emoji_events, color: Colors.grey),
                            SizedBox(width: 8),
                            Text(
                              '2º Lugar: ${segundoLugar.nome} - R\$1000',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      if (terceiroLugar != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.emoji_events, color: Colors.brown),
                            SizedBox(width: 8),
                            Text(
                              '3º Lugar: ${terceiroLugar.nome} - R\$500',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
