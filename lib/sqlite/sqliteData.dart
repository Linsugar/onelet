import 'package:sqflite/sqflite.dart';

class Mysqlite {
 final sqlFileName = 'jiazu.sql';
 final  table = 'home';
 late Database db;
 sqlinit()async{
//   获取本地保存路径
    var databasePath = await getDatabasesPath();
    String dbpath = databasePath+ '/$sqlFileName';
    print("创建数据库");
    db = await openDatabase(dbpath,version:1,onCreate: (db,ver)async{
     await db.execute('''
      Create Table $table(
      url text,
      title text
      )
      ''');
    });
 }

 insert(Map<String,dynamic> homedata)async{
  print("插入数据");
   await db.insert(table, homedata);
 }

 queryAll()async{
// colums 为null 时 意味着返回全部数据
  return db.query(table,columns: null);
 }
}