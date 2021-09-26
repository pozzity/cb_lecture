library database;

import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;

part 'src/sqlite/sqlite_implemetation.dart';
part 'src/sqlite/lib/sqlite_table.dart';
part 'src/sqlite/lib/sqlite_colum.dart';
part 'src/helper/database_query.dart';
part 'src/fake_sqlite/fake_sqlite_implemetation.dart';

/// Helpers class that help us to retrieve, edit or delete document or
/// Collection from our database.
abstract class Database {

  /// Constructs a new Database instance of [_SQLiteImplementation].
  factory Database.sqlite({
    required List<Table> tables, required String nameDataBase})=>
      _SQLiteImplementation(tables: tables, nameDataBase: nameDataBase);
  
  /// Constructs a new Database instance of [_FakeSqliteImplementation].
  factory Database.fakeSqlite() => _FakeSqliteImplementation();


  /// Retrieves the given collection from the database.
  /// * [collectionPath] The path to the collection to retrieve.
  /// * [filters] The value filters the collection.
  ///   eg: 
  ///    # For no sql implementation.
  ///       - collectionName, filter?
  ///    # For sql implementation.
  ///       - collectionName, filter?
  ///    # For fake sqlite implementation.
  ///       - collectionName : value possible [verse, chant], filter
  /// * return 
  ///     # Succes : Get record in our database as List<Map<String, dynamic>
  ///     # Error : Null
  Future<List<Map<String, dynamic>>?> getCollection(String collectionPath, 
    {List<DatabaseQuery>? filters});

  /// Create collection from the database.
  /// * [collectionPath] the path to the collection to create.
  /// * [recordMap] Value to create.
  /// 
  ///   eg: 
  ///    # For no sql implementation.
  ///       - collection_name, recordMap
  ///    # For  sqlite implementation .
  ///       - table_name, recordMap
  /// * return boolean
  ///     # Succes : true
  ///     # Error : false
  Future<bool> createRecord(
      String collectionPath, Map<String, dynamic> recordMap);

  /// Remove collection from the database.
  /// * [collectionPath] the path to the collection to remove
  /// * [documentId] Id of collection remove.
  ///   eg: 
  ///    # For no sql implementation.
  ///       - collectionName , documentId
  ///    # For sql implementation.
  ///       - tableName , documentId
  /// * return boolean
  ///     # Succes : true
  ///     # Error : false
  Future<bool> removeRecordByPath(
      String collectionPath, int documentId);


  /// Update collection from the database.
  /// * [collectionPath] the path to the collection to update
  /// * [updateMap] Collection update.
  /// * [filters] Filter for find collection update.
  ///   eg: 
  ///    # For no sql implementation.
  ///       - collectionName , documentId
  ///    # For sql implementation.
  ///       - tableName , documentId
  /// * return boolean
  ///     # Succes : true
  ///     # Error : false
  Future<bool> updateRecordByPath(
    String collectionPath, 
    Map<String, dynamic> updateMap, 
    {List<DatabaseQuery>? filters = const <DatabaseQuery>[]});
}
