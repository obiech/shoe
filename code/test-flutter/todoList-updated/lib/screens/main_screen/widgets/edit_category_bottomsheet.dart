import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_pro_project/components/apply_button.dart';
import 'package:to_do_list_pro_project/data/models/category_model.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/category_list_bloc/category_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/color_picker_row.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/edit_category_color_picker.dart';
import 'package:to_do_list_pro_project/theme/themes.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;

class EditCategoryBottomSheet extends StatefulWidget {
  final CategoryModel category;
  final int index;

  EditCategoryBottomSheet({required this.category, required this.index});
  @override
  _EditCategoryBottomSheetState createState() =>
      _EditCategoryBottomSheetState();
}

class _EditCategoryBottomSheetState extends State<EditCategoryBottomSheet> {
  TextEditingController categoryController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    categoryController.text = widget.category.title!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.only(
          top: 44,
          bottom: 50,
          left: 30,
          right: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Название категории',
              style: TextStyles.dateStyle.copyWith(
                color: ColorPalette.grey3,
              ),
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: categoryController,
                validator: (value) {
                  if (value == '') {
                    return 'Введите название';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorPalette.grey6),
                    ),
                    hintText: 'Категория',
                    isDense: true,
                    hintStyle: TextStyles.subtitle5.copyWith(
                        color: ColorPalette.grey4,
                        fontWeight: FontWeight.w600)),
                style: TextStyles.subtitle5.copyWith(
                  color: ColorPalette.black1,
                  fontWeight: FontWeight.w600,
                ),
                minLines: 1,
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Цвет',
              style: TextStyles.dateStyle.copyWith(
                color: ColorPalette.grey3,
              ),
            ),
            const SizedBox(height: 13),
            EditCategoryColorPicker(
              category: widget.category,
            ),
            const SizedBox(height: 41),
            ApplyButton(
                title: 'Готово',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    widget.category.title = categoryController.text == ''
                        ? widget.category.title
                        : categoryController.text;
                    widget.category.color =
                        global.store.get('editColor') ?? widget.category.color;
                    BlocProvider.of<CategoryListBloc>(context)
                      ..add(
                        EditCategoryEvent(
                          category: widget.category,
                          // index: widget.index,
                          // color: global.store.get('editColor'),
                          // title: categoryController.text,
                        ),
                      );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
