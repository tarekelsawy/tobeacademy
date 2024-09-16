import 'package:get/get.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/args/categories_args.dart';
import 'package:icourseapp/models/category.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/organization/organizations_repository.dart';

class OrganizationsController extends SwipeableController{
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
  OrganizationsRepository get repository => Get.find(tag: tag);

  /// Data ********************************************************
  var categories = <Category>[];

  /// Listeners ********************************************************
  onNavigateToCategoriesArgs(CategoriesArgs args)async{
    Get.toNamed(Routes.categories,arguments: args);
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
    var resource = await repository.getOrganizations();
    _categoriesResponse(resource);
  }

}