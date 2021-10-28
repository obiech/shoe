import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_pro_project/data/repositories/tariff_repo.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/theme/themes.dart';
import 'package:to_do_list_pro_project/utils/check_util.dart';
import 'package:to_do_list_pro_project/utils/injection_container.dart';

class TariffChoiceSlider extends StatefulWidget {
  final TariffRepo tariffRepo = getIt<TariffRepo>();

  @override
  _TariffChoiceSliderState createState() => _TariffChoiceSliderState();
}

class _TariffChoiceSliderState extends State<TariffChoiceSlider> {
  int initialIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.chooseTariff,
          style: TextStyles.header1.copyWith(color: ColorPalette.black1),
        ),
        const SizedBox(height: 19),
        CarouselSlider(
          options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.35,
              viewportFraction: 0.46,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              initialPage: initialIndex,
              onPageChanged: (newValue, c) {
                setState(() {
                  initialIndex = newValue;
                });
              }),
          items: widget.tariffRepo.tariffData.tariffList.map((e) {
            if (initialIndex ==
                widget.tariffRepo.tariffData.tariffList.indexOf(e)) {
              return Stack(
                clipBehavior: Clip.none,
                fit: StackFit.loose,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        color: ColorPalette.purple1,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            '${e.period}',
                            style: TextStyles.header2,
                          ),
                          Text(
                            CheckUtil.checkMonth(e.period),
                            style: TextStyles.header3,
                          ),
                          const SizedBox(height: 16),
                          Text('\$${e.monthPrice}/мес',
                              style: TextStyles.subtitle1),
                          const SizedBox(height: 6),
                          Text(
                            '\$${e.totalPrice} итого',
                            style: TextStyles.subtitle1.copyWith(height: 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.tariffRepo.tariffData.tariffList.indexOf(e) == 1
                      ? Positioned(
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 39),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: ColorPalette.yellow1,
                                borderRadius: BorderRadius.circular(31),
                                border: Border.all(
                                    width: 4, color: ColorPalette.white1),
                              ),
                              child: Text(
                                Strings.popular,
                                style: TextStyles.subtitle2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      : Offstage(),
                ],
              );
            } else if (widget.tariffRepo.tariffData.tariffList.indexOf(e) ==
                0) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  left: 36,
                ),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: ColorPalette.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${e.period}',
                        style: TextStyles.header4,
                      ),
                      Text(
                        Strings.month,
                        style: TextStyles.subtitle3,
                      ),
                      Text(
                        '\$${e.monthPrice}/мес',
                        style: TextStyles.subtitle4,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${e.totalPrice} итого',
                        style: TextStyles.subtitle4.copyWith(
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  right: 36,
                ),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: ColorPalette.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${e.period}',
                        style: TextStyles.header4,
                      ),
                      Text(
                        Strings.months,
                        style: TextStyles.subtitle3,
                      ),
                      Text(
                        '\$${e.monthPrice}/мес',
                        style: TextStyles.subtitle4,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${e.totalPrice} итого',
                        style: TextStyles.subtitle4.copyWith(
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }).toList(),
        ),
      ],
    );
  }
}
