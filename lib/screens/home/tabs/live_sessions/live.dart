import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/home/tabs/live_sessions/live_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/utils/date_time_util.dart';

class LiveSessions extends BaseView {
  LiveSessions({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(showAppBar: false, showNav: false);

  final _controller = Get.put(LiveController());
  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder<LiveController>(
        init: _controller,
        assignId: true,
        autoRemove: false,
        builder: (_) {
          return Obx(
            () => Stack(
              children: [
                _controller.remoteUid.value == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.logo).paddingOnly(bottom: 10),
                          Text(
                            _controller.isJoined.value
                                ? 'لقد انضممت و في انتظار بدايه المحاضره!'
                                : 'جاري الانضمام .....',
                            style: Get.textTheme.displayMedium!.copyWith(
                                fontSize: 16,
                                color: kPrimary,
                                fontWeight: FontWeight.w700),
                          ).paddingOnly(bottom: 10),
                          Text(
                            DateTimeUtil.toddMMYYYYHHMMAFormat(
                                _controller.sessions.classDate),
                            style: Get.textTheme.displayMedium!
                                .copyWith(fontSize: 14),
                          ).paddingOnly(bottom: 10),
                        ],
                      ).paddingSymmetric(horizontal: 20)
                    : SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: AgoraVideoView(
                          controller: VideoViewController.remote(
                            rtcEngine: _controller.agoraEngine,
                            canvas:
                                VideoCanvas(uid: _controller.remoteUid.value),
                            connection: RtcConnection(
                                channelId: _controller.sessions.channel),
                          ),
                        ),
                      ),
                SafeArea(
                  child: Center(
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: _controller.onToggleAudio,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: _controller.isMuted.value
                                          ? kGreyAF
                                          : kGreen,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    _controller.isMuted.value
                                        ? Icons.mic_off_outlined
                                        : Icons.mic_none_sharp,
                                    color: kWhite,
                                  ).paddingAll(8),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: onPopup,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: kRed, shape: BoxShape.circle),
                                  child: const Icon(
                                    Icons.call,
                                    color: kWhite,
                                  ).paddingAll(8),
                                ),
                              ),
                            ],
                          ).paddingOnly(bottom: 20)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Future<bool> onPopup() async {
    try {
      _controller.agoraEngine.muteLocalAudioStream(true);
      _controller.agoraEngine.muteLocalVideoStream(true);
      _controller.agoraEngine.disableAudio();
      _controller.agoraEngine.disableVideo();
      await _controller.agoraEngine.leaveChannel();
      _controller.agoraEngine.release();
      Get.delete<LiveController>();
    } catch (e, t) {
      print(t);
    }
    Get.back();
    return Future.value(false);
  }
}
