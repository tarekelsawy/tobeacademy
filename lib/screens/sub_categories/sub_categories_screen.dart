import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/models/args/categories_args.dart';
import 'package:icourseapp/screens/categories/categories_controller.dart';
import 'package:icourseapp/screens/categories/widgets/categories_widget.dart';
import 'package:icourseapp/screens/sub_categories/sub_categories_controller.dart';
import 'package:icourseapp/widgets/buttons/base_text_button.dart';
import 'package:icourseapp/widgets/loaders/shimmer/shimmer_list_loader.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';

class SubCategoriesScreen extends BaseView<SubCategoriesController> {
  SubCategoriesScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(title: controller.args.name);

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder(
        init: controller,
        global: false,
        tag: tag,
        assignId: true,
        builder: (_) => ShimmerListLoader(
              controller: _,
              height: 50,
              radius: 8,
              horizontal: 20,
              child: SwipeableListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  controller: _,
                  itemsCount: _.categories.length,
                  itemBuilder: (context, index) {
                    return BaseTextButton(
                      title: _.categories[index].name,
                      radius: 8,
                      onPress:()=> _.onNavigateToCategoriesArgs(
                          CategoriesArgs(
                              id: _.categories[index].id,
                              name: _.categories[index].name)),
                    ).paddingOnly(bottom: 10);
                  }),
            ));
  }
}


