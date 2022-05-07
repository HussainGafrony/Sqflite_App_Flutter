import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _database;

  Future<Database?> get db async {
    if (_database == null) {
      _database = await initialDb();
      return _database;
    } else {
      return _database;
    }
  }

  initialDb() async {
    String dataBasePathe = await getDatabasesPath();
    String path = join(dataBasePathe, 'liefood.db');
    Database mydb = await openDatabase(path,
        onCreate: onCreate, version: 1, onUpgrade: onUpgrade);
    return mydb;
  }

  onUpgrade(Database database, int oldVersion, int newVersion) async {
    // await database.execute("ALTER TABLE notes ADD COLUMN color TEXT");
    print('DAta Upgrade');
  }

  onCreate(Database database, int version) async {
    // Batch batch = database.batch();
    await database.execute('''
    CREATE TABLE "notes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
    "title" TEXT NOT NULL ,
    "note" TEXT NOT NULL ,
    "color" TEXT NOT NULL
    )          
    ''');
    print("created database and tables");
  }

  // readData(String sql) async {
  //   Database? mydb = await db;
  //   List<Map> response = await mydb!.rawQuery(sql);
  //   return response;
  // }

  // insertData(String sql) async {
  //   Database? mydb = await db;
  //   int response = await mydb!.rawInsert(sql);
  //   return response;
  // }

  // updateData(String sql) async {
  //   Database? mydb = await db;
  //   int response = await mydb!.rawUpdate(sql);
  //   return response;
  // }

  // deleteData(String sql) async {
  //   Database? mydb = await db;
  //   int response = await mydb!.rawDelete(sql);
  //   return response;
  // }

  deleteMyDataBase() async {
    String dataBasePathe = await getDatabasesPath();
    String path = join(dataBasePathe, 'liefood.db');
    await deleteDatabase(path);
  }

  /// package query function

  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insert(String table, Map<String, Object?> value) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, value);
    return response;
  }

  update(String table, Map<String, Object?> value, String myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, value, where: myWhere);
    return response;
  }

  delete(String table, String myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table,where: myWhere);
    return response;
  }
}
