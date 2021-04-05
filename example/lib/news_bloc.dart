import 'dart:async';

import 'package:example/repository_dump.dart';

import 'carousel_item.dart';

class NewsBloc {
  final Repository _repository = Repository();
  Stream<CarouselReponse> get getMovies async* {
    yield await _repository.fetchNews();
  }
}

final newsBloc = NewsBloc();
