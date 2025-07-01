import 'dart:io';

class ContactModel {
  File? profileImage;
  String name;
  String mobileNumber;
  String relation;
  String purity;

  ContactModel(
      {this.profileImage,
      required this.name,
      required this.mobileNumber,
      required this.relation,
      required this.purity});
}
