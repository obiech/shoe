import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/resources/icons.dart';
import 'package:to_do_list_pro_project/screens/advertisement_screen/screen.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/text_theme.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 66, left: 30, right: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset(
                    MainIcons.cross,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Меню',
                  style: TextStyles.header3.copyWith(
                    color: ColorPalette.black1,
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
            const SizedBox(height: 68),
            GestureDetector(onTap: ((){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdvertisementScreen()));
                }),
              child: SvgPicture.asset(MainIcons.buyProText1)),
            const SizedBox(
              height: 39,
            ),
            GestureDetector(
               onTap:((){
                Share.share('I saw this app and thought of you, It makes me more productive https://example.com', subject: 'Try it out!');
              }),
              child: Row(
                children: [
                  SvgPicture.asset(MainIcons.share),
                  const SizedBox(width: 20),
                  Text(
                    'Поделиться',
                    style: TextStyles.subtitle5.copyWith(
                        color: ColorPalette.black, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 37),
            InkWell(onTap: (()=> launch('https://pub.dev/packages/parse_rest_api')),
              child: Row(
                children: [
                  SvgPicture.asset(MainIcons.star),
                  const SizedBox(width: 20),
                  Text(
                    'Оценить приложение',
                    style: TextStyles.subtitle5.copyWith(
                        color: ColorPalette.black, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 37),
            GestureDetector(
              onTap:((){
                Share.share('I saw this app and thought of you, It makes me more productive https://example.com', subject: 'Try it out!');
              }),
              child: Row(
                children: [
                  SvgPicture.asset(MainIcons.letter),
                  const SizedBox(width: 20),
                  Text(
                    'Написать разработчику',
                    style: TextStyles.subtitle5.copyWith(
                        color: ColorPalette.black, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 37),
          ],
        ),
      ),
    );
  }
}
