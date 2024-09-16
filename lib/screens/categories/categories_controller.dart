import 'package:get/get.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/args/categories_args.dart';
import 'package:icourseapp/models/category.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/categories/categories_repository.dart';

class CategoriesController extends SwipeableController{
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
  CategoriesRepository get repository => Get.find(tag: tag);

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
    // Future.delayed(const Duration(seconds: 1,milliseconds: 500),(){
    //   stopLoading();
    //   categories.add(Category(id: 2, name: 'كليه الهندسه', image: 'https://ongineering.com/images/Articles_Aziz/19220.jpg'));
    //   categories.add(Category(id: 1, name: 'كليه الحاسبات والمعلومات', image: 'https://tariik.com/wp-content/uploads/2022/07/%D8%AA%D9%83%D9%86%D9%88%D9%84%D9%88%D8%AC%D9%8A%D8%A7-%D8%A7%D9%84%D8%B9%D9%84%D9%88%D9%85%D8%A7%D8%AA.png'));
    //   categories.add(Category(id: 3, name: 'كليه العلوم', image: 'https://e7.pngegg.com/pngimages/690/33/png-clipart-science-icon-creative-painted-icon-science-and-technology-watercolor-painting-text.png'));
    //   categories.add(Category(id: 4, name: 'كليه الطب', image: 'https://fmhs.najah.edu/media/filer_public_thumbnails/filer_public/d1/44/d144f62d-d7ea-4e26-b43b-1b81148e7c6f/medicine.jpg__720x540_q85_crop_subsampling-2_upscale.jpg'));
    //   categories.add(Category(id: 5, name: 'كليه الاداب', image: 'https://tariik.com/wp-content/uploads/2022/07/%D8%A2%D8%AF%D8%A7%D8%A8-%D8%B9%D9%84%D9%85-%D8%A7%D8%AC%D8%AA%D9%85%D8%A7%D8%B9.png'));
    //   categories.add(Category(id: 6, name: 'كليه التجاره', image: 'https://suezuni.edu.eg/upload/StaticContentValues/PhotoA/340/dddd.png'));
    //   update();
    // });
    var resource = await repository.getCategories(id: args.id);
    _categoriesResponse(resource);
  }

}