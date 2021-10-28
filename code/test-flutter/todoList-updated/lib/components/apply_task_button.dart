import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_list_pro_project/resources/icons.dart';
import 'package:to_do_list_pro_project/theme/themes.dart';

class ApplyTaskButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  ApplyTaskButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      width: 40.0,
      height: 40.0,
      child: OutlinedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                vertical: 16,
              ),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: MaterialStateProperty.all(ColorPalette.purple1),
            foregroundColor: MaterialStateProperty.all(ColorPalette.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          onPressed: onPressed,
        child: SvgPicture.asset(MainIcons.applyTask, width: 20.0, height: 20.0,),
      ),
    );
  }
}