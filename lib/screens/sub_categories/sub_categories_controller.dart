import 'package:get/get.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/args/categories_args.dart';
import 'package:icourseapp/models/category.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/sub_categories/sub_categories_repository.dart';

class SubCategoriesController extends SwipeableController{
  @override
  loadMore() {
    stopLoading();
  }

  @override
  onRefresh() {
    // stopLoading();
    categories.clear();
    _getCategories();
  }

  @override
  onCreate() {
    paginationEnabled(false);
    loading.value = true;
    _getCategories();
  }

  @override
  SubCategoriesRepository get repository => Get.find(tag: tag);

  /// Data ********************************************************
  CategoriesArgs args = Get.arguments;
  var categories = <Category>[];

  /// Listeners ********************************************************
  onNavigateToCategoriesArgs(CategoriesArgs args)async{
     Get.toNamed(Routes.categoriesCourses,arguments: args);
  }

  /// Logic ****************************************************
  _categoriesResponse(Resource resource) {
    stopLoading();
    if (resource.isError()) return;
    categories.addAll(resource.data);
    update();
  }

  /// Api Requests *********************************************
  _getCategories() async {
    var resource = await repository.getCategories(id: args.id);
    _categoriesResponse(resource);
  }

}