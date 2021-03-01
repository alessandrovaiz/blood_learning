import 'package:blood_learning/widgets/utils/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String str;
  final VoidCallback callback;

  final bool showProgress;
  final bool outlineBtn;
  final Color color;
  final Color color2;
  final Color textColor;

  AppButton(this.str, this.callback,
      {this.showProgress = false,
      this.color = Colors.white,
      this.color2 = Colors.white,
      this.outlineBtn = true,
      this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    final backgroundColor1 = color;
    final backgroundColor2 = color2;

    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 50,
      decoration: !outlineBtn
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [backgroundColor1, backgroundColor2],
              ),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
      child: outlineBtn
          ? OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: showProgress
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(textColor),
                      ),
                    )
                  : Text(
                      str,
                      style: TextStyle(
                          fontSize: 14,
                          color: textColor,
                          fontFamily: 'Montserrat-Regular'),
                    ),
              onPressed: callback,
            )
          : FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: showProgress
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(textColor),
                      ),
                    )
                  : Text(
                      str,
                      style: TextStyle(
                          fontSize: 14,
                          color: textColor,
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.bold),
                    ),
              onPressed: callback,
            ),
    );
  }
}
