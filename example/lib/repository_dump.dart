import 'package:example/carousel_item.dart';
import 'package:example/utils.dart';

class Repository {
  Future<CarouselReponse> fetchNews() async {
    var a1 = CarouselItem(
        imageUrl:
            "https://img.piri.net/mnresize/500/-/resim/imagecrop/2021/03/26/07/12/resized_8dfd6-0401_tur_picture_20210326_24104233_24104230.jpg",
        title:
            "Paris'in ortasında düzensiz göçmenler hükümete tepkilerini göstermek için kamp kurdu",
        subTitle: "Avrupa");

    var a2 = CarouselItem(
        imageUrl:
            "https://img.piri.net/mnresize/500/-/resim/imagecrop/2021/03/25/10/15/resized_e8d0a-8823e36a29883_mtywntrhzd.jpg",
        title:
            "Türkiye’nin ilk Karanlık Gökyüzü Parkı Bursa’da kurulacak: Her şey daha karanlık bir gökyüzü için",
        subTitle: "Türkiye");

    var a3 = CarouselItem(
        imageUrl:
            "https://img.piri.net/mnresize/500/-/resim/imagecrop/2021/03/26/07/36/resized_8dbc2-c52d4e0900.jpg",
        title: "20 il için yoğun kar uyarısı!",
        subTitle: "Avrupa");

    var a4 = CarouselItem(
        imageUrl:
            "https://img.piri.net/mnresize/500/-/resim/imagecrop/2021/03/26/05/40/resized_5047a-e29c51e82021032424748539163647304fjdvxcdo.webp",
        title: "Erdoğan'ın anayasa çağrısına tam destek: Zamanı geldi",
        subTitle: "Avrupa");

    var b1 = Writer(
        name: "Yusuf Kaplan",
        imageUrl:
            "https://img.piri.net/mnresize/250/2000/resim/imagecrop/2015/06/07/resized_1520b-c879yusufkaplan1.png",
        title:
            "Üç bilimsel devrim, üç büyük anlam krizi ve insanlığın geleceği",
        subTitle: TextUtil.text1);

    var b2 = Writer(
        name: "Hasan Öztürk",
        imageUrl:
            "https://img.piri.net/mnresize/250/2000/resim/imagecrop/2016/03/14/10/56/resized_6856c-8bbd488fhasanozturk.png",
        title:
            "Sürdürülebilir siyaset için Ak Parti’de oluşturulan yeni kadro üzerine",
        subTitle: TextUtil.text1);

    var b3 = Writer(
        name: "Ahmet Ulusoy",
        imageUrl:
            "https://img.piri.net/mnresize/250/2000/resim/imagecrop/2018/05/17/11/41/resized_3310c-0ddce41ccircle5.png",
        title: "Belediye borçlanmalarına sınırlama",
        subTitle: TextUtil.text1);

    return CarouselReponse(list: [a1, a2, a3, a4], writers: [b1, b2, b3]);
  }
}
