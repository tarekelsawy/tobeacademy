import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/report.dart';
import 'package:icourseapp/utils/api.dart';

class ReportRepository extends BaseRepository {
  Future<Resource> getReports() {
    return request(callback: () async {
      var response = await dio
          .get(Api.getReport);

      var report = Report.fromMap(response.data);
      return Resource.success(
          data: report);
    });
  }
}
