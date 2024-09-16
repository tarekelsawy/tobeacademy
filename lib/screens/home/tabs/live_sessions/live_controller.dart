import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/sessions.dart';
import 'package:icourseapp/screens/home/tabs/live_sessions/live_sessions_repository.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../main.dart';

class LiveController extends BaseController{
  @override
  BaseRepository? get repository => null;

  Rx<int?> remoteUid = Rx(null);
  var isJoined = false.obs;
  var isMuted = false.obs;
  var isHost = false.obs;
  var textMsg = ''.obs;
  late RtcEngine agoraEngine;

  onToggleAudio(){
    isMuted.value = !isMuted.value;
    agoraEngine.muteLocalAudioStream(isMuted.value);
  }
  Sessions sessions = Get.arguments;
  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(
      appId: '28b0eb0edfde422e81db908d413c6262',
    ));

    await agoraEngine.enableAudio();
    await agoraEngine.enableVideo();
    agoraEngine.muteLocalVideoStream(true);

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          isJoined.value = true;
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          print('remote ------------> ${remoteUid}');
          if(remoteUid == sessions.userId) {
            this.remoteUid.value = remoteUid;
          }
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          if(remoteUid == sessions.userId) {
            this.remoteUid.value = null;
          }
        },
        onError: (error,v){
          showErrorMessage(error.name);
        },
        onConnectionStateChanged: (rtcConnection, type, changeReason){
          textMsg.value = type.name;
        }
      ),
    );
  }

  void join() async {
    // Set channel options
    var token = await getToken();

    print('Token ------------------> $token');
    await agoraEngine.joinChannel(
      token: token,
      channelId: sessions.channel,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ),
      uid: pref.client?.id??0,
    );
  }

  @override
  onCreate() async{
   await setupVideoSDKEngine();
    join();
  }


  Future<String> getToken()async{
    var resource = await LiveSessionsRepository().getTokenData(channel: sessions.channel);
    if(resource.isSuccess()) return resource.data['token'];
    return '';
  }
}