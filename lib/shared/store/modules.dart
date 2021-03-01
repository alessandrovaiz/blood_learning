import 'package:blood_learning/shared/models/module_model.dart';
import 'package:blood_learning/shared/models/question_model.dart';

import 'package:blood_learning/shared/store/questions.dart';

List<Module> getModules() {
  List<Module> modules = new List<Module>();
  List<Question> questions = new List<Question>();
  questions = getCellQuestions();

  Module cellModule = new Module(
    moduleName: 'Hemograma',
    questions: questions,
    isCompleted: 0,
    iconImagePath: 'lib/assets/images/module_cell.jpg',
    imagePath: 'lib/assets/images/module_cell.jpg',
  );

  modules.add(cellModule);

  Module cellModule2 = new Module(
    moduleName: 'TEste',
    questions: questions,
    isCompleted: 0,
    iconImagePath: 'lib/assets/images/first_slide.png',
    imagePath: 'lib/assets/images/first_slide.png',
  );

  modules.add(cellModule2);

  return modules;
}
