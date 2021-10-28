import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/advertisement_screen/screen.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/categories_list_row.dart';
// import 'package:to_do_list_pro_project/screens/main_screen/widgets/database/squlite.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/drawer_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/edit_task_bottomsheet.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/goal_expanded_settings.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/goal_task_bottom_sheet.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/goal_task_list_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/long_term.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/long_term_goal_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/medium_term.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/medium_term_goal_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/short_term.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/short_term_goal_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/task_bottom_sheet.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/task_list_widget.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/text_theme.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;
import 'package:draggable_fab/draggable_fab.dart';

class Screen2 extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorPalette.white1,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: SvgPicture.asset(
                  MainIcons.menu,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                Strings.goals,
                style: TextStyles.header3.copyWith(color: ColorPalette.black1),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdvertisementScreen()));
                },
                child: SvgPicture.asset(MainIcons.brilliant),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CategoriesListRow(),
              const SizedBox(height: 20),
              ShortTerm(),
              const SizedBox(height: 20),
              MediumTerm(),
              const SizedBox(height: 20),
              LongTerm(),
            ],
          ),
        ),
      ),
      floatingActionButton: DraggableFab(
        // initPosition: Offset( 500, MediaQuery.of(context).size.height+100),
        child: Padding(
          padding: EdgeInsets.only(bottom: 30, right: 18),
          child: FloatingActionButton(
            // elevation: 20,
            backgroundColor: ColorPalette.purple1,
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Wrap(
                      children: [
                        BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: GoalTaskBottomSheet()),
                      ],
                    );
                  });
            },
            child: SvgPicture.asset(MainIcons.plus),
          ),
        ),
      ),
    );
  }
}

// library draggable_fab;

// import 'dart:math';

// import 'package:flutter/material.dart';

/// Draggable FAB widget which is always aligned to
// /// the edge of the screen - be it left,top, right,bottom
// class DraggableFab extends StatefulWidget {
//   final Widget child;
//   final Offset? initPosition;
//   final double securityBottom;

//   const DraggableFab(
//       {Key? key, required this.child, this.initPosition, this.securityBottom: 0})
//       : super(key: key);

//   @override
//   _DraggableFabState createState() => _DraggableFabState();
// }

// class _DraggableFabState extends State<DraggableFab> {
//   late Size _widgetSize;
//   double? _left, _top;
//   double _screenWidth = 0.0, _screenHeight = 0.0;
//   double? _screenWidthMid, _screenHeightMid;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!
//         .addPostFrameCallback((_) => _getWidgetSize(context));
//   }

//   void _getWidgetSize(BuildContext context) {
//     _widgetSize = context.size!;

//     if (widget.initPosition != null) {
//       _calculatePosition(widget.initPosition!);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       Positioned(
//         left: this._left,
//         top: this._top,
//         child: Draggable(
//           child: widget.child,
//           feedback: widget.child,
//           onDragEnd: _handleDragEnded,
//           childWhenDragging: Container(
//             width: 0.0,
//             height: 0.0,
//           ),
//         ),
//       )
//     ]);
//   }

//   void _handleDragEnded(DraggableDetails draggableDetails) {
//     this._calculatePosition(draggableDetails.offset);
//   }

//   void _calculatePosition(Offset targetOffset) {
//     if (_screenWidthMid == null || _screenHeightMid == null) {
//       Size screenSize = MediaQuery.of(context).size;
//       _screenWidth = screenSize.width;
//       _screenHeight = screenSize.height;
//       _screenWidthMid = _screenWidth / 2;
//       _screenHeightMid = _screenHeight / 2;
//     }

//     switch (_getAnchor(targetOffset)) {
//       case Anchor.LEFT_FIRST:
//         this._left = _widgetSize.width / 2;
//         this._top = max(_widgetSize.height / 2, targetOffset.dy);
//         break;
//       case Anchor.TOP_FIRST:
//         this._left = max(_widgetSize.width / 2, targetOffset.dx);
//         this._top = _widgetSize.height / 2;
//         break;
//       case Anchor.RIGHT_SECOND:
//         this._left = _screenWidth - _widgetSize.width;
//         this._top = max(_widgetSize.height, targetOffset.dy);
//         break;
//       case Anchor.TOP_SECOND:
//         this._left = min(_screenWidth - _widgetSize.width, targetOffset.dx);
//         this._top = _widgetSize.height / 2;
//         break;
//       case Anchor.LEFT_THIRD:
//         this._left = _widgetSize.width / 2;
//         this._top = min(
//             _screenHeight - _widgetSize.height - widget.securityBottom,
//             targetOffset.dy);
//         break;
//       case Anchor.BOTTOM_THIRD:
//         this._left = _widgetSize.width / 2;
//         this._top = _screenHeight - _widgetSize.height - widget.securityBottom;
//         break;
//       case Anchor.RIGHT_FOURTH:
//         this._left = _screenWidth - _widgetSize.width;
//         this._top = min(
//             _screenHeight - _widgetSize.height - widget.securityBottom,
//             targetOffset.dy);
//         break;
//       case Anchor.BOTTOM_FOURTH:
//         this._left = _screenWidth - _widgetSize.width;
//         this._top = _screenHeight - _widgetSize.height - widget.securityBottom;
//         break;
//     }
//     setState(() {});
//   }

//   /// Computes the appropriate anchor screen edge for the widget
//   Anchor _getAnchor(Offset position) {
//     if (position.dx < _screenWidthMid! && position.dy < _screenHeightMid!) {
//       return position.dx < position.dy ? Anchor.LEFT_FIRST : Anchor.TOP_FIRST;
//     } else if (position.dx >= _screenWidthMid! &&
//         position.dy < _screenHeightMid!) {
//       return _screenWidth - position.dx < position.dy
//           ? Anchor.RIGHT_SECOND
//           : Anchor.TOP_SECOND;
//     } else if (position.dx < _screenWidthMid! &&
//         position.dy >= _screenHeightMid!) {
//       return position.dx < _screenHeight - position.dy
//           ? Anchor.LEFT_THIRD
//           : Anchor.BOTTOM_THIRD;
//     } else {
//       return _screenWidth - position.dx < _screenHeight - position.dy
//           ? Anchor.RIGHT_FOURTH
//           : Anchor.BOTTOM_FOURTH;
//     }
//   }
// }

// /// #######################################
// /// #       |          #        |         #
// /// #    TOP_FIRST     #  TOP_SECOND      #
// /// # - LEFT_FIRST     #  RIGHT_SECOND -  #
// /// #######################################
// /// # - LEFT_THIRD     #   RIGHT_FOURTH - #
// /// #  BOTTOM_THIRD    #   BOTTOM_FOURTH  #
// /// #     |            #       |          #
// /// #######################################
// enum Anchor {
//   LEFT_FIRST,
//   TOP_FIRST,
//   RIGHT_SECOND,
//   TOP_SECOND,
//   LEFT_THIRD,
//   BOTTOM_THIRD,
//   RIGHT_FOURTH,
//   BOTTOM_FOURTH
// }
