import 'package:blood_learning/helpers/db_helper.dart';
import 'package:blood_learning/introduction/introduction_page.dart';

import 'package:blood_learning/quiz/quiz_page.dart';
import 'package:blood_learning/shared/models/chart_model.dart';
import 'package:blood_learning/shared/models/module_model.dart';
import 'package:blood_learning/shared/models/user_model.dart';
import 'package:blood_learning/shared/store/user_store.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import 'package:blood_learning/widgets/button.dart';
import 'package:blood_learning/widgets/drawer.dart';
import 'package:blood_learning/widgets/utils/colors.dart';
import 'package:blood_learning/widgets/utils/navigator.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:random_color/random_color.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sweetalert/sweetalert.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {

  @override
  bool get wantKeepAlive => true;
  AppUser user;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Chart> charts = new List<Chart>();
  
  List<Module> modules;
  Module _currentModule;
  bool _load = true;
  bool _loadChart = true;



  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    
    getdata();
  }

  getdata() async {
    user = await _getUser();
    modules = await _getModules();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors().dark),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
        ),
        backgroundColor: Colors.white,
        drawer: CustomDrawer(),
        body: _buildBody(),
      ),
    );
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0, right: 32, top: 32),
        child: Column(
          children: [
            _buildBodyHeader(),
            SizedBox(height: 40),
            _buildModuleSelection(),
            _buildStartImageMap(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  _buildStartImageMap() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Identificação de células",
                style: TextStyle(
                    color: AppColors().dark,
                    fontSize: 18,
                    fontFamily: 'Montserrat-SemiBold'),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 25),
            width: MediaQuery.of(context).size.width * 0.7,
            child: AppButton("Começar", () {
              
            }),
          )
        ],
      ),
    );
  }

  _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 32,bottom: 32),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Desempenho",
                style: TextStyle(
                    color: AppColors().dark,
                    fontSize: 18,
                    fontFamily: 'Montserrat-SemiBold'),
              ),
            ],
          ),
           Container(child: !_loadChart ?Charts(data: charts) : Padding(padding:EdgeInsets.all(64) ,child: CircularProgressIndicator()),)
          //  charts(),
        ],
      ),
    );
  }

  Row _buildModuleSelection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        !_load
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: modules.map((Module module) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 24.0, bottom: 16),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          for (Module m in modules) {
                            m.isSelected = false;
                          }
                          module.isSelected = !module.isSelected;
                          _currentModule = module;
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: module.isSelected
                              ? AppColors().dark
                              : AppColors().lowLight,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(blurRadius: 5, color: Colors.grey[350])
                          ],
                        ),
                        child: module.iconImagePath != null
                            ? Image.asset(module.iconImagePath)
                            : Icon(Icons.star),
                      ),
                    ),
                  );
                }).toList(),
              )
            : CircularProgressIndicator(),
        _currentModule != null ? _buildModuleImage(_currentModule) : SizedBox()
      ],
    );
  }

  Container _buildModuleImage(Module module) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors().lowLight),
        width: 200,
        height: 250,
        child: Stack(
          children: [
            module.iconImagePath != null
                ? Image.asset(
                    module.iconImagePath,
                    fit: BoxFit.cover,
                  )
                : SizedBox(),
            Row(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        module.moduleName ?? "",
                        style: TextStyle(
                            color: AppColors().dark,
                            fontFamily: 'Montserrat-SemiBold',
                            fontSize: 14),
                      ),
                      module.isCompleted != 0
                          ? IconButton(
                              icon: Icon(
                                Icons.refresh,
                                size: 24,
                              ),
                              onPressed: () {
                                DatabaseHelper().resetModule(id: module.id);
                                setState(() {
                                  getdata();
                                });
                              })
                          : SizedBox()
                    ],
                  ),
                ),
              ],
            ),
            module.isCompleted == 0
                ? Align(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: AppButton(
                        "Começar",
                        () async {
                          bool refresh = await push(context, Quiz(module.id));
                          if (refresh) {
                            if (!mounted) return;
                            setState(() {
                              getdata();
                            });
                          }
                        },
                        outlineBtn: false,
                        color: AppColors().dark,
                        color2: AppColors().dark,
                        textColor: AppColors().light,
                      ),
                    ),
                    alignment: Alignment.bottomRight,
                  )
                : Align(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: AppButton(
                        "Respondido",
                        () {},
                        outlineBtn: false,
                        color: Colors.grey,
                        color2: Colors.grey,
                        textColor: AppColors().light,
                      ),
                    ),
                    alignment: Alignment.bottomRight,
                  )
          ],
        ));
  }

  Column _buildBodyHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         
     
       !_load ?Text(
          "Olá ${user.name}!",
          style: TextStyle(
              color: AppColors().dark,
              fontFamily: 'Montserrat-SemiBold',
              fontWeight: FontWeight.w100,
              fontSize: 24),
          textAlign: TextAlign.start,
        ) : CircularProgressIndicator(),
        SizedBox(
          height: 10,
        ),
        Text(
          "Escolha o módulo que deseja estudar",
          style: TextStyle(
              color: AppColors().dark,
              fontFamily: 'Montserrat-Regular',
              fontSize: 16),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }


  

  getCharts() async {
    List<Chart> _charts = new List<Chart>();

    for(Module m in modules) { 
      Chart aux = await _getChart(id:m.id,moduleName: m.moduleName);
      _charts.add(
        aux
        
      );
      print(await _getChart(id:m.id,moduleName: m.moduleName));
     
    }
     setState(() {
        if(_charts != null) { 
        _loadChart = false;
        charts = _charts; 
      
      }
      });
   
  }


  Future<Chart> _getChart({int id, String moduleName}) async {
    var dbHelper = DatabaseHelper();
    Chart aux;
    await dbHelper.getChart(moduleId: id,moduleName: moduleName).then((value) { 
     
     aux =  value;
    });
    return aux;
  }



  Future<AppUser> _getUser() async {
    

    await getUser().then((value) {
      user = value;
      setState(() {
       
        if(user!=null ) {
          _load=false;
        }
          else {
         
          push(context,IntroductionPage());
        }
      });
    });
  

    return user;
  }

  Future<List<Module>> _getModules() async {
    var dbHelper = DatabaseHelper();

    await dbHelper.getModules().then((value) {
      modules = value;
      setState(() {
        
        _load = false;
        if (modules.length > 0) {
          _currentModule = modules[0];
        }
      });
    });
    getCharts();
    print(modules.length);

    return modules;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  


}

class Charts extends StatelessWidget {
  final List<Chart> data;

  Charts({@required this.data});

  @override
  Widget build(BuildContext context) {

    RandomColor _randomColor = RandomColor();

    List<charts.Series<Chart, String>> series = [

    charts.Series(
      id: "Modulos",
      data: data,
      domainFn: (Chart series, _) => series.moduleName,
      measureFn: (Chart series, _) => int.parse(series.correctAnswers),
      colorFn: (Chart series, _) => charts.ColorUtil.fromDartColor( _randomColor.randomColor(colorHue: ColorHue.red)))
  ];

   return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Quantidade de acertos por módulo",
                style: Theme.of(context).textTheme.body2,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  
  }
}
