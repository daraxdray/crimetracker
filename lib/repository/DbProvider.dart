import 'dart:developer';
import 'dart:io';
import 'package:crimetracker/model/crime.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  DbProvider._();
  static final DbProvider db = DbProvider._();
  static String eventTable = "EVENT";
  static var _database;
  static var databasePath;
  Future<Database> get database async {
    _database = null;
    if(_database != null){
      return _database;
    }
  print("HERE2");
    _database = await initDB();
    return _database;
  }


  initDB() async {

      databasePath = await getDatabasesPath();
      var path =  join(databasePath,'crime_db');
      _database = await openDatabase(
          path,
          version: 1,
          onCreate: (Database db,int version) async{
            await db.execute('''      
     CREATE TABLE $eventTable ( eid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
     eName TEXT NOT NULL,
     eDescription TEXT NOT NULL,
     eLocation TEXT NOT NULL,
     eCurrLocation TEXT NOT NULL,
     eImg TEXT NULL,
     eImg2 TEXT NULL,
     eImg3 TEXT NULL,
     dateCreated TEXT NOT NULL
    )
    ''');
          },
      );
      return _database;
    }

  Future<Crime> insertDb(Crime data) async {
    Database db = await database;
    data.id = await db.insert(eventTable,data.toMap());
    return data;
  }


  Future<List<Crime>> getAllEvents() async {
    Database db = await database;

    List<Map> result;
    result = await db.query(eventTable);
    print(result);
    List<Crime> cr = result.isNotEmpty? result.map((e) => Crime.fromDb(e)).toList():[];
    return cr;
  }


   getEventById({id:0}) async  {
    Database db = await database;
    List<Map> result;
    if(id == 0){
      return  null;
    }else
    {
      result = await db.query(eventTable,
          where: 'id = $id',
          whereArgs: [id]);
      if(result.length >0 ){
        return  Crime.fromMap(result.first);
      }
    }



  }


  Future<int> deleteEvent(id) async {
    Database db = await database;
    return await  db.delete(eventTable,where: 'id == $id',whereArgs: [id]);
  }

  Future update(Crime event) async {
    Database db = await database;
    var update = db.update(eventTable, event.toMap(),where: 'id == ${event.id}', whereArgs: [event.id] );
  }

  Future close() async => db.close();


}

