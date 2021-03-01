// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Controller on QuizController, Store {
  final _$xcurrentIndexAtom = Atom(name: 'QuizController.xcurrentIndex');

  @override
  int get xcurrentIndex {
    _$xcurrentIndexAtom.reportRead();
    return super.xcurrentIndex;
  }

  @override
  set xcurrentIndex(int value) {
    _$xcurrentIndexAtom.reportWrite(value, super.xcurrentIndex, () {
      super.xcurrentIndex = value;
    });
  }

  final _$QuizControllerActionController =
      ActionController(name: 'QuizController');

  @override
  dynamic increment() {
    final _$actionInfo = _$QuizControllerActionController.startAction(
        name: 'QuizController.increment');
    try {
      return super.increment();
    } finally {
      _$QuizControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
xcurrentIndex: ${xcurrentIndex}
    ''';
  }
}
