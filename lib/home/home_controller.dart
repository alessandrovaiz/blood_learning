import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class Controller = HomeController with _$Controller;

abstract class HomeController with Store {
  @observable
  var counter = 0;

  @action
  increment() {
    counter++;
  }
}
