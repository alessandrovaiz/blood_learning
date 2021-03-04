import 'dart:io';

import 'package:blood_learning/home/home_page.dart';
import 'package:blood_learning/shared/models/slide_model.dart';
import 'package:blood_learning/shared/models/user_model.dart';
import 'package:blood_learning/shared/store/slides.dart';
import 'package:blood_learning/shared/store/user_store.dart';
import 'package:blood_learning/widgets/utils/colors.dart';
import 'package:blood_learning/widgets/utils/navigator.dart';

import 'package:flutter/material.dart';

class Slides extends StatefulWidget {
  @override
  _SlidesState createState() => _SlidesState();
}

class _SlidesState extends State<Slides> {
  List<Slide> slides = new List<Slide>();
  int currentIndex = 0;
  PageController _pageController = new PageController(initialPage: 0);
  AppUser user;
  @override
  void initState() {
    // TODO: implement initState
 super.initState();
    slides = getSlides();
   getuser();
  }
 getuser() async { 
    user = await _getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().light,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        itemCount: slides.length,
        itemBuilder: (context, index) {
          return SliderTile(
            imageAssetPath: slides[index].imagePath,
            title: slides[index].title,
            desc: slides[index].desc,
          );
        },
      ),
      bottomSheet: currentIndex != slides.length - 1
          ? _buildBottomSheet()
          : _buildBottomSheetStartApp(context),
    );
  }

  Container _buildBottomSheet() {
    return Container(
      color: AppColors().lowLight,
      height: Platform.isIOS ? 70 : 60,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              _pageController.animateToPage(slides.length - 1,
                  duration: Duration(milliseconds: 300), curve: Curves.linear);
            },
            child: Text("PULAR",
                style: TextStyle(
                  fontFamily: 'Montserrat-Regular',
                  fontSize: 14,
                )),
          ),
          Row(
            children: [
              for (int i = 0; i < slides.length; i++)
                currentIndex == i
                    ? pageIndexIndicator(true)
                    : pageIndexIndicator(false),
            ],
          ),
          InkWell(
            onTap: () {
              _pageController.animateToPage(currentIndex + 1,
                  duration: Duration(milliseconds: 300), curve: Curves.linear);
            },
            child: Text("PRÓXIMO",
                style: TextStyle(
                  fontFamily: 'Montserrat-Regular',
                  fontSize: 14,
                )),
          ),
        ],
      ),
    );
  }

  Container _buildBottomSheetStartApp(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      height: Platform.isIOS ? 70 : 60,
      color: AppColors().secondaryDark,
      child: InkWell(
        onTap: () async {
          await updateIntroduction(1);
          push(context, HomePage());
        },
        child: Text(
          "COMEÇAR!",
          style: TextStyle(
              fontFamily: 'Montserrat-SemiBold',
              fontSize: 14,
              color: AppColors().light,
              fontWeight: FontWeight.w100),
        ),
      ),
    );
  }

  Widget pageIndexIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
          color: isCurrentPage ? AppColors().dark : Colors.grey,
          borderRadius: BorderRadius.circular(12)),
    );
  }
  Future<AppUser> _getUser() async {
 

    await getUser().then((value) {
      user = value;
      setState(() {
       
        if (user.isIntroductionViewed!= 0) {
         push(context,HomePage());
         
        } else {
         
          return;
        }
      });
    });
  

    return user;
  }
}

class SliderTile extends StatelessWidget {
  String imageAssetPath, title, desc;
  SliderTile({this.imageAssetPath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 300, height: 100, child: Image.asset(imageAssetPath)),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat-SemiBold',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors().dark,
                fontFamily: 'Montserrat-Regular',
                fontSize: 14,
                fontWeight: FontWeight.w100),
          )
        ],
      ),
    );
    
  }
    
  

}
