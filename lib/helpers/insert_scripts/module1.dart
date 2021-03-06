import 'package:sqflite/sqflite.dart';

createModule1(Database db) async{ 
    await db.execute(
        'INSERT INTO MODULE(ID, MOD_NAME, IS_COMPLETED, MOD_ICONIMGPATH, MOD_IMAGEPATH) VALUES (1, "Sangue", 0, "lib/assets/images/sangue.png", "lib/assets/images/sangue.png");');

    
    // QUESTOES DO MODULO 1 
    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (1,"O tecido sanguíneo é formado pelo plasma, substância formada principalmente por água e proteínas, e três tipos de elementos figurados. Marque a alternativa em que estão indicados esses elementos:", 1);');
    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (2,"Imagine que você realizou um exame de sangue, nele você percebeu que houve uma grande queda no número de plaquetas. Essa baixa nos níveis desse elemento figurado pode levar você a um quadro de:", 1);');
    await db.execute(
        'INSERT INTO QUESTION(ID, QST_DESCRIPTION,MODULEID) VALUES (3,"O sangue é constituído por plasma e três tipos de elementos celulares. As hemácias realizam (1), os (2) são especializados na defesa do organismo e as plaquetas atuam no processo de (3). Para completar corretamente a frase acima, 1, 2 e 3 devem ser substituídos, respectivamente, por:", 1);');
    
    //RESPOSTAS DA QUESTAO 1  MODULO 1 
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("Hemácias, neurônios, hormônios.", 0, 0, 1); ');
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("Plaquetas, anticorpos, neurônios.", 0, 0, 1);');
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("Miócitos, fibrócitos e hemácias.", 0, 0, 1);');
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("Plaquetas, hemácias e leucócitos.", 1, 0, 1);');




    //RESPOSTAS DA QUESTAO 2 MODULO 1 
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("Hemorragia", 0, 0, 2);');
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("Leucopenia", 0, 0, 2);');
    await db.execute(
        'INSERT INTO ANSWER( ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("Insuficiência renal.", 0, 0, 2);');
    await db.execute(
        'INSERT INTO ANSWER( ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ( "Acidose", 1, 0, 2)');

//RESPOSTAS DA QUESTAO 3 MODULO 1 
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ( "Osmose, dendritos e fagocitose.", 0, 0, 3);');
    await db.execute(
        'INSERT INTO ANSWER( ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("Transporte de oxigênio, leucócitos e coagulação.", 1, 0, 3);');
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("Respiração celular, glóbulos vermelhos e absorção.", 0, 0, 3);');
    await db.execute(
        'INSERT INTO ANSWER(ANS_DESCRIPTION, ANS_ISRIGHTANSWER, ANS_SELECTED, QUESTIONID) VALUES ("Coagulação, amebócitos e transporte de gás carbônico.", 0, 0, 3)');





}