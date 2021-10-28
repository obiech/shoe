import 'package:flutter/material.dart';
import 'package:to_do_list_pro_project/theme/themes.dart';

class ApplyButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  ApplyButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 50,
      ),
      width: double.maxFinite,
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
          child: Text(
            title,
            style: TextStyles.subtitle5,
          )),
    );
  }
}
