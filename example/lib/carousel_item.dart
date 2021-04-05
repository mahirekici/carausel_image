class CarouselItem {
  String imageUrl;
  String title;
  String subTitle;
  CarouselItem({this.imageUrl, this.title, this.subTitle});
}

class Writer {
  String name;
  String imageUrl;
  String title;
  String subTitle;
  Writer({this.name, this.imageUrl, this.title, this.subTitle});
}

class CarouselReponse {
  List<CarouselItem> list;
  List<Writer> writers;
  CarouselReponse({this.list, this.writers});
}
