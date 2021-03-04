class Chart {
   String moduleName;
   String correctAnswers;
   String wrongAnswers;

  Chart({this.moduleName,this.correctAnswers,this.wrongAnswers});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MOD_NAME': moduleName,

      'CORRECT_ANSWERS': correctAnswers,
      'WRONG_ANSWERS': wrongAnswers,

    };
    return map;
  }

  Chart.fromMap(Map<String, dynamic> map) {
    moduleName = map['MOD_NAME'];
    correctAnswers = map['CORRECT_ANSWERS'];
    wrongAnswers = map['WRONG_ANSWERS'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "nome do modulo : ${moduleName}" + "Corretas : ${correctAnswers}" + " Erradas : ${wrongAnswers}";
  }


}