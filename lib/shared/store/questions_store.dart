import 'package:blood_learning/helpers/db_helper.dart';
import 'package:blood_learning/shared/models/answer_model.dart';
import 'package:blood_learning/shared/models/question_model.dart';

var dbHelper = DatabaseHelper();

 Future<List<Question>> getQuestion(int module) async {
   var dbClient = await dbHelper.db;
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


Future<int> answerQuestion({int isAnswered, int isOk, int id}) async {
var dbClient = await dbHelper.db;

    var result = await dbClient.rawQuery(
        'UPDATE QUESTION SET QST_ISANSWERED = ${isAnswered}, QST_ISOK = ${isOk} WHERE ID = ${id} ');

    return result.length;
  }
