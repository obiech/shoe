import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/components/apply_button.dart';
import 'package:to_do_list_pro_project/resources/icons.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/advertisement_screen/widgets/tariff_choice_slider.dart';
import 'package:to_do_list_pro_project/screens/main_screen/screen.dart';
import 'package:to_do_list_pro_project/theme/themes.dart';
import 'package:to_do_list_pro_project/utils/injection_container.dart';

class AdvertisementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: ColorPalette.white1,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.29,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorPalette.purple1,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        top: 65,
                        left: 27,
                        bottom: 20,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: SvgPicture.asset(
                          MainIcons.cross,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          Strings.getProVersion,
                          style: TextStyles.header1,
                        ),
                        const SizedBox(height: 21),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorPalette.yellow1,
                              ),
                            ),
                            const SizedBox(width: 9),
                            Text(
                              Strings.withoutAd,
                              style: TextStyles.subtitle1,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorPalette.yellow1,
                              ),
                            ),
                            const SizedBox(width: 9),
                            Text(
                              Strings.fullOptions,
                              style: TextStyles.subtitle1,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            TariffChoiceSlider(),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ApplyButton(
                title: Strings.freeTrial,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
