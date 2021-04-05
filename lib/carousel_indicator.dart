import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselIndicator extends StatefulWidget {
  int count;
  int index;

  CarouselIndicator({this.count, this.index});

  @override
  _CarouselIndicatorState createState() => _CarouselIndicatorState();
}

class _CarouselIndicatorState extends State<CarouselIndicator> {
  Widget _getIndicator({Color color = Colors.white}) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget buildRow(int count, int activeIndex) {
    List<Container> list = List<Container>();

    for (var i = 0; i < count; i++) {
      var color = i == activeIndex ? Colors.white : Colors.grey;

      list.add(_getIndicator(color: color));
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: list);
  }

  @override
  Widget build(BuildContext context) {
    return buildRow(widget.count, widget.index);
  }
}
