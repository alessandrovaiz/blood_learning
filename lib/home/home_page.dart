import 'package:blood_learning/helpers/db_helper.dart';
import 'package:blood_learning/quiz/quiz_page.dart';
import 'package:blood_learning/shared/models/module_model.dart';

import 'package:blood_learning/widgets/button.dart';
import 'package:blood_learning/widgets/utils/colors.dart';
import 'package:blood_learning/widgets/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sweetalert/sweetalert.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Module> _modules = new List<Module>();
  List<Module> modules;
  Module _currentModule;
  bool _load = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getmodules();
  }

  getmodules() async {
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
        drawer: Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width * 0.7,
        ),
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
            child: AppButton("Começar", () {}),
          )
        ],
      ),
    );
  }

  _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 400),
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
                                  getmodules();
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
                              getmodules();
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
        Text(
          "Estudos",
          style: TextStyle(
              color: AppColors().dark,
              fontFamily: 'Montserrat-SemiBold',
              fontWeight: FontWeight.w100,
              fontSize: 24),
          textAlign: TextAlign.start,
        ),
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

  charts() {}

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
    print(modules.length);

    return modules;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
