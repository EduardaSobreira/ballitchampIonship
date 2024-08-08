import 'database_helper.dart';
import 'time.dart';

class Partida {
  int? id;
  Time timeA;
  Time timeB;
  Time? vencedor;
  int blotsA;
  int blotsB;
  int plifsA;
  int plifsB;
  int advrunghsA;
  int advrunghsB;

  Partida({
    this.id,
    required this.timeA,
    required this.timeB,
    this.vencedor,
    this.blotsA = 0,
    this.blotsB = 0,
    this.plifsA = 0,
    this.plifsB = 0,
    this.advrunghsA = 0,
    this.advrunghsB = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timeA': timeA.id,
      'timeB': timeB.id,
      'vencedor': vencedor?.id,
      'blotsA': blotsA,
      'blotsB': blotsB,
      'plifsA': plifsA,
      'plifsB': plifsB,
      'advrunghsA': advrunghsA,
      'advrunghsB': advrunghsB,
    };
  }

  static Future<Partida> fromMap(Map<String, dynamic> map) async {
    Time timeA = await DatabaseHelper().getTimeById(map['timeA']);
    Time timeB = await DatabaseHelper().getTimeById(map['timeB']);
    Time? vencedor = map['vencedor'] != null ? await DatabaseHelper().getTimeById(map['vencedor']) : null;

    return Partida(
      id: map['id'],
      timeA: timeA,
      timeB: timeB,
      vencedor: vencedor,
      blotsA: map['blotsA'],
      blotsB: map['blotsB'],
      plifsA: map['plifsA'],
      plifsB: map['plifsB'],
      advrunghsA: map['advrunghsA'],
      advrunghsB: map['advrunghsB'],
    );
  }
}
