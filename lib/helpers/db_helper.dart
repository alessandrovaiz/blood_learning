import 'dart:async';
import 'dart:io' as io;

import 'package:blood_learning/helpers/insert_scripts/module1.dart';
import 'package:blood_learning/helpers/insert_scripts/module2.dart';
import 'package:blood_learning/helpers/insert_scripts/module3.dart';
import 'package:blood_learning/helpers/insert_scripts/module4.dart';
import 'package:blood_learning/shared/models/answer_model.dart';
import 'package:blood_learning/shared/models/chart_model.dart';
import 'package:blood_learning/shared/models/module_model.dart';
import 'package:blood_learning/shared/models/question_model.dart';
import 'package:blood_learning/shared/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert' as convert;

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  static DatabaseHelper _databaseHelper;
  static Database _database;
  static const String DB_NAME = 'blood_learning.db';

  String moduleTable = 'module';
  String moduleId = 'id';
  String moduleName = 'mod_name';
  String isCompleted = 'mod_iscompleted';
  String questionsTable = 'mod_questionsTable';
  String iconImagePath = 'mod_iconImagePath';
  String imagePath = 'mod_imagePath';

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  _onCreate(Database db, int version) async {

    await db.execute('CREATE TABLE USER (ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, USR_NAME TEXT NOT NULL, USR_ISINTRODUCTIONVIEWED integer DEFAULT 0 NOT NULL, USR_ISAUTHENTICATED integer DEFAULT 0 NOT NULL, USR_ISTUTORIALCOMPLETED integer NOT NULL);');
    await db.execute(
        'CREATE TABLE ANSWER (ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ANS_DESCRIPTION TEXT NOT NULL, ANS_ISRIGHTANSWER integer DEFAULT 0 NOT NULL, ANS_SELECTED integer DEFAULT 0, QUESTIONID integer NOT NULL, FOREIGN KEY(QUESTIONID) REFERENCES QUESTION(ID));');
    await db.execute(
        'CREATE TABLE MODULE (ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, MOD_NAME TEXT NOT NULL, IS_COMPLETED integer DEFAULT 0 NOT NULL, MOD_ICONIMGPATH TEXT, MOD_IMAGEPATH TEXT);');
    await db.execute(
        'CREATE TABLE QUESTION (ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, QST_DESCRIPTION TEXT NOT NULL, QST_ISANSWERED integer DEFAULT 0, QST_ISOK integer DEFAULT 9, MODULEID integer NOT NULL, FOREIGN KEY(MODULEID) REFERENCES MODULE(ID));');
    
    

    createModule1(db);
    createModule2(db);
    createModule3(db);
    createModule4(db);
    

    print("table is created");
  }

  DatabaseHelper.internal();

  completeTutorial() async { 
    var dbClient = await db;
    await dbClient.rawQuery('UPDATE USER SET USR_ISINTRODUCTIONVIEWED = 1 WHERE 1=1  ');
  }

  reset() async { 
    var dbClient = await db;
    await dbClient.rawQuery('UPDATE MODULE SET IS_COMPLETED = 0 WHERE 1=1  ');
    await dbClient.rawQuery('UPDATE QUESTION  SET QST_ISANSWERED = 0, QST_ISOK = 9 WHERE 1=1');
    await dbClient.rawQuery('DELETE FROM USER WHERE 1=1');
   
  }

 

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
