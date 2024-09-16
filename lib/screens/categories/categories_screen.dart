import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/categories/categories_controller.dart';
import 'package:icourseapp/screens/categories/widgets/categories_widget.dart';
import 'package:icourseapp/widgets/loaders/shimmer/shimmer_list_loader.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';

class CategoriesScreen extends BaseView<CategoriesController> {
  CategoriesScreen({Key? key}) : super(key: key);

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
        builder: (_)=> ShimmerListLoader(
          shimmerLoaderType: ShimmerLoaderType.borderGrid,
          controller: _,
          height: 180,
          radius: 25,
          horizontal: 20,
          child: SwipeableListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            controller: _,
            itemsCount: _.categories.length,
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _.categories.length,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9
                ),
                itemBuilder: (context, index) {
                  return  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10),
                    child: CategoriesWidget(
                      onTap: _.onNavigateToCategoriesArgs,
                        category:
                        _.categories[index]),
                  );
                })
          ),
        ));
  }
}
