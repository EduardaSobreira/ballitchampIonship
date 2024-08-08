import 'dart:io';

import 'package:ballet_championship/pages/CadastroTimesPage.dart';
import 'package:ballet_championship/pages/ResultadosFinaisPage.dart';
import 'package:ballet_championship/pages/cadastroPremiosPage.dart';
import 'package:ballet_championship/pages/campeonato_page.dart';
import 'package:ballet_championship/partida.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'campeonato.dart';
import 'time.dart';

void main() {
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
  // Inicializa a fábrica de banco de dados para uso no desktop
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(const BallitChampionshipApp());
 }
}

class BallitChampionshipApp extends StatelessWidget {
  const BallitChampionshipApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ballit Championship',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CadastroTimesPage(),
    );
  }
}

