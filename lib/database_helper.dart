import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'time.dart';
import 'partida.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    if (kIsWeb) {
      return await _initInMemoryDatabase();
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'ballit_championship.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<Database> _initInMemoryDatabase() async {
    return await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE times (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        gritoDeGuerra TEXT,
        anoDeFundacao INTEGER,
        logo TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE partidas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        timeA INTEGER,
        timeB INTEGER,
        vencedor INTEGER,
        blotsA INTEGER,
        blotsB INTEGER,
        plifsA INTEGER,
        plifsB INTEGER,
        advrunghsA INTEGER,
        advrunghsB INTEGER,
        FOREIGN KEY (timeA) REFERENCES times (id),
        FOREIGN KEY (timeB) REFERENCES times (id),
        FOREIGN KEY (vencedor) REFERENCES times (id)
      )
    ''');
  }

  Future<void> insertTime(Time time) async {
    final db = await database;
    int id = await db.insert('times', time.toMap());
    time.id = id; // Garantindo que o id é atualizado após a inserção
  }

  Future<List<Time>> getTimes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('times');
    return List.generate(maps.length, (i) {
      return Time.fromMap(maps[i]);
    });
  }

  Future<void> deleteTime(int id) async {
    final db = await database;
    await db.delete('times', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> insertPartida(Partida partida) async {
    final db = await database;
    await db.insert('partidas', partida.toMap());
  }

  Future<List<Partida>> getPartidas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('partidas');
    return List.generate(maps.length, (i) async {
      return await Partida.fromMap(maps[i]);
    } as Partida Function(int index));
  }

  Future<Time> getTimeById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('times', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Time.fromMap(maps.first);
    } else {
      throw Exception('Time não encontrado com id $id');
    }
  }
}
