
import 'package:blood_learning/helpers/db_helper.dart';
import 'package:blood_learning/home/home_page.dart';
import 'package:blood_learning/widgets/utils/colors.dart';
import 'package:blood_learning/widgets/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
 


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Center(
            child: Image(
              image: AssetImage('lib/assets/images/first_slide.png'),
              height: 80,
              width: 80,
            ),
          ),
          decoration: BoxDecoration(
              //color: Color(0xFF21BFBD),
              color: Colors.transparent),
        ),
        ListTile(
            leading: Icon(Icons.home, color: AppColors().dark),
            title: Text("Início",
                style: TextStyle(
                    fontFamily: 'Poppins-ExtraLight',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors().secondaryDark)),
            //trailing: Icon(Icons.arrow_forward_ios,color: Color(0xFF21BFBD)),
            onTap: () {
              Navigator.of(context).pop();
            }),
        ListTile(
            leading: Icon(Icons.restore_outlined, color: AppColors().dark),
            title: Text("Resetar configurações",
                style: TextStyle(
                    fontFamily: 'Poppins-ExtraLight',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors().secondaryDark)),
            //trailing: Icon(Icons.arrow_forward_ios,color: Color(0xFF21BFBD)),
            onTap: () {
            SweetAlert.show(context,
                        subtitle: "Isso irá deletar todos os dados do aplicativo, tem certeza?",

                        style: SweetAlertStyle.error,
                        confirmButtonColor: AppColors().dark, onPress: (value) {

                          if(value) { 
                             DatabaseHelper().reset();
                        
                       Future.delayed(Duration(microseconds: 50000)).then((value) => push(context,HomePage(),replace: true));
                          }

                       

                    },
                    cancelButtonText: "Cancelar",
                    confirmButtonText: "Confirmar",
                     
                      showCancelButton: true

                      
                      
                    
                    );
              // push(context, AccessCodeScreen());
            }),
      
            
          
      ],
    ));
  }

 
}