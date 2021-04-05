import 'package:carousel_images/carausel_text_item.dart';
import 'package:carousel_images/carousel_text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_images/carousel_images.dart';

import 'carousel_item.dart';
import 'news_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Demo "),
      ),
      body: HomePage(),
    ));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  setPageIndex(int index) {}

  onPageChanged(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CarouselReponse>(
      stream: newsBloc.getMovies,
      builder: (context, AsyncSnapshot<CarouselReponse> snapshot) {
        if (snapshot.hasData) {
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(CarouselReponse carouselReponse) {
    var listImages = carouselReponse.list.map((e) => e.imageUrl).toList();

    var height = MediaQuery.of(context).size.height;

    var titles = carouselReponse.list.map((e) => e.title).toList();

    var subtitles = carouselReponse.list.map((e) => e.subTitle).toList();

    var writers = carouselReponse.writers
        .map((e) => CarauselTextItem(
            avatarName: e.name,
            avatarImage: e.imageUrl,
            title: e.title,
            subtitle: e.subTitle))
        .toList();

    return Container(
      //height: height,
      // color: Colors.black,
      child: Material(
        //  color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CarouselImages(
                scaleFactor: 1.0,
                titles: titles,
                subtitles: subtitles,
                listImages: listImages,
                height: height * 0.5,
                borderRadius: 0.0,
                cachedNetworkImage: true,
                verticalAlignment: Alignment.topCenter,
                onTap: (index) {},
                onPageChanged: onPageChanged,
              ),
              CarauselText(
                carauselTextItems: writers,
                height: 500,
                title: "YAZARLAR",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
