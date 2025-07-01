import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../resources/resources.dart';
import 'image_picker_option.dart';

class ImageWidget extends StatefulWidget {
  final String? url;
  final bool? isFile;
  final ValueChanged<File?>? uploadImage;
  final double height;
  final double width;
  final bool isProfile;
  final bool isShowCamera;
  final String? avatar;
  const ImageWidget({
    super.key,
    this.url,
    this.isFile,
    this.uploadImage,
    this.avatar,
    this.isProfile = false,
    this.isShowCamera = true,
    required this.height,
    required this.width,
  });

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  File? pickedFile;
  @override
  Widget build(BuildContext context) {
    return widget.isFile == true
        ? GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Get.bottomSheet(
                ImagePickerOption(
                  uploadImage: (value) {
                    if (value != null) {
                      pickedFile = value;
                      widget.uploadImage!(pickedFile!);
                      setState(() {});
                    }
                  },
                  isOptionEnable: false,
                ),
                isScrollControlled: true,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: R.appColors.white),
              ),
              child: pickedFile != null
                  ? Container(
                      height: widget.height,
                      width: widget.width,
                      decoration: BoxDecoration(
                        color: R.appColors.lightGreyColor,
                        image: DecorationImage(
                          image: FileImage(pickedFile!),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: widget.isShowCamera
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Icon(
                                Icons.camera_alt,
                                size: 22,
                                color: R.appColors.iconsGreyColor,
                              ),
                            )
                          : null,
                    )
                  : Container(
                      height: widget.height,
                      width: widget.width,
                      decoration: BoxDecoration(
                          color: R.appColors.lightGreyColor,
                          shape: BoxShape.circle),
                      padding: const EdgeInsets.all(2),
                      child: widget.isShowCamera == true
                          ? Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      widget.avatar ?? R.appImages.profileIcon),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 22,
                                  color: R.appColors.iconsGreyColor,
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      widget.avatar ?? R.appImages.profileIcon),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                              ),
                            )),
            ),
          )
        : GestureDetector(
            onTap: () {
              Get.bottomSheet(
                ImagePickerOption(
                  uploadImage: (value) {
                    if (value != null) {
                      pickedFile = value;
                      widget.uploadImage!(pickedFile!);
                      setState(() {});
                    }
                  },
                  isOptionEnable: false,
                ),
                isScrollControlled: true,
              );
            },
            child: CachedNetworkImage(
              imageUrl: widget.url ?? "",
              imageBuilder: (context, imageProvider) => Container(
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                  color: R.appColors.lightGreyColor,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  shape:
                      widget.isProfile ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius:
                      widget.isProfile ? null : BorderRadius.circular(8),
                  border: Border.all(
                      width: 1,
                      color: widget.isProfile
                          ? R.appColors.white
                          : R.appColors.transparent),
                ),
                child: widget.isShowCamera
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Icon(
                          Icons.camera_alt,
                          size: 22,
                          color: R.appColors.iconsGreyColor,
                        ),
                      )
                    : null,
              ),
              placeholder: (context, url) => Container(
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                  color: R.appColors.lightGreyColor,
                  shape:
                      widget.isProfile ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius:
                      widget.isProfile ? null : BorderRadius.circular(8),
                  border: Border.all(
                      width: 1,
                      color: widget.isProfile
                          ? R.appColors.white
                          : R.appColors.transparent),
                ),
                child: SpinKitPulse(color: R.appColors.lightGreyColor),
              ),
              errorWidget: (context, url, error) => Container(
                  height: widget.height,
                  width: widget.width,
                  decoration: BoxDecoration(
                    color: R.appColors.lightGreyColor,
                    shape:
                        widget.isProfile ? BoxShape.circle : BoxShape.rectangle,
                    borderRadius:
                        widget.isProfile ? null : BorderRadius.circular(8),
                    border: Border.all(
                        width: 1,
                        color: widget.isProfile
                            ? R.appColors.white
                            : R.appColors.transparent),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.error,
                      color: R.appColors.red,
                      size: 25,
                    ),
                  )),
            ),
          );
  }
}
