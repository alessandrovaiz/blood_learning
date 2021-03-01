class Answer {
  int id;
  String desc;
  int isRightAnswer;
  int rightAnswered;
  int questionId;
  bool selected = false;
  Answer(
      {this.id,
      this.desc,
      this.isRightAnswer,
      this.selected,
      this.questionId,
      this.rightAnswered});
//ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ANS_DESCRIPTION TEXT NOT NULL,
//ANS_ISRIGHTANSWER integer DEFAULT 0 NOT NULL, ANS_SELECTED integer DEFAULT 0,
//QUESTIONID integer NOT NULL, FOREIGN KEY(QUESTIONID) REFERENCES QUESTION(ID))
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ID': id,
      'ANS_DESCRIPTION': desc,
      'ANS_ISRIGHTANSWER': isRightAnswer,
      'QUESTIONID': questionId
    };
    return map;
  }

  Answer.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    desc = map['ANS_DESCRIPTION'];
    isRightAnswer = map['ANS_ISRIGHTANSWER'];
    questionId = map['QUESTIONID'];
  }
}
