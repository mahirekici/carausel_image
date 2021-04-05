import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'carausel_text_item.dart';

class CarauselText extends StatefulWidget {
  final List<CarauselTextItem> carauselTextItems;
  final Function(int index) onTap;
  final ValueChanged<int> onPageChanged;
  final double height;
  final String title;

  CarauselText(
      {this.title,
      this.carauselTextItems,
      this.height,
      this.onTap,
      this.onPageChanged});

  @override
  _CarauselTextViewState createState() => _CarauselTextViewState();
}

class _CarauselTextViewState extends State<CarauselText> {
  PageController _pageController;
  double pageOffset = 0;

  double _currentPageValue = 0.0;
  int position = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: widget.height,
      child: Material(
        color: Colors.black,
        child: AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            return PageView.builder(
              physics: BouncingScrollPhysics(),
              onPageChanged: (value) {
                //widget.onPageChanged = this;

                setState(() {
                  position = value;
                });
              },
              controller: _pageController,
              itemCount: widget.carauselTextItems.length,
              itemBuilder: (context, position) {
                double value =
                    (1 - ((_currentPageValue - position).abs() * (1 - 1.0)))
                        .clamp(0.0, 1.0);
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Stack(
                        children: <Widget>[
                          SizedBox(
                              height:
                                  Curves.ease.transform(value) * widget.height,
                              child: child),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height:
                                  Curves.ease.transform(value) * widget.height,
                              child: ClipRRect(
                                child: Transform.translate(
                                    offset: Offset(
                                        (_currentPageValue - position) *
                                            width /
                                            4,
                                        0),
                                    child: TextContent(
                                      item: widget.carauselTextItems[position],
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  final CarauselTextItem item;

  const TextContent({
    Key key,
    @required this.item,
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
                    image: new NetworkImage(item.avatarImage)))),
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
            item.avatarName,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          Text(
            "25 Mart Perşembe 2025",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 13,
            ),
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
              item.title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
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
              item.subtitle,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.amber, child: _newsWriterWidget());
  }
}
