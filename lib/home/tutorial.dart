import 'dart:async';

import 'package:blood_learning/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:highlighter_coachmark/highlighter_coachmark.dart';




void showTutorialSteps(_key,String text, _key2, text2, _key3, _text3) {
    CoachMark coachMarkFAB = CoachMark();
    RenderBox target = _key.currentContext.findRenderObject();

    // you can change the shape of the mark
    Rect markRect = target.localToGlobal(Offset.zero) & target.size;
    markRect = Rect.fromCircle(center: markRect.center, radius: markRect.longestSide * 0.3);

    coachMarkFAB.show(
      targetContext: _key.currentContext,
      markRect: markRect,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:40.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                
                text,
                style: const TextStyle(
                  fontFamily: 'Montserrat-SemiBold',
                  fontSize: 24.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        )
      ],
      duration: null, // we don't want to dismiss this mark automatically so we are passing null
      // when this mark is closed, after 1s we show mark on RaisedButton
      onClose: () =>  showTutorialStep2(_key2,text2,_key3,_text3),
    );
  }

  void showTutorialStep2(_key,_text,_key2,_text2) {
    CoachMark coachMarkFAB = CoachMark();
    RenderBox target = _key.currentContext.findRenderObject();

    // you can change the shape of the mark
    Rect markRect = target.localToGlobal(Offset.zero) & target.size;
    markRect = Rect.fromCircle(center: markRect.center, radius: markRect.longestSide * 0.5);

    coachMarkFAB.show(
      targetContext: _key.currentContext,
      markRect: markRect,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              _text,
              style: const TextStyle(
                fontFamily: 'Montserrat-SemiBold',
                fontSize: 24.0,
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
      ],
   // we don't want to dismiss this mark automatically so we are passing null
      // when this mark is closed, after 1s we show mark on RaisedButton
      onClose: ()  => showTutorialStep3(_key2,_text2),
    );
  }
void showTutorialStep3(_key,_text) async {


    CoachMark coachMark = CoachMark();
    RenderBox target = _key.currentContext.findRenderObject();

    // you can change the shape of the mark
    Rect markRect = target.localToGlobal(Offset.zero) & target.size;
    markRect = Rect.fromCircle(center: markRect.center, radius: markRect.longestSide * 0.3);

    coachMark.show(
      targetContext: _key.currentContext,
      markRect: markRect,
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
             _text,
              style: const TextStyle(
                fontFamily: 'Montserrat-SemiBold',
                fontSize: 24.0,
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
      ],
      duration: null, // we don't want to dismiss this mark automatically so we are passing null
      // when this    mark is closed, after 1s we show mark on RaisedButton
      onClose:  await DatabaseHelper().completeTutorial()
    );
  }


showButton() {
}
