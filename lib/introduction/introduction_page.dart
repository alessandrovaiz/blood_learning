import 'package:blood_learning/helpers/db_helper.dart';
import 'package:blood_learning/home/home_page.dart';

import 'package:blood_learning/shared/models/module_model.dart';
import 'package:blood_learning/shared/models/slide_model.dart';
import 'package:blood_learning/shared/models/user_model.dart';
import 'package:blood_learning/shared/store/user_store.dart';
import 'package:blood_learning/widgets/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:blood_learning/introduction/banners/slides.dart';
import 'package:blood_learning/widgets/button.dart';
import 'package:blood_learning/widgets/utils/colors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _tName = TextEditingController();
  bool _load= false;
  AppUser user;
  DatabaseHelper dbHelper;
  @override
  void initState() {
    super.initState();
    getuser();
    /* Future<AppUser> usr = AppUser.getClientUsr();
    usr.then((AppUser user) {
      if (user != null) {
        push(context, HomePage(), replace: true);
      }
    });**/
  }

  getuser() async { 
    user = await _getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: !_load? Container(
        padding: EdgeInsets.only(left: 32, right: 32),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors().secondaryDark,
        child: Column(
          children: [_buildLogo(), _buildTitle(), _buildBottom()],
        ),
      ) : Container(
        color: AppColors().light,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Padding _buildLogo() {
    return Padding(
      padding: EdgeInsets.only(top: 140, bottom: 32),
      child: Icon(
        Icons.ac_unit,
        size: 80,
        color: AppColors().lowLight,
      ),
    );
  }

  _buildTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Aprenda",
              style: TextStyle(
                  fontSize: 34,
                  color: AppColors().light,
                  fontFamily: 'Montserrat-SemiBold'),
            ),
            Text("com o bLearn",
                style: TextStyle(
                    fontSize: 34,
                    color: AppColors().light,
                    fontFamily: 'Montserrat-SemiBold'))
          ],
        )
      ],
    );
  }

  _buildBottom() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                validator: _validateName,
                onChanged: (value) {
                  setState(() {});
                },
                style: TextStyle(color: AppColors().light),
                textAlign: TextAlign.start,
                controller: _tName,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Qual é o seu nome?',
                  labelStyle: TextStyle(
                      color: AppColors().light,
                      fontSize: 18,
                      fontFamily: 'Montserrat-Regular'),
                  contentPadding: EdgeInsets.all(16),
                  fillColor: AppColors().lowLight,
                ),
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width * 0.4,
                child: AppButton(
                  "Continuar >",
                  () async{
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                   await createUser(_tName.text);
                    push(context, Slides());
                  },
                  outlineBtn: false,
                  textColor: AppColors().secondaryDark,
                  color: AppColors().lowLight,
                )),
          ],
        )
      ],
    );
  }

  String _validateName(String text) {
    if (text.isEmpty) {
      return "Informe o nome!";
    }
    if (text.length < 3) {
      return "O nome deve ter pelo menos 3 caracteres";
    }

    return null;
  }

  Future<AppUser> _getUser() async {
 

    await getUser().then((value) {
      user = value;
      setState(() {
        _load=false;
        if (user!= null) {
         push(context,Slides());
         
        } else {
         
          return;
        }
      });
    });
  

    return user;
  }


}
