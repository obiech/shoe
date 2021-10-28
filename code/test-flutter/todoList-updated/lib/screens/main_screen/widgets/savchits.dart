import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/bottom_nav_bar_widget.dart';
import 'package:to_do_list_pro_project/theme/themes.dart';

class SavchitsPage extends StatefulWidget {
  const SavchitsPage({Key? key}) : super(key: key);

  @override
  _SavchitsPageState createState() => _SavchitsPageState();
}

class _SavchitsPageState extends State<SavchitsPage> {
  RiveAnimationController? _controller;

  bool _loaded = true;
  @override
  void initState() {
    next();
    super.initState();
    _controller = SimpleAnimation(
      '1',
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  void next() async {
    await Future.delayed(Duration(seconds: 6));
    setState(() {
      _loaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A202F),
      // appBar: ,
      body: Padding(
        padding: const EdgeInsets.only(left: 21.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70.0,
            ),
            SizedBox(
              width: 210,
              height: 210,
              child: RiveAnimation.asset('assets/rive/1.riv',
                  controllers: [_controller!]),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'The future is the result of your choice',
              style: TextStyles.header3.copyWith(
                color: (_loaded) ? Color(0xff1A202F) : Colors.grey,
                fontSize: 15,
              ),
            ),
            Text(
              'We will help to make it light',
              style: TextStyles.subtitle5.copyWith(
                color: (_loaded) ? Color(0xff1A202F) : Colors.grey,
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 160.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 64,
              child: GestureDetector(
                onTap: (() {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyBottomNavbar(),
                      ));
                }),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        'assets/images/logo.svg',
                        color: (_loaded) ? Color(0xff1A202F) : null,
                      ),
                    ),
                    Text(
                      'Login with Google',
                      style: TextStyles.header1.copyWith(
                        color:
                            (_loaded) ? Color(0xff1A202F) : ColorPalette.grey5,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: (_loaded) ? Color(0xff1A202F) : ColorPalette.black1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                color: (_loaded) ? Color(0xff1A202F) : null,
                child: RichText(
                    text: TextSpan(
                        text: 'By continuing, you agree to  ',
                        style: TextStyles.subtitle3.copyWith(
                          color: (_loaded)
                              ? Color(0xff1A202F)
                              : ColorPalette.grey5,
                          fontSize: 10,
                        ),
                        children: [
                      TextSpan(
                        text: 'Terms and Privacy Policy',
                        recognizer: TapGestureRecognizer(),
                        style: TextStyles.subtitle3.copyWith(
                          decoration: TextDecoration.underline,
                          color: (_loaded)
                              ? Color(0xff1A202F)
                              : ColorPalette.grey5,
                          fontSize: 10,
                        ),
                      )
                    ]))
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Text(
                //       'By continuing, you agree to',
                //       style: TextStyles.subtitle3.copyWith(
                //           color:
                //               (_loaded) ? Color(0xff1A202F) : ColorPalette.grey5,
                //               fontSize: 10,)
                //     ),
                //     TextButton(
                //         onPressed: () {},
                //         child: Text(
                //           'Terms and Privacy Policy',
                //           style: TextStyles.subtitle3.copyWith(
                //               color: (_loaded)
                //                   ? Color(0xff1A202F)
                //                   : ColorPalette.grey5, fontSize: 10,),
                //         )),
                //   ],
                // ),
                )
          ],
        ),
      ),
    );
  }
}
