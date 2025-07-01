class PreferencesModel {
  String title;
  bool showMore;
  List<SubItems>? subItems;

  PreferencesModel(
      {required this.title, required this.showMore, this.subItems});
}

class SubItems {
  String? title;
  List<String>? subList;

  SubItems(this.title, this.subList);
}
