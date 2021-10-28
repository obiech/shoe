import 'package:flutter/material.dart';
import 'package:to_do_list_pro_project/data/models/category_model.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;

class EditCategoryColorPicker extends StatefulWidget {
  final CategoryModel category;

  EditCategoryColorPicker({required this.category});

  @override
  _EditCategoryColorPickerState createState() =>
      _EditCategoryColorPickerState();
}

class _EditCategoryColorPickerState extends State<EditCategoryColorPicker> {
  int currentIndex = 0;
  Color currentColor = ColorPalette.colorPickerList[0];

  @override
  void initState() {
    global.store.set('color', currentColor);
    super.initState();
    currentIndex = ColorPalette.colorPickerList
        .indexWhere((element) => element == widget.category.color);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(ColorPalette.colorPickerList.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              currentIndex = index;
            });
            currentColor = ColorPalette.colorPickerList[index];
            global.store.set('editColor', index);
          },
          child: Container(
            width: 28,
            height: 28,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.colorPickerList[index],
                      ),
                    ),
                  ),
                ),
                currentIndex == index
                    ? Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: ColorPalette.colorPickerList[index],
                          ),
                        ),
                      )
                    : Offstage(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
