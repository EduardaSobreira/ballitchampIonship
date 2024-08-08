import 'package:ballet_championship/campeonato.dart';
import 'package:ballet_championship/main.dart';
import 'package:ballet_championship/pages/ResultadosFinaisPage.dart';
import 'package:ballet_championship/time.dart';
import 'package:flutter/material.dart';

class PartidaPage extends StatefulWidget {
  final Time timeA;
  final Time timeB;
  final Function(Time, Time) onFinalizarPartida;
  final Campeonato campeonato;

  PartidaPage({required this.timeA, required this.timeB, required this.onFinalizarPartida, required this.campeonato});

  @override
  _PartidaPageState createState() => _PartidaPageState();
}

class _PartidaPageState extends State<PartidaPage> {
  @override
  void initState() {
    super.initState();
    // Inicializa os pontos dos times com 50 pontos
    widget.timeA.pontos = 50;
    widget.timeB.pontos = 50;
  }

  void _encerrarPartida() {
    Time vencedor;
    Time perdedor;
    if (widget.timeA.pontos > widget.timeB.pontos) {
      vencedor = widget.timeA;
      perdedor = widget.timeB;
    } else if (widget.timeB.pontos > widget.timeA.pontos) {
      vencedor = widget.timeB;
      perdedor = widget.timeA;
    } else {
      // Empate - resolver com "grusht"
      final grushtA = widget.timeA.gritoDeGuerra.length;
      final grushtB = widget.timeB.gritoDeGuerra.length;
      if (grushtA > grushtB) {
        vencedor = widget.timeA;
        vencedor.pontos += 3;
        perdedor = widget.timeB;
      } else {
        vencedor = widget.timeB;
        vencedor.pontos += 3;
        perdedor = widget.timeA;
      }
    }

    widget.onFinalizarPartida(vencedor, perdedor);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ResultadosFinaisPage(campeonato: widget.campeonato)),
    );
  }

  void _adicionarAdvrungh(Time time) {
    setState(() {
      time.advrunghs += 1;
      time.pontos -= 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.timeA.nome} vs ${widget.timeB.nome}'),
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.timeA.nome}: ${widget.timeA.pontos} pontos',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'vs',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  '${widget.timeB.nome}: ${widget.timeB.pontos} pontos',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.timeA.blots += 1;
                      widget.timeA.pontos += 5;
                    });
                  },
                  child: Text('Registrar Blot para ${widget.timeA.nome}', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.timeB.blots += 1;
                      widget.timeB.pontos += 5;
                    });
                  },
                  child: Text('Registrar Blot para ${widget.timeB.nome}', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.timeA.plifs += 1;
                      widget.timeA.pontos += 1;
                    });
                  },
                  child: Text('Registrar Plif para ${widget.timeA.nome}', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.timeB.plifs += 1;
                      widget.timeB.pontos += 1;
                    });
                  },
                  child: Text('Registrar Plif para ${widget.timeB.nome}', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _adicionarAdvrungh(widget.timeA);
                  },
                  child: Text('Registrar Advrungh para ${widget.timeA.nome}', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _adicionarAdvrungh(widget.timeB);
                  },
                  child: Text('Registrar Advrungh para ${widget.timeB.nome}', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _encerrarPartida,
                  child: Text('Encerrar Partida', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
