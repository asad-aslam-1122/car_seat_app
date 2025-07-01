import 'dart:io';

class ListTileModel {
  String title;
  File? profileImg;
  String subTitle;
  String? careModel;
  String? carYear;

  ListTileModel(
      {required this.title,
      required this.subTitle,
      this.profileImg,
      this.careModel,
      this.carYear});
}
