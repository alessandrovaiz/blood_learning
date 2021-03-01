import 'package:blood_learning/shared/models/answer_model.dart';
import 'package:blood_learning/shared/models/question_model.dart';

List<Question> getCellQuestions() {
  List<Question> questions = new List<Question>();

  Question question1 = new Question(
      desc: 'Qual o valor de referencia de globulos vermelhos no hemograma',
      answers: [
        Answer(desc: '1000', isRightAnswer: 1),
        Answer(desc: '210331920'),
        Answer(desc: '123412'),
        Answer(desc: 'ta'),
        Answer(desc: 'asdasdasda'),
      ],
      id: 1,
      isAnswered: 0,
      isOk: 0);

  questions.add(question1);

  Question question2 = new Question(
      desc: 'Seleciona a célula que corresponde a tal coisa',
      answers: [
        Answer(desc: 'talkei', isRightAnswer: 0),
        Answer(desc: 'adadada0'),
        Answer(desc: 'teste 22')
      ],
      id: 1,
      isAnswered: 0,
      isOk: 0);

  questions.add(question2);

  return questions;
}
