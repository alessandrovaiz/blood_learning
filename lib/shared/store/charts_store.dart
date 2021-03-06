import 'package:blood_learning/helpers/db_helper.dart';
import 'package:blood_learning/shared/models/chart_model.dart';
var dbHelper = DatabaseHelper();

Future<Chart> getChart({int moduleId, String moduleName}) async { 

     var dbClient = await dbHelper.db;
    var rightAnswers = await dbClient.rawQuery('SELECT COUNT(*) as correctAnswers FROM QUESTION f WHERE f.MODULEID = ${moduleId} AND f.QST_ISOK = 1 ');
    var wrongAnswers = await dbClient.rawQuery('SELECT COUNT(*) as wrongAnswers FROM QUESTION f WHERE f.MODULEID = ${moduleId} AND f.QST_ISOK = 0');
   
    var qtdR;
    var qtdWr;
    fromMapRGANSWS(Map<String, dynamic> map) {
    qtdR = map['correctAnswers'];
  }
    fromMapRGANSWS(rightAnswers[0]);

    //Converte as questoes erradas
    fromMapWRANSWS(Map<String, dynamic> map) {
    qtdWr = map['wrongAnswers'];
  } 
    fromMapWRANSWS(wrongAnswers[0]);
    
    print(moduleName + rightAnswers.toString());
    print(moduleName + wrongAnswers.toString());
    if(rightAnswers.length >0 ) { 
      return new Chart(wrongAnswers: qtdWr.toString() ?? '0',correctAnswers: qtdR.toString() ?? '0' , moduleName: moduleName);
    } else { 
      return null;
    }
    
    
  }