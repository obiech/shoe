import 'package:flutter/material.dart';
import 'package:shoe/MODEL/data.dart';
import 'package:shoe/MODEL/shoes.dart';
import 'package:shoe/custom_app_bar.dart';
import 'package:shoe/widgets/custom_app_bar.dart';
import 'package:shoe/widgets/custom_bottom.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(viewportFraction: 0.75);

  double _currentPage = 0.0;
  double indexPage = 0.0;
  ImageShoes animatedShoe = listShoes[0].listImage[0];
  double? a;
  double? b;

  void _listener() {
    setState(() {
      _currentPage = _pageController.page!;
      if (_currentPage >= 0 && _currentPage < 0.7) {
        indexPage = 0;
      } else if (_currentPage >= 0.7 && _currentPage < 1.7) {
        indexPage = 1;
      } else if (_currentPage >= 1.7 && _currentPage < 2.7) {
        indexPage = 2;
      }
    });
  }

  getShoe(int index) {
    int a = 0;
    a++;
    if (a > listShoes[index].listImage.length) {
      a = 0;
    }
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      setState(() {
        animatedShoe = listShoes[index].listImage[a];
      });
    });
  }

  Color getColor() {
    Color color = listShoes[0].listImage[0].color;
    if (_currentPage >= 0 && _currentPage < 0.7) {
      color = listShoes[0].listImage[0].color;
    } else if (_currentPage >= 0.7 && _currentPage < 1.7) {
      color = listShoes[1].listImage[0].color;
    } else if (_currentPage >= 1.7 && _currentPage < 2.7) {
      color = listShoes[2].listImage[0].color;
    } else if (_currentPage >= 2.7 && _currentPage < 3.7) {
      color = listShoes[3].listImage[0].color;
    } else if (_currentPage >= 3.7 && _currentPage < 4.7) {
      color = listShoes[4].listImage[0].color;
    } else if (_currentPage >= 4.7 && _currentPage < 5.7) {
      color = listShoes[5].listImage[0].color;
    } else if (_currentPage >= 5.7 && _currentPage < 6.7) {
      color = listShoes[6].listImage[0].color;
    } else if (_currentPage >= 6.7 && _currentPage < 7.7) {
      color = listShoes[7].listImage[0].color;
    } else if (_currentPage >= 7.7 && _currentPage < 8.7) {
      color = listShoes[8].listImage[0].color;
    }
    return color;
  }

  @override
  void initState() {
    _pageController.addListener(() {
      _listener();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: List.generate(
                    listCategory.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Text(listCategory[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: index == 0 ? getColor() : Colors.white,
                              )),
                        )),
              ),
            ),
          ),
          Expanded(
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: listShoes.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final shoes = listShoes[index];
                    final listTile = shoes.category.split(' ');
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (context, animation, _) {
                          return DetailShoes(shoes: shoes);
                        }));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: index == indexPage ? 30 : 60.0),
                        child: Transform.translate(
                          offset: Offset(index == indexPage ? 0 : 20, 0),
                          child: LayoutBuilder(builder: (context, constrains) {
                            return AnimatedContainer(
                                duration: Duration(milliseconds: 250),
                                margin: EdgeInsets.symmetric(
                                    vertical: index == indexPage ? 30 : 50),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36),
                                  color: Colors.white,
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 40),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              shoes.category,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              shoes.name,
                                              style: const TextStyle(
                                                fontSize: 28,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(shoes.price,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                            const SizedBox(height: 4),
                                            Expanded(
                                              flex: 5,
                                              child: FittedBox(
                                                child: Text(
                                                  '${listTile[0]} \n ${listTile[1]}',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                    Positioned(
                                        top: a ?? constrains.maxHeight * 0.2,
                                        left: a ?? constrains.maxWidth * 0.05,
                                        right: a ?? -constrains.maxWidth * 0.16,
                                        bottom: b ?? constrains.maxHeight * 0.2,
                                        child: Hero(
                                          tag: shoes.name,
                                          child: Transform.rotate(
                                            angle: index < 3 ? 5.6 : 0,
                                            child: Image(
                                                image: AssetImage(
                                                    shoes.listImage[0].image)),
                                          ),
                                        )),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Material(
                                        color: shoes.listImage[0].color,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(36),
                                            bottomRight: Radius.circular(36)),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: InkWell(
                                            onTap: () {},
                                            child: const SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: Icon(Icons.add, size: 40),
                                            )),
                                      ),
                                    )
                                  ],
                                ));
                          }),
                        ),
                      ),
                    );
                  })),
          Container(
            height: 120,
            padding: const EdgeInsets.all(20),
            child: CustomBottomBar(color: getColor()),
          )
        ],
      ),
    );
  }
}
