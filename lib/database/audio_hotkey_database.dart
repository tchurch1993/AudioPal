import 'package:audio_pal/database/models/audio_hotkey.dart';
import 'package:audio_pal/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AudioHotKeyDatabase {
  static final AudioHotKeyDatabase instance = AudioHotKeyDatabase._init();

  static Database? _database;

  AudioHotKeyDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('audio_hotkey.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    var databasePath = await getApplicationSupportDirectory();

    final path = join(databasePath.path, filePath);
    return await openDatabase(
      path,
      onCreate: _createDB,
      version: 1,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // create a table with modifiers as a list of integers
    await db.execute(
      'CREATE TABLE audio_hotkey(id INTEGER PRIMARY KEY, modifiers STRING, keyCode INTEGER, deviceName TEXT, deviceGuid TEXT, deviceType INTEGER)',
    );
  }

  Future<int> insertAudioHotKey(AudioHotKey audioHotKey) async {
    final db = await database;
    var res = await db.insert(
      'audio_hotkey',
      audioHotKey.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint('Inserted $res');
    return res;
  }

  Future<List<AudioHotKey>> getAllAudioHotKeys() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('audio_hotkey');
    return List.generate(maps.length, (i) {
      return AudioHotKey(
        id: maps[i]['id'],
        // split the string and map it to a list of KeyModifiers (handle empty list case where if empty return empty list)
        modifiers: (maps[i]['modifiers'] as String)
            .split(',')
            .map((e) => e.isNotEmpty
                ? KeyModifier.values[int.parse(e)]
                : <KeyModifier>[])
            .whereType<KeyModifier>()
            .toList(growable: false),
        keyCode: KeyCode.values[maps[i]['keyCode']],
        deviceName: maps[i]['deviceName'],
        deviceGuid: maps[i]['deviceGuid'],
        deviceType: DeviceType.values[maps[i]['deviceType']],
      );
    });
  }

  Future<void> updateAudioHotKey(AudioHotKey audioHotKey) async {
    final db = await database;
    await db.update(
      'audio_hotkey',
      audioHotKey.toMap(),
      where: 'id = ?',
      whereArgs: [audioHotKey.id],
    );
  }

  Future<void> deleteAudioHotKey(int id) async {
    final db = await database;
    await db.delete(
      'audio_hotkey',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db.delete('audio_hotkey');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
