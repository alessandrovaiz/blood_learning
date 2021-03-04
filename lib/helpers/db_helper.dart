import 'dart:async';
import 'dart:io' as io;

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
    await db.execute(
        'INSERT INTO MODULE(ID, MOD_NAME, IS_COMPLETED, MOD_ICONIMGPATH, MOD_IMAGEPATH) VALUES (1, "Hemograma", 0, "lib/assets/images/module_cell.jpg", "lib/assets/images/module_cell.jpg");');
    await db.execute(
        'INSERT INTO MODULE(ID, MOD_NAME, IS_COMPLETED, MOD_ICONIMGPATH, MOD_IMAGEPATH) VALUES (2, "Teste", 0, "lib/assets/images/first_slide.png", "lib/assets/images/first_slide.png");');
    await db.execute(
        'INSERT INTO MODULE(ID, MOD_NAME, IS_COMPLETED, MOD_ICONIMGPATH, MOD_IMAGEPATH) VALUES (3, "FOdassee", 0, "lib/assets/images/first_slide.png", "lib/assets/images/first_slide.png");');

    await db.execute(
        'INSERT INTO ANSWER(ID, ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES (1, "19400", 1, 0, 1); ');
    await db.execute(
        'INSERT INTO ANSWER(ID, ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES (2, "12312312", 0, 0, 1);');
    await db.execute(
        'INSERT INTO ANSWER(ID, ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES (3, "231231241", 0, 0, 1);');
    await db.execute(
        'INSERT INTO ANSWER(ID, ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES (4, "31232122", 0, 0, 1);');

    await db.execute(
        'INSERT INTO ANSWER(ID, ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES (5, "19400", 1, 0, 2);');
    await db.execute(
        'INSERT INTO ANSWER(ID, ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES (6, "12312312", 0, 0, 2);');
    await db.execute(
        'INSERT INTO ANSWER(ID, ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES (7, "231231241", 0, 0, 2);');
    await db.execute(
        'INSERT INTO ANSWER(ID, ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES (8, "31232122", 0, 0, 2)');

    await db.execute(
        'INSERT INTO ANSWER(ID, ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES (9, "19400", 0, 0, 3);');
    await db.execute(
        'INSERT INTO ANSWER(ID, ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES (10, "12312312", 0, 0, 3);');
    await db.execute(
        'INSERT INTO ANSWER(ID, ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES (11, "231231241", 0, 0, 3);');
    await db.execute(
        'INSERT INTO ANSWER(ID, ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES (12, "31232122", 1, 0, 3)');

    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (1,"Quantas plaquetas tem o sangue de um humano normal", 1);');
    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (2,"teste", 1);');
    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (3,"xxx", 1);');
    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (4,"Q123asadas1231", 2);');
    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (5,"xxxxxx", 2);');
    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (6,"Q123asadas1231", 2);');
    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (7,"xxxxxx", 2);');

    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (8,"Q123asadas1231", 3);');
    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (9,"xxxxxx", 3);');

    print("table is created");
  }

  DatabaseHelper.internal();

  Future<Module> save(Module module) async {
    var dbClient = await db;
    module.id = await dbClient.insert(moduleTable, module.toMap());
 
    return module;
   
  }


  Future<List<Module>> getModules() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM MODULE");
    List<Module> modules = [];
    if (maps.length > 0) {
      print(maps.toString());
      for (int i = 0; i < maps.length; i++) {
        modules.add(Module.fromMap(maps[i]));
      }

      return modules;
    }
  }

  Future<List<Question>> getQuestion(int module) async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .rawQuery("SELECT * FROM QUESTION where MODULEID = $module");
    List<Question> questions = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        print(maps[i]);
        questions.add(Question.fromMap(maps[i]));
      }
    } else {
      return null;
    }
    return questions;
  }

  Future<List<Answer>> getAnswers(int question) async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .rawQuery("SELECT * FROM ANSWER where QUESTIONID = $question");
    List<Answer> answers = [];
    if (maps.length > 0) {
      print(maps);
      for (int i = 0; i < maps.length; i++) {
        print(maps[i]);
        answers.add(Answer.fromMap(maps[i]));
      }
    } else {
      return null;
    }
    return answers;
  }

  Future<int> answerQuestion({int isAnswered, int isOk, int id}) async {
    var dbClient = await db;

    var result = await dbClient.rawQuery(
        'UPDATE QUESTION SET QST_ISANSWERED = ${isAnswered}, QST_ISOK = ${isOk} WHERE ID = ${id} ');

    return result.length;
  }

  void completeModule({int id,int status}) async {
    var dbClient = await db;
     await dbClient.rawQuery('UPDATE MODULE SET IS_COMPLETED = ${status} WHERE ID = ${id} ');
  }
  
  void resetModule({int id}) async{
    var dbClient = await db;
    await dbClient.rawQuery('UPDATE MODULE SET IS_COMPLETED = 0 WHERE ID = ${id} ');
    await dbClient.rawQuery('UPDATE QUESTION  SET QST_ISANSWERED = 0, QST_ISOK = 0 WHERE MODULEID  IN (SELECT a.ID FROM MODULE a WHERE a.ID = MODULEID)');
    
  }

  Future<Chart> getChart({int moduleId, String moduleName}) async { 

    var dbClient = await db;
    var rightAnswers = await dbClient.rawQuery('SELECT COUNT(*) as correctAnswers FROM QUESTION f WHERE f.MODULEID = ${moduleId} AND f.QST_ISOK = 1 ');
    var wrongAnswers = await dbClient.rawQuery('SELECT COUNT(*) as wrongAnswers FROM QUESTION f WHERE f.MODULEID = ${moduleId} AND f.QST_ISOK = 0');
   
    var qtdR;
    var qtdWr;
    fromMapRGANSWS(Map<String, dynamic> map) {
    qtdR = map['correctAnswers'];
  }
    fromMapRGANSWS(rightAnswers[0]);

    //Converte as questoes erradas
    fromMapWRANSWS(Map<String, dynamic> map) {
    qtdWr = map['wrongAnswers'];
  } 
    fromMapWRANSWS(wrongAnswers[0]);
    
    print(moduleName + rightAnswers.toString());
    print(moduleName + wrongAnswers.toString());
    if(rightAnswers.length >0 && qtdR != null && qtdWr != null) { 
      return new Chart(wrongAnswers: qtdWr.toString() ?? '0',correctAnswers: qtdR.toString() ?? '0' , moduleName: moduleName);
    } else { 
      return null;
    }
    
    
  }

  reset() async { 
    var dbClient = await db;
    await dbClient.rawQuery('UPDATE MODULE SET IS_COMPLETED = 0 WHERE 1=1  ');
    await dbClient.rawQuery('UPDATE QUESTION  SET QST_ISANSWERED = 0, QST_ISOK = 9 WHERE 1=1');
    await dbClient.rawQuery('DELETE FROM USER WHERE 1=1');

  }

   delete(int id) async {
    var dbClient = await db;
     return await dbClient
        .delete(moduleName, where: '$moduleId = ?', whereArgs: [id]);
  }

   update(Module module) async {
    var dbClient = await db;
    return await dbClient.update(moduleName, module.toMap(),
        where: '$moduleId = ?', whereArgs: [module.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
