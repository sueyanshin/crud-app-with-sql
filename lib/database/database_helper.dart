import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database _db;
  static const String tableName = "student";

  DatabaseHelper() {
    _createDatabase();
  }
  // create database
  Future<Database> _createDatabase() async {
    var dataPath = await getDatabasesPath();
    String path = join(dataPath, '$tableName.db');
    _db = await openDatabase(path);
    await _db.execute(
        'CREATE TABLE IF NOT EXISTS $tableName(id INTEGER PRIMARY KEY,name TEXT,address TEXT,phone TEXT,email TEXT)');
    return _db;
  }

// insert
  Future<int> insertStudent(Map<String, dynamic> student) async {
    _db = await _createDatabase();
    return await _db.insert(tableName, student);
  }

//read
  Future<List<Map<String, dynamic>>> getAllStudents() async {
    _db = await _createDatabase();
    return await _db
        .query(tableName, columns: ['id', 'name', 'address', 'phone', 'email']);
  }

// update
  Future<int> updateStudent(Map<String, dynamic> student, int id) async {
    _db = await _createDatabase();
    return await _db.update(tableName, student, where: "id=?", whereArgs: [id]);
  }

  //delete
  Future<int> deleteStudent(int id) async {
    _db = await _createDatabase();
    return await _db.delete(tableName, where: "id=?", whereArgs: [id]);
  }

  Future<int> delete() async {
    _db = await _createDatabase();
    return await _db.rawDelete("DELETE FROM $tableName");
  }
}
