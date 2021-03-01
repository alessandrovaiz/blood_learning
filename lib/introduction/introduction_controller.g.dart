// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'introduction_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Controller on IntroductionController, Store {
  final _$counterAtom = Atom(name: 'IntroductionController.counter');

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  final _$getUserAsyncAction = AsyncAction('IntroductionController.getUser');

  @override
  Future getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  final _$IntroductionControllerActionController =
      ActionController(name: 'IntroductionController');

  @override
  dynamic deleteuser() {
    final _$actionInfo = _$IntroductionControllerActionController.startAction(
        name: 'IntroductionController.deleteuser');
    try {
      return super.deleteuser();
    } finally {
      _$IntroductionControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic saveUser(AppUser user) {
    final _$actionInfo = _$IntroductionControllerActionController.startAction(
        name: 'IntroductionController.saveUser');
    try {
      return super.saveUser(user);
    } finally {
      _$IntroductionControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic increment() {
    final _$actionInfo = _$IntroductionControllerActionController.startAction(
        name: 'IntroductionController.increment');
    try {
      return super.increment();
    } finally {
      _$IntroductionControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
counter: ${counter}
    ''';
  }
}
