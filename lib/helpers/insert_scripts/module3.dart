import 'package:sqflite/sqflite.dart';

createModule3(Database db) async{ 
   
  await db.execute(
        'INSERT INTO MODULE(ID, MOD_NAME, IS_COMPLETED, MOD_ICONIMGPATH, MOD_IMAGEPATH) VALUES (3, "teste1", 0, "lib/assets/images/temp.png", "lib/assets/images/temp.png");');


    // QUESTOES DO MODULO 3
    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (7,"As células encarregadas da produção de anticorpos específicos contra agentes patogênicos estranhos ao organismo são:", 3);');
    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (8,"Os basófilos são células responsáveis pela produção de uma substância vasodilatadora conhecida por:", 3);');
    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (9,"As células de defesa do corpo exercem o seu papel através da fagocitose e da produção de anticorpos. Como exemplo dessas células, podemos citar, respectivamente:", 3);');
    
    //RESPOSTAS DA QUESTAO 1  MODULO 3 
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("Macrófagos", 0, 0, 7); ');
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("Plasmócitos.", 1, 0, 7);');
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("Miócitos, fibrócitos e hemácias.", 0, 0, 7);');
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("Fibroblasto", 0, 0, 7);');




    //RESPOSTAS DA QUESTAO 2 MODULO 3
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("histamina.", 1, 0, 8);');
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("anticorpos.", 0, 0, 8);');
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("leucopenia.", 0, 0, 8);');
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("hemoglobina.", 0, 0, 8)');

//RESPOSTAS DA QUESTAO 3 MODULO 3
    await db.execute(
        'INSERT INTO ANSWER( ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("linfócitos e neutrófilos.", 0, 0, 9);');
    await db.execute(
        'INSERT INTO ANSWER( ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("eosinófilos e eritrócitos.", 0, 0, 9);');
    await db.execute(
        'INSERT INTO ANSWER( ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ( "eritrócitos e leucócitos.", 0, 0, 9);');
    await db.execute(
        'INSERT INTO ANSWER( ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ( "macrófagos e linfócitos.", 1, 0, 9)');
}