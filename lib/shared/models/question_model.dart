import 'package:blood_learning/shared/models/answer_model.dart';

class Question {
  int id;
  String desc;

  int isAnswered;
  int isOk;
  int moduleId;
  List<Answer> answers;

  Question({this.id, this.desc, this.isAnswered, this.isOk, this.answers});
//CREATE TABLE QUESTION (ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
// QST_DESCRIPTION TEXT NOT NULL, QST_ISANSWERED integer DEFAULT 0, QST_ISOK integer DEFAULT 0,
// MODULEID integer NOT NULL, FOREIGN KEY(MODULEID) REFERENCES MODULE(ID));');
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ID': id,
      'QST_DESCRIPTION': desc,
      'QST_ISANSWERED': isAnswered,
      'QST_ISOK': isOk,
      'MODULEID': moduleId
    };
    return map;
  }

  Question.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    desc = map['QST_DESCRIPTION'];
    isAnswered = map['QST_ISANSWERED'];
    isOk = map['QST_ISOK'];
    moduleId = map['MODULEID'];
  }
}
