import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:photo_view/photo_view.dart';


class ViewImage extends BaseView {
   ViewImage({Key? key}) : super(key: key);

   @override
  Widget buildBody(BuildContext context) {
    return PhotoView(imageProvider: CachedNetworkImageProvider(Get.arguments),backgroundDecoration: BoxDecoration(
      color: Get.theme.scaffoldBackgroundColor
    ),);
  }

  @override
  PageAttributes get pageAttributes => PageAttributes(title: '');
}
