import 'dart:io';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:url_launcher/url_launcher_string.dart';
class AppUtil {
 static final noScreenshot = NoScreenshot.instance;
  static downloadLink(String url) async {
    await canLaunchUrlString(url) ? await launchUrlString(url) : throw 'Could not launch $url';
  }

  static openFile(String url) async {
    await canLaunchUrlString(url) ? await launchUrlString(url) : throw 'Could not launch $url';
  }

  static Future<void> download({required String? url}) async {
    if (url == null || url.isEmpty) return;
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  // static Future<String?> downloadFile({required String imageUrl, String? ext}) async {
  //   try {
  //     Dio dio = Dio();
  //     Response response = await dio.get(imageUrl, options: Options(responseType: ResponseType.bytes, followRedirects: false,),);
  
  //     // the downloads folder path
  //     Directory? tempDir = await DownloadsPath.downloadsDirectory();
  //     String? tempPath = tempDir?.path;
  //     var filePath = '${tempPath!}/${DateTime.now().millisecondsSinceEpoch}.${imageUrl.substring(imageUrl.lastIndexOf('.'))}';
  
  //     File file = File(filePath);
  //     var raf = file.openSync(mode: FileMode.write);
  //     raf.writeFromSync(response.data);
  //     await raf.close();
  //     return filePath;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return null;
  //   }
  // }

  // static Future<String> getFilePath(uniqueFileName) async {
  //   String path = '';
  //   Directory dir = await getApplicationDocumentsDirectory();
  //   path = '${dir.path}/$uniqueFileName';
  //   return path;
  // }

  // static Future<int> getAndroidBuildSDK() async {
  //   if (Platform.isAndroid) {
  //     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     return androidInfo.version.sdkInt;
  //   }
  //   return 0;
  // }
}
