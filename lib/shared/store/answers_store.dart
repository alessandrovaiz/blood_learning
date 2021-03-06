
import 'package:blood_learning/helpers/db_helper.dart';
import 'package:blood_learning/shared/models/answer_model.dart';

var dbHelper = DatabaseHelper();



  Future<List<Answer>> getAnswers(int question) async {
     var dbClient = await dbHelper.db;
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

  