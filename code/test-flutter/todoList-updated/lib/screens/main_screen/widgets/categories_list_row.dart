import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/data/models/category_model.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/category_list_bloc/category_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/goal_list_bloc/goal_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/categories_bottom_sheet.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/edit_category_bottomsheet.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/medium_term.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/short_term.dart';
import 'package:to_do_list_pro_project/theme/themes.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;
import 'goal_task_list_widget.dart';
import 'long_term.dart';

class CategoriesListRow extends StatefulWidget {
  @override
  _CategoriesListRowState createState() => _CategoriesListRowState();
}

class _CategoriesListRowState extends State<CategoriesListRow> {
  ScrollController _controller = ScrollController();
  int currentIndex = 0;

  Color lightenColor(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  _showMaterialDialog(int index, BuildContext context, CategoryModel category) {
    showDialog(
        context: context,
        builder: (_) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Wrap(
                              children: [
                                BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: EditCategoryBottomSheet(
                                      category: category,
                                      index: index,
                                    )),
                              ],
                            );
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: ColorPalette.grey7,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          'Редактировать',
                          style: TextStyles.subtitle5.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorPalette.black1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<CategoryListBloc>(context)
                          .add(RemoveCategoryEvent(category: category));
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: ColorPalette.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 25),
                        child: Text(
                          'Удалить',
                          style: TextStyles.subtitle5.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorPalette.black1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Wrap(
                        children: [
                          BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: CategoriesBottomSheet()),
                        ],
                      );
                    });
              },
              child: SvgPicture.asset(MainIcons.circlePlus),
            ),
            const SizedBox(width: 16),
            BlocBuilder<CategoryListBloc, CategoryListState>(
              builder: (context, state) {
                if (state is CategoryListLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CategoryListLoaded) {
                  return Expanded(
                    child: Container(
                      height: 15,
                      child: ListView.separated(
                        itemCount: state.categories.length,
                        controller: _controller,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: () {
                              if (index != 0) {
                                _showMaterialDialog(
                                    index, context, state.categories[index]);
                              }
                            },
                            onTap: () {
                              setState(() {
                                currentIndex = index;
                                 global.store.set(
                                    'categoryName', null);
                                global.store.set(
                                    'categoryName', state.categories[index].title);
                              });
                               BlocProvider.of<TaskListBloc>(context)
                      ..add(TaskListLoadEvent());
                      BlocProvider.of<GoalListBloc>(context)
                      ..add(GoalListLoadEvent());
                      
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(61),
                                color: currentIndex == index
                                    ? lightenColor(
                                        ColorPalette.colorPickerList[
                                            state.categories[index].color!],
                                        0)
                                    : lightenColor(
                                        ColorPalette.colorPickerList[
                                            state.categories[index].color!],
                                        .2),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  state.categories[index].title!,
                                  style: TextStyles.subtitle4.copyWith(
                                    height: 1.5,
                                    color: currentIndex == index
                                        ? ColorPalette.white
                                        : ColorPalette.colorPickerList[
                                            state.categories[index].color!],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 16);
                        },
                      ),
                    ),
                  );
                } else if (state is CategoryListError) {
                  return Center(
                    child: Text('Error'),
                  );
                } else {
                  return Offstage();
                }
              },
            ),
          ],
        ),

      ],
    );
  }
}
