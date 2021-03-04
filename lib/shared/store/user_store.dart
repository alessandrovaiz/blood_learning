import 'package:blood_learning/helpers/db_helper.dart';
import 'package:blood_learning/shared/models/user_model.dart';

var dbHelper = DatabaseHelper();

Future<AppUser> getUser() async {
   
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM USER LIMIT 1");
    AppUser user;
    if (maps.length > 0) {
      print(maps.toString());
   
         user = (AppUser.fromMap(maps[0]));
   
      return user;
    }
    else return null;
  }

  void updateIntroduction(int value) async{
    var dbClient = await dbHelper.db;
     await dbClient.rawQuery(
        'UPDATE USER SET USR_ISINTRODUCTIONVIEWED = ${value} WHERE 1=1;');
  }

  void createUser(String name) async { 
    var dbClient = await dbHelper.db;
    await dbClient.rawQuery(
        'INSERT INTO USER(USR_NAME,USR_ISTUTORIALCOMPLETED,USR_ISINTRODUCTIONVIEWED,USR_ISAUTHENTICATED) VALUES ("${name}",0,0,1); ');
  }