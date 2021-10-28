import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/bottom_nav_bar_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/savchits.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Artboard? _riveArtboard;
  RiveAnimationController? _controller;

  bool _loaded = false;

  @override
  void dispose() {
    _controller!.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // _loadRive();
    next();
    super.initState();
    _controller = SimpleAnimation(
      'Animation 1',
    );
    // onStop: ((){
    //   // await Future.delayed(Duration(seconds: 3));
    //   setState(() {
    //     // Future.delayed(Duration(seconds: 3));
    //     _loaded = true;
    //   });
    //   // Navigator.of(context).push(
    //   //   MaterialPageRoute(
    //   //     builder: (context) => SavchitsPage(),
    //   //   ),
    //   // );
    // }));
  }

  void next() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      _loaded = true;
    });
  }
  // void _loadRive() {
  //   rootBundle.load('assets/rive/rive.riv').then(
  //     (data) async {
  //       final file = RiveFile.import(data);
  //        _riveArtboard  =  file.artboardByName('New Artboard');
  //       _riveArtboard!.addController(_controller = OneShotAnimation(animationName));
  //       _controller!.isActiveChanged.addListener(() {
  //         if (!_controller!.isActive) {
  //           Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => MyBottomNavbar(),
  //       ),
  //     );
  //         }
  //       });
  //       setState((){});
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: _scaffoldKey,
        body: Stack(
      children: [
        if (!_loaded)
          Container(
            color: Colors.black,
            child: Center(
              child: SizedBox(
                width: 280,
                height: 280,
                child: RiveAnimation.asset('assets/rive/rive.riv',
                    controllers: [_controller!]),
              ),
            ),
          ),
        if (_loaded) SavchitsPage()
      ],
    ));
  }
}
