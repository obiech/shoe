import 'package:flutter/material.dart';
import 'package:shoe/MODEL/shoes.dart';
import 'package:shoe/widgets/custom_button.dart';
import 'package:shoe/widgets/transition.dart';

class DetailShoes extends StatefulWidget {
  const DetailShoes({Key? key, required this.shoes}) : super(key: key);
  final Shoes shoes;
  @override
  _DetailShoesState createState() => _DetailShoesState();
}

class _DetailShoesState extends State<DetailShoes> {
  int valueIndexColor = 0;
  int valueIndexSize = 1;

  double sizeShoes(int index, Size size) {
    switch (index) {
      case 0:
        return (size.height * 0.09);
      case 1:
        return (size.height * 0.07);
      case 2:
        return (size.height * 0.05);
      case 3:
        return (size.height * 0.04);
      default:
        return (size.height * 0.05);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: -size.height * 0.15,
              right: -size.height * 0.20,
              child: TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 250),
                  tween: Tween(begin: 0, end: 1),
                  builder: (context, value, __) {
                    return AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        height: value * (size.height * 0.5),
                        width: value * size.height * 0.5,
                        decoration: BoxDecoration(
                          color: widget.shoes.listImage[valueIndexColor].color,
                          shape: BoxShape.circle,
                        ));
                  })),
          Positioned(
              top: kToolbarHeight,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.black,
                      )),
                  IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                ],
              )),
          Positioned(
            top: size.height * 0.20,
            right: 0,
            left: 0,
            child: Padding(
                padding: EdgeInsets.all(30),
                child: FittedBox(
                    child: Text(widget.shoes.category,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[100])))),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            top: size.height * 0.165,
            right: sizeShoes(valueIndexSize, size),
            left: sizeShoes(valueIndexSize, size),
            child: Hero(
                tag: widget.shoes.name,
                child: Transform.rotate(angle: 5.6,
                  child: Image(
                      image: AssetImage(
                          widget.shoes.listImage[valueIndexColor].image)),
                )),
          ),
          Positioned(
              top: size.height * 0.6,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ShakeTransition(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.shoes.category,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(widget.shoes.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20))
                            ]),
                      ),
                      ShakeTransition(
                          left: false,
                          child: Text(
                            widget.shoes.price,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ))
                    ],
                  ),
                  ShakeTransition(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: List.generate(
                              5,
                              (index) => Icon(Icons.star,
                                  color: widget.shoes.punctuation > index
                                      ? widget.shoes.listImage[valueIndexColor]
                                          .color
                                      : Colors.white)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'SIZE',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                            children: List.generate(
                                4,
                                (index) => Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: CustomButton(
                                      onTap: () {
                                        valueIndexSize = index;
                                        setState(() {});
                                      },
                                      color: index == valueIndexSize
                                          ? widget.shoes
                                              .listImage[valueIndexColor].color
                                          : Colors.white,
                                      child: Text(
                                        ' ${index + 7}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                            color: index == valueIndexSize
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    )))),
                      ],
                    ),
                  )
                ],
              )),
          Positioned(
              top: size.height * 0.84,
              left: 16,
              right: 16,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShakeTransition(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'COLOR',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: List.generate(
                              widget.shoes.listImage.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      valueIndexColor = index;
                                      setState(() {});
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(right: 8),
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: widget
                                                .shoes.listImage[index].color,
                                            shape: BoxShape.circle,
                                            border: index == valueIndexColor
                                                ? Border.all(
                                                    color: Colors.white,
                                                    width: 2)
                                                : null)),
                                  )),
                        )
                      ],
                    ),
                  ),
                  ShakeTransition(
                    left: false,
                    child: CustomButton(
                        onTap: () {},
                        width: 100,
                        color: widget.shoes.listImage[valueIndexColor].color,
                        child: Text('BUY',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
