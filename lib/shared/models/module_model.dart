import 'package:blood_learning/shared/models/question_model.dart';

class Module {
  int id;
  bool isSelected = false;
  String imagePath;
  String iconImagePath;
  String moduleName;
  int isCompleted;
  int questionTable;
  List<Question> questions;

  Module(
      {this.id,
      this.moduleName,
      this.isCompleted,
      this.questions,
      this.iconImagePath,
      this.questionTable,
      this.imagePath});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ID': id,
      'MOD_NAME': moduleName,
      'IS_COMPLETED': isCompleted,
      'MOD_ICONIMGPATH': iconImagePath,
      'MOD_IMGPATH': imagePath
    };
    return map;
  }

  Module.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    moduleName = map['MOD_NAME'];
    isCompleted = map['IS_COMPLETED'];
    iconImagePath = map['MOD_ICONIMGPATH'];
    imagePath = map['MOD_IMGPATH'];
  }
}
