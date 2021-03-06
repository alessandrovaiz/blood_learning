import 'package:blood_learning/helpers/db_helper.dart';
import 'package:blood_learning/shared/models/module_model.dart';


var dbHelper = DatabaseHelper();


  Future<List<Module>> getModules() async {
     var dbClient = await dbHelper.db;
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

 void resetModule({int id}) async{
   var dbClient = await dbHelper.db;
    
    await dbClient.rawQuery('UPDATE MODULE SET IS_COMPLETED = 0 WHERE ID = ${id} ');
    await dbClient.rawQuery('UPDATE QUESTION  SET QST_ISANSWERED = 0, QST_ISOK = 0 WHERE MODULEID  IN (SELECT a.ID FROM MODULE a WHERE a.ID = ${id})');
    
  }

  void completeModule({int id,int status}) async {
    var dbClient = await dbHelper.db;
     await dbClient.rawQuery('UPDATE MODULE SET IS_COMPLETED = ${status} WHERE ID = ${id} ');
  }
  


