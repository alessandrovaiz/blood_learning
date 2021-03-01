import 'dart:io';

import 'package:blood_learning/helpers/db_helper.dart';
import 'package:blood_learning/home/home_page.dart';
import 'package:blood_learning/quiz/quiz_controller.dart';
import 'package:blood_learning/shared/models/answer_model.dart';
import 'package:blood_learning/shared/models/module_model.dart';
import 'package:blood_learning/shared/models/question_model.dart';
import 'package:blood_learning/widgets/button.dart';

import 'package:blood_learning/widgets/utils/colors.dart';
import 'package:blood_learning/widgets/utils/navigator.dart';

import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

class Quiz extends StatefulWidget {
  int _moduleId;

  Quiz(this._moduleId);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool _visible = false;
  final controller = Controller();
  int currentIndex = 0;
  List<Question> questions = List<Question>();

  bool _load = true;
  PageController _pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getdata();
  }

  getdata() async {
    questions = await _getQuestions(widget._moduleId);
  }

  @override
  Widget build(BuildContext context) {
    return !_load
        ? Scaffold(
            backgroundColor: AppColors().light,
            body: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                  if (currentIndex == questions.length - 1) {
                    _visible = true;
                  } else {
                    _visible = false;
                  }
                  print(currentIndex);
                });
              },
              itemCount: questions.length,
              itemBuilder: (context, i) {
                return _buildQuestionTile(context, i);
              },
            ),
          )
        : Container(
            color: AppColors().lowLight,
            child: Center(child: CircularProgressIndicator()));
  }

  _buildQuestionTile(BuildContext context, int i) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 300,
                height: 80,
                child: Text(
                  questions[i].desc,
                  style: TextStyle(
                      color: AppColors().dark,
                      fontFamily: 'Montserrat-Regular',
                      fontSize: 18,
                      fontWeight: FontWeight.w100),
                )),
            ListView.builder(
                shrinkWrap: true,
                itemCount: questions[i].answers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: _buildQuestionContainer(i, index, context),
                    ),
                    onTap: () {
                      for (Answer m in questions[i].answers) {
                        setState(() {
                          m.selected = false;
                        });
                      }
                      setState(() {
                        questions[i].answers[index].selected = true;
                        questions[i].isAnswered = 1;
                      });

                      if (questions[i].answers[index].isRightAnswer == 1) {
                        questions[i].answers[index].rightAnswered = 1;
                        print("É A RESPOSTA CORRETA!");
                      } else {
                        print("REsposta errada!");
                      }
                      if (currentIndex != questions.length - 1) {
                        setState(() {
                          _pageController.animateToPage(currentIndex + 1,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.linear);
                        });
                      }
                    },
                  );
                }),
            AnimatedOpacity(
                // If the widget is visible, animate to 0.0 (invisible).
                // If the widget is hidden, animate to 1.0 (fully visible).
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                // The green box must be a child of the AnimatedOpacity widget.
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Container(
                      child: AppButton("Confirmar Respostas", () {
                    for (Question m in questions) {
                      if (m.isAnswered == 0) {
                        SweetAlert.show(
                          context,
                          subtitle: "Verifique as questões não respondidas",
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppColors().dark,
                        );
                        return;
                      }
                    }
                    int aux = 0;
                    for (int i = 0; i < questions.length; i++) {
                      for (Answer a in questions[i].answers) {
                        if (a.rightAnswered == 1 && a.selected == true) {
                          DatabaseHelper()
                              .answerQuestion(id: a.id, isAnswered: 1, isOk: 1);
                          aux++;
                        } else if (a.selected == true) {
                          DatabaseHelper()
                              .answerQuestion(id: a.id, isAnswered: 1, isOk: 0);
                        }
                      }
                    }

                    SweetAlert.show(context,
                        subtitle: "Questões acertadas : ${aux}",

                        style: SweetAlertStyle.confirm,
                        confirmButtonColor: AppColors().dark, onPress: (value) {

                        DatabaseHelper().completeModule(id: widget._moduleId, status: 1);
                        Future.delayed(Duration(microseconds: 50000)).then((value) => Navigator.pop(context,true));

                    });

                  })),
                )),
          ],
        ),
      ),
    );
  }

  Container _buildQuestionContainer(int i, int index, BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              questions[i].answers[index].selected != true
                  ? AppColors().lowLight
                  : Colors.brown[100],
              questions[i].answers[index].selected != true
                  ? AppColors().lowLight
                  : Colors.brown[200],
              questions[i].answers[index].selected != true
                  ? AppColors().light
                  : AppColors().lowLight,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            color: Colors.redAccent[200],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: AppColors().lowLight,
                  blurRadius: 10,
                  offset: Offset(1, 2))
            ]),
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.width * 0.12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(questions[i].answers[index].desc,
                  style: TextStyle(
                      color: AppColors().dark,
                      fontFamily: 'Montserrat-SemiBold',
                      fontSize: 16,
                      fontWeight: FontWeight.w100)),
              currentIndex != questions.length - 1
                  ? Center(
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ));
  }
  void close() {

    Navigator.pop(context,true);
  }
  Future<List<Question>> _getQuestions(int module) async {
    var dbHelper = DatabaseHelper();

    await dbHelper.getQuestion(module).then((value) {
      questions = value;

      if (questions == null) {
        print(value);
        print("erro!!");
        return;
      }
    });

    if (this.questions != null) {
      for (Question q in this.questions) {
        await dbHelper.getAnswers(q.id).then((value) {
          if (value != null) {
            q.answers = value;
            print(q.answers.length);
            setState(() {
              _load = false;
            });
          }
        });
      }

      return questions;
    }

    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
    }
  }
}
