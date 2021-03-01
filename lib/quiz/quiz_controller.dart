import 'package:mobx/mobx.dart';
part 'quiz_controller.g.dart';

class Controller = QuizController with _$Controller;

abstract class QuizController with Store {
  @observable
  var xcurrentIndex = 0;

  @action
  increment() {
    xcurrentIndex++;
  }
}
