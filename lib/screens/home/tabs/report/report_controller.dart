import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/report.dart';
import 'package:icourseapp/screens/home/tabs/report/report_repository.dart';

class ReportController extends BaseController{
  @override
  injectRepository() {
    Get.put(ReportRepository());
  }

  @override
  onDestroy() {
    Get.delete<ReportRepository>();
  }

  @override
  onCreate() {
    if(!isLoggedIn()) return;
    loading.value = true;
    _getCourses();
  }

  @override
  ReportRepository get repository => Get.find();


  /// listeners *******************************************

  /// Data *************************************************
  Report? report;

  /// logic ***************************************
  _coursesResponse(Resource resource){
    if(resource.isError()) return;
    stopLoading();
    report = resource.data;
    update();
  }
  /// Api Requests ***************************************
  _getCourses()async{
    var resource = await repository.getReports();
    _coursesResponse(resource);
  }
}