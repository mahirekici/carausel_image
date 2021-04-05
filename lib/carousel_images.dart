library carouselimages;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'carousel_indicator.dart';

class CarouselImages extends StatefulWidget {
  final List<String> titles;
  final List<String> subtitles;

  ///List with assets path or url. Required
  final List<String> listImages;

  ///OnTap function. Index = index of active page. Optional
  final Function(int index) onTap;

  final ValueChanged<int> onPageChanged;

  ///Height of whole carousel. Required
  final double height;

  ///Possibility to cached images from network. Optional
  final bool cachedNetworkImage;

  ///Height of nearby images. From 0.0 to 1.0. Optional
  final double scaleFactor;

  ///Border radius of image. Optional
  final double borderRadius;

  ///Vertical alignment of nearby images. Optional
  final Alignment verticalAlignment;

  const CarouselImages(
      {Key key,
      this.titles,
      this.subtitles,
      @required this.listImages,
      @required this.height,
      this.onTap,
      this.onPageChanged,
      this.cachedNetworkImage: false,
      this.scaleFactor = 1.0,
      this.borderRadius,
      this.verticalAlignment})
      : assert(listImages != null),
        assert(height != null),
        assert(scaleFactor != null),
        assert(scaleFactor > 0.0),
        assert(scaleFactor <= 1.0),
        super(key: key);

  @override
  _CarouselImagesState createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  PageController _pageController;
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
    super.dispose();
    _pageController.dispose();
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
            return Stack(children: [
              PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (value) {
                  //widget.onPageChanged = this;

                  setState(() {
                    position = value;
                  });
                },
                controller: _pageController,
                itemCount: widget.listImages.length,
                itemBuilder: (context, position) {
                  double value = (1 -
                          ((_currentPageValue - position).abs() *
                              (1 - widget.scaleFactor)))
                      .clamp(0.0, 1.0);
                  return Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                                height: Curves.ease.transform(value) *
                                    widget.height,
                                child: child),
                            Align(
                              alignment: widget.verticalAlignment != null
                                  ? widget.verticalAlignment
                                  : Alignment.center,
                              child: SizedBox(
                                height: Curves.ease.transform(value) *
                                    widget.height,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      widget.borderRadius != null
                                          ? widget.borderRadius
                                          : 16.0),
                                  child: Transform.translate(
                                      offset: Offset(
                                          (_currentPageValue - position) *
                                              width /
                                              4,
                                          0),
                                      child: widget.listImages[position]
                                              .startsWith('http')
                                          ? widget.cachedNetworkImage
                                              ? CachedNetworkImage(
                                                  imageUrl: widget
                                                      .listImages[position],
                                                  imageBuilder:
                                                      (context, image) =>
                                                          GestureDetector(
                                                    onTap: () => widget.onTap !=
                                                            null
                                                        ? widget.onTap(position)
                                                        : () {},
                                                    child: Image(
                                                        image: image,
                                                        fit: BoxFit.fitHeight),
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () => widget.onTap !=
                                                          null
                                                      ? widget.onTap(position)
                                                      : () {},
                                                  child:
                                                      FadeInImage.memoryNetwork(
                                                    placeholder:
                                                        kTransparentImage,
                                                    image: widget
                                                        .listImages[position],
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                )
                                          : GestureDetector(
                                              onTap: () => widget.onTap != null
                                                  ? widget.onTap(position)
                                                  : () {},
                                              child: Image.asset(
                                                widget.listImages[position],
                                                fit: BoxFit.fitHeight,
                                              ),
                                            )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        margin:
                            EdgeInsets.only(left: 25, right: 25, bottom: 20),
                        height: widget.height,
                        width: width,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.titles[position],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                widget.subtitles[position],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.yellow,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CarouselIndicator(
                  count: widget.listImages.length,
                  index: position,
                ),
              )
            ]);
          },
        ),
      ),
    );
  }
}
