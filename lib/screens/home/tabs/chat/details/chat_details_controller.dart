import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:icourseapp/dio/dio_client.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/pusher_mixin.dart';
import 'package:icourseapp/models/chat_item.dart';
import 'package:icourseapp/screens/home/tabs/chat/details/chat_details_repository.dart';
import 'package:icourseapp/widgets/buttons/loading_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../../main.dart';
import '../../../../../models/chat_contacts.dart';
import '../../../../../utils/image_util.dart';
import '../../../home_controller.dart';

class ChatDetailsController extends BaseController with Pusher{

  @override
  ChatDetailsRepository get repository => Get.put(ChatDetailsRepository());

  @override
  onDestroy() {
    Get.delete<ChatDetailsRepository>();
    pusher.unsubscribe(channelName: 'private-chat.${pref.client?.id}.${contacts.id}');
    pusher.disconnect();
  }
  @override
  onCreate() {
    if(!isLoggedIn()) return;
    _markRead();
    _getMessages();
    initPusher(channelName: 'private-chat.${pref.client?.id}.${contacts.id}');
  }


  @override
  void onEvent(PusherEvent event) {
    if(event.eventName.contains('MessageSent')){
      var message = ChatItem.fromMap(jsonDecode(event.data)['message']);
      if(message.id == messages.first.id) return;
      messages.insert(0, message);
    }
  }

  /// Data ******************************************************
  ChatContacts contacts = Get.arguments;
  var messages = <ChatItem>[].obs;
  TextEditingController message = TextEditingController();
  RoundedLoadingButtonController btnController = RoundedLoadingButtonController();


  /// Listeners *************************************************
 onSendMessage(){
   if(message.text.trim().isEmpty) return;
   _sendMessage();
 }

 onSendFile()async{
   message.clear();
   FilePickerResult? result = await FilePicker.platform.pickFiles();
   if(result != null){
     var name = basename(result.files.single.path!);
     var file = await dio.MultipartFile.fromFile(result.files.single.path!);
     _sendFileMessage(name, file);
   }
 }

  onImage()async{
    message.clear();
    ImageUtil imageUtil = ImageUtil();
    var file = await imageUtil.pickImage();
    if (file == null || file.isEmpty) return;
    var name = basename(file.first.path!);
    var image =  await dio.MultipartFile.fromFile(file.first.path!);
    _sendFileMessage(name, image);
  }

 onSaveFile(String fileId, String fileName)async{
   try {
     Directory? downloadsDir;
     if(Platform.isIOS) {
       downloadsDir = await getDownloadsDirectory();
     }
     downloadsDir ??= await getApplicationDocumentsDirectory();

     var response = await http.get(Uri.parse('${DioClient().baseUrl}${String.fromEnvironment("END_POINT_SAVE_FILE")}$fileId'), headers: {
     //var response = await http.get(Uri.parse('${DioClient().baseUrl}${"student/chat/chats/dwonload-file/"}$fileId'), headers: {
       'Accept': 'application/json',
       'Device-Id': deviceId,
       'Content-Type': 'application/json',
       'Authorization': 'Bearer ${pref.client?.token}'
     });
     print('--------> ${response.body}');
     if (response.statusCode == 200) {
       File file = File('${downloadsDir.path}/$fileName');
       await file.writeAsBytes(response.bodyBytes);
       showSuccessMessage('تم حفظ الملف');
     } else {
       showErrorMessage('فشل حفظ الملف');
     }
   } catch (e) {
     showErrorMessage('فشل حفظ الملف');
   }
 }


 /// Api Request **********************************************
 _getMessages()async{
   loading.value = true;
   var resource = await repository.getOldMessages(id: contacts.id.toString());
   loading.value = false;
   if(resource.isSuccess()){
     messages.value = resource.data;
     messages.sort((a,b)=> b.createdAt!.millisecondsSinceEpoch.compareTo(a.createdAt!.millisecondsSinceEpoch));
   }
 }

 _sendMessage()async{
   btnController.start();
   var resource = await repository.sendMessages(id: contacts.id.toString(), message: message.text);
   btnController.stop();
   if(resource.isSuccess()){
     messages.insert(0,ChatItem(senderId: pref.client!.id!, message: message.text));
     message.clear();
   }
 }

 _markRead()async{
   await repository.markRead(id: contacts.id.toString());
   if(Get.isRegistered<HomeController>()){
     Get.find<HomeController>().getCounts();
   }
 }

 _sendFileMessage(String name, dio.MultipartFile file)async{
  var res = await repository.sendMessageWithFile(id: contacts.id.toString(), file: file, baseName: name);
  if(res.isSuccess()){
    messages.insert(0,res.data);
  }
 }

}