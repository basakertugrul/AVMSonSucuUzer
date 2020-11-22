import 'dart:async';
import 'dart:io';

import 'package:avmv005/Model/favorites.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String _favoritesTable = "favorites";
  String _columnID = "id";
  String _columnImageUrl = "image_url";
  String _columnAvmName = "avm_name";
  String _columnBrandName = "brand_name";
  String _columnInfo = "info";
  String _columnStars = "stars";
  String _columnTitle = "title";

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      print("DBHelpler oluşturuldu");
      return _databaseHelper;
    } else {
      print("var olan DBHelper kullanıldı");
      return _databaseHelper;
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      print("DB oluşturulacak");
      _database = await initializeDatabase();
      return _database;
    } else {
      print("var olan DB kullanıldı");
      return _database;
    }
  }

  initializeDatabase() async {
    Directory klasor = await getApplicationDocumentsDirectory();
    String dbPath = join(klasor.path, "favorites.db");
    print("DB Path : " + dbPath);
    var favoritesDB = openDatabase(dbPath, version: 1, onCreate: _createDB);
    return favoritesDB;
  }

  Future<void> _createDB(Database db, int version) async {
    print("CreateDB methodu çalıştırıldı tablo oluşturulacak!");
    await db.execute(
        "CREATE TABLE $_favoritesTable($_columnID INTEGER PRIMARY KEY AUTOINCREMENT, $_columnImageUrl TEXT, $_columnAvmName TEXT, $_columnBrandName TEXT, $_columnInfo TEXT, $_columnStars TEXT, $_columnTitle TEXT )");
  }

  addFavorites(Favorites favorites) async {
    var db = await _getDatabase();
    var result = await db.insert(_favoritesTable, favorites.toMap(),
        nullColumnHack: "$_columnID");
    return result;
  }

  Future<List<Map<String, dynamic>>> allFavorites() async {
    var db = await _getDatabase();
    var result = await db.query(_favoritesTable, orderBy: "$_columnID DESC");
    return result;
  }

  Future<int> deleteFavorite(String imageUrl) async {
    var db = await _getDatabase();
    var result = await db.delete(_favoritesTable,
        where: "$_columnImageUrl = ? ", whereArgs: [imageUrl]);
    return result;
  }

  Future<int> deleteAll() async {
    var db = await _getDatabase();
    var result = await db.delete(_favoritesTable);
    return result;
  }
}
