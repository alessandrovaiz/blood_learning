import 'package:blood_learning/shared/models/user_model.dart';
import 'package:mobx/mobx.dart';
part 'introduction_controller.g.dart';

class Controller = IntroductionController with _$Controller;

abstract class IntroductionController with Store {
  @observable
  var counter = 0;

  @action
  getUser() async {
    var usr = await AppUser.getClientUsr();

    return usr;
  }

  @action
  deleteuser() {
    AppUser.clearClientUsr();
  }

  @action
  saveUser(AppUser user) {
    user.saveUserData(
        name: user.name,
        isIntroductionViewed: user.isIntroductionViewed,
        isTutorialCompleted: user.isTutorialCompleted);
  }

  @action
  increment() {
    counter++;
  }
}
