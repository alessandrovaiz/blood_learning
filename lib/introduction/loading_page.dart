import 'dart:async';

import 'package:blood_learning/home/home_page.dart';
import 'package:blood_learning/introduction/introduction_controller.dart';
import 'package:blood_learning/introduction/introduction_page.dart';
import 'package:blood_learning/shared/models/user_model.dart';
import 'package:blood_learning/widgets/utils/colors.dart';
import 'package:blood_learning/widgets/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final controller = Controller();
  AppUser user;

  int option = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<AppUser> usr = AppUser.getClientUsr();

    Timer(Duration(seconds: 3), () {
      //usar isso
    });
    usr.then((AppUser user) {
      if (user != null) {
        push(context, HomePage(), replace: true);
      } else {
        push(context, IntroductionPage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors().dark,
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }

  /* getUser() async {
    Observable(controller.getUser());

    print("criar usuario");
    print(user.name);
    Timer.run(() {
      if (user.name == "" || user.name == null) {
        setState(() {
          push(context, IntroductionPage(), replace: true);
        });
      }
      ;
    });

    Timer.run(() {
      if (user.name != "" || user.name != null) {
        setState(() {
          push(context, HomePage(), replace: true);
        });
      }
      ;
    });
  }*/
}
