 import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static Database?
      _db; //this help us to determind if database has been intailized or not if db is empty we will call method initailzation else return db dirctory

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialdb();
      return _db;
    } else {
      return _db;
    }
  }

  intialdb() async {
    String Db_Path = await getDatabasesPath();
    String path =
        join(Db_Path, "MyDtatBase.db"); //return databse AND name =>full path
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 4);

    return mydb;
  }

  _onCreate(
    Database db,
    int version,
  ) async {
    Batch batch = db.batch();
    //this function to create database and create table
    batch.execute('''
CREATE TABLE "notes"(
  "id" INTEGER NOT NULL PRIMARY KEY  AUTOINCREMENT,
   "title"  TEXT  ,
   "color"   TEXT   ,
  "note"  TEXT 
)
''');
    await batch.commit();

    print('created');
  }

//   OnUpGrade(Database db, int version, int NewVersion) async {
//     //this function  help us to add column
//     await db.execute('''
// ALTER TABLE notes ADD COLUMN color TEXT
// ''');

//     print('onupgrade');
//   }

  readData(String SQL) async {
    Database? mydb = await db;
    List<Map> respose =
        await mydb!.rawQuery(SQL); //rawQuery special for  sRelection
    return respose;
  }

  insertData(String SQL) async {
    Database? mydb = await db;
    int respose = await mydb!.rawInsert(SQL);
    return respose;
  }

  deleteData(String SQL) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(SQL);
    return response;
  }

  upDateData(String SQL) async {
    Database? mydb = await db;
    int respose = await mydb!.rawUpdate(SQL);
    return respose;
  }

  DeleteDb() async {
    // delete database
    String Db_Path = await getDatabasesPath();
    String path = join(Db_Path, "MyDtatBase.db");
    await deleteDatabase(path);
  }
}


  // Positioned(
                                        //   top: 70,
                                        //   left: 10,
                                        //   child: Text(
                                        //     "${snapshot.data![index]['note']}",
                                        //     style: const TextStyle(
                                        //         fontSize: 17,
                                        //         fontWeight: FontWeight.w300,
                                        //         fontStyle: FontStyle.italic),
                                        //   ),
                                        // )


                                        //  Positioned(
                                        //     bottom: 10,
                                        //     right: 10,
                                        //     child: IconButton(
                                        //         onPressed: () {
                                        //           db.deleteData(
                                        //               "DELETE FROM notes WHERE id=${snapshot.data![index]['id']} ");
                                        //           setState(() {});
                                        //         },
                                        //         icon: Icon(Icons.delete))),


                                      //    boxShadow:[
                                      // BoxShadow(
                                      //   blurRadius:5,
                                      //    color: Color.fromARGB(255, 202, 184, 184)
                                      // )