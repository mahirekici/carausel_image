import 'package:example/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'HexColor.dart';

class NewsWriterView extends StatefulWidget {
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<NewsWriterView> {
  PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("E6E8E1"),
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "YAZARLAR",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: HexColor('7E1F25')),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width,
            child: PageView(
              controller: pageController,
              children: <Widget>[
                SlidingCard2(
                  name: "dssdv",
                  parentTitle: "sdvsdv",
                  offset: pageOffset,
                ),
                SlidingCard2(
                  name: "dssdv",
                  parentTitle: "sdvsdv",
                  offset: pageOffset - 1,
                ),
                SlidingCard2(
                  name: "dssdv",
                  parentTitle: "sdvsdv",
                  offset: pageOffset - 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlidingCard2 extends StatelessWidget {
  final String name;
  final String parentTitle;
  final double offset;

  const SlidingCard2({
    Key key,
    @required this.name,
    @required this.parentTitle,
    @required this.offset,
  }) : super(key: key);

  Widget _cirleAvatar() {
    return Center(
        child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
            width: 55.0,
            height: 55.0,
            margin: EdgeInsets.all(5),
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new NetworkImage(
                        "https://img.piri.net/mnresize/250/2000/resim/imagecrop/2015/11/30/resized_acb3d-eaec304acircle4.png")))),
      ],
    ));
  }

  Widget yazarInfo() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Gökhan Özcan",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: HexColor('7E1F25')),
          ),
          Text(
            "25 Mart Perşembe 2025",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 13,
                color: HexColor('1F262C')),
          )
        ],
      ),
    );
  }

  Widget _newsWriterWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              TextUtil.text1,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: HexColor('1F262C')),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              children: [_cirleAvatar(), yazarInfo()],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              TextUtil.text1,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: HexColor('1F262C'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-42 * gauss * offset.sign, 0),
      child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 0.5, color: Colors.grey),
              right: BorderSide(width: 0.5, color: Colors.grey),
            ),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black38,
            //     blurRadius: 5.0,
            //   ),
            // ],
          ),
          // height: MediaQuery.of(context).size.height * 0.5,
          // width: MediaQuery.of(context).size.width,
          alignment: Alignment(-offset.abs(), 0),
          child: _newsWriterWidget()),
    );
  }
}
