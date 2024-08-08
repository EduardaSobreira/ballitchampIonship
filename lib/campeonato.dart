import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'time.dart';
import 'database_helper.dart';
import 'partida.dart';

class Campeonato {
  List<Time> times = [];
  List<Partida> historicoDePartidas = [];
  String? premioPrimeiroLugar;
  String? premioSegundoLugar;
  String? premioTerceiroLugar;

  Future<void> cadastrarTime(Time time) async {
    if (times.length >= 16) {
      throw Exception('Número máximo de 16 times atingido.');
    }
    if (kIsWeb) {
      // Armazenar em memória para a web
      times.add(time);
    } else {
      // Usar sqflite para armazenamento no desktop
      await DatabaseHelper().insertTime(time);
      times.add(time);
    }
  }

  Future<void> carregarTimes() async {
    if (kIsWeb) {
      // Carregar de memória para a web
      // times = ...; // Se precisar de persistência entre sessões, implemente armazenamento local (ex: shared_preferences)
    } else {
      // Carregar do banco de dados no desktop
      times = await DatabaseHelper().getTimes();
    }
  }

  bool verificarTimes() {
    return times.length >= 8 && times.length % 2 == 0;
  }

  List<List<Time>> sortearPartidas() {
    times.shuffle();
    List<List<Time>> partidas = [];
    for (int i = 0; i < times.length; i += 2) {
      partidas.add([times[i], times[i + 1]]);
    }
    return partidas;
  }

  Future<void> registrarPartida(Partida partida) async {
    if (kIsWeb) {
      // Armazenar em memória para a web
      historicoDePartidas.add(partida);
    } else {
      // Usar sqflite para armazenamento no desktop
      await DatabaseHelper().insertPartida(partida);
      historicoDePartidas.add(partida);
    }
  }

  Future<void> carregarPartidas() async {
    if (kIsWeb) {
      // Carregar de memória para a web
      // historicoDePartidas = ...; // Se precisar de persistência entre sessões, implemente armazenamento local (ex: shared_preferences)
    } else {
      // Carregar do banco de dados no desktop
      historicoDePartidas = await DatabaseHelper().getPartidas();
    }
  }

  Future<void> excluirTime(Time time) async {
    if (time.id == null) {
      throw Exception('ID do time é inválido.');
    }
    if (kIsWeb) {
      // Remover da memória para a web
      times.remove(time);
    } else {
      // Usar sqflite para remoção no desktop
      await DatabaseHelper().deleteTime(time.id!);
      times.remove(time);
    }
  }

  bool verificarCampeonatoTerminado() {
    return times.length == 1;
  }

  void avancarParaProximaFase() {
    List<Time> vencedores = historicoDePartidas.map((partida) => partida.vencedor!).toList();
    times = vencedores;
    historicoDePartidas.clear();
  }

  void definirPremios(String primeiro, String segundo, String terceiro) {
    premioPrimeiroLugar = primeiro;
    premioSegundoLugar = segundo;
    premioTerceiroLugar = terceiro;
  }
}
