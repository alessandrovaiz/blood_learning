import 'package:blood_learning/shared/models/slide_model.dart';

List<Slide> getSlides() {
  List<Slide> slides = new List<Slide>();
  Slide sliderModel = new Slide(
      imagePath: 'lib/assets/images/first_slide.png',
      title: 'Aprenda',
      desc:
          'Prepare-se para iniciar uma divertida jornada de estudos no bLearn, que irá lhe ajudar a interpretar exames de maneira mais eficiente!');

  slides.add(sliderModel);

  Slide sliderModel2 = new Slide(
      imagePath: 'lib/assets/images/first_slide.png',
      title: 'Aprenda',
      desc:
          'Prepare-se para iniciar uma divertida jornada de estudos no bLearn, que irá lhe ajudar a interpretar exames de maneira mais eficiente!');
  slides.add(sliderModel2);

  Slide sliderModel3 = new Slide(
      imagePath: 'lib/assets/images/first_slide.png',
      title: 'Aprendaaaa',
      desc:
          'Prepare-se para iniciar uma divertida jornada de estudos no bLearn, que irá lhe ajudar a interpretar exames de maneira mais eficiente!');
  slides.add(sliderModel3);

  return slides;
}
