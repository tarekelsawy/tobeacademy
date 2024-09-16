import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/models/chat_item.dart';
import 'package:icourseapp/screens/home/tabs/chat/details/chat_details_controller.dart';
import 'package:icourseapp/widgets/loaders/loader.dart';
import 'package:icourseapp/widgets/view_image.dart';

import '../../../../../dio/dio_client.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_themes.dart';
import '../../../../../widgets/base_text_field.dart';
import '../../../../../widgets/buttons/loading_button.dart';

class ChatDetailsScreen extends BaseView<ChatDetailsController> {
  ChatDetailsScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(
      title: '', resizeToAvoidBottomInset: true, showNav: false,);

  @override
  Widget buildAppBarTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: CachedNetworkImageProvider(
              controller.contacts.image),
        ),
        const SizedBox(width: 8,),
        Expanded(child: Text(controller.contacts.name,style: Get.textTheme.displayMedium!.copyWith(fontSize: 12,fontWeight: FontWeight.w700),)),
      ],
    );
  }

  

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder(
        init: controller,
        tag: tag,
        assignId: true,
        builder: (controller) {
          return Column(
            children: [
              Obx(
                () => controller.loading.value
                    ? const Expanded(
                        child: SizedBox(child: Center(child: Loader())),
                      )
                    : Expanded(
                        child: controller.messages.toList().isEmpty
                            ? Center(
                                child: Text(
                                  'لا يوجد رسائل!',
                                  style: Get.textTheme.displayMedium!
                                      .copyWith(fontSize: 16, color: kPrimary),
                                ),
                              )
                            : ListView.builder(
                                reverse: true,
                                itemCount: controller.messages.toList().length,
                                itemBuilder: (context, i) {
                                  return controller.messages[i].isMe
                                      ? _chatMeItem(controller.messages[i])
                                      : _chatOther(controller.messages[i]);
                                }).paddingSymmetric(horizontal: 20)),
              ),
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      height: 50,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Get.theme.scaffoldBackgroundColor,
                            border: Border.all(color: kGreyE2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: BaseTextField(
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                InkWell(
                                  onTap:controller.onSendFile,
                                  child: const Icon(
                                    Icons.attach_file,
                                    color: kPrimary,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 8,),
                                InkWell(
                                  onTap:controller.onImage,
                                  child: const Icon(
                                    Icons.image,
                                    color: kPrimary,
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                            hintTxt: 'أكتب رسالتك!',
                            controller: controller.message,
                          )),
                    )),
                    const SizedBox(
                      width: 7,
                    ),
                    RoundedLoadingButton(
                      title: 'إرسال',
                      controller: controller.btnController,
                      height: 50,
                      borderRadius: 15,
                      color: kPrimaryGreen,
                      fontSize: 16,
                      fontFamily: kMedium,
                      width: 100,
                      onPressed: controller.onSendMessage,
                    )
                  ],
                ).paddingSymmetric(horizontal: 10, vertical: 5),
              ),
            ],
          );
        });
  }

  Widget _chatMeItem(ChatItem chat) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        constraints: BoxConstraints(maxWidth: Get.width - 80),
        decoration: BoxDecoration(
          color: kPrimary.withOpacity(0.6),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12)),
        ),
        child: chat.attachement != null
            ? chat.isAttachImage
                ? InkWell(
                    onTap: () => Get.to(() => ViewImage(),
                        arguments: chat.attachement?.filePath ?? ''),
                    child: CachedNetworkImage(
                      imageUrl: chat.attachement?.filePath ?? '',
                      height: 100,
                      width: 100,
                    ).paddingSymmetric(horizontal: 8, vertical: 8))
                : InkWell(
                    onTap: () => controller.onSaveFile(
                        chat.attachement!.id.toString(),
                        chat.attachement!.fileName),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          chat.message ?? '',
                          style: Get.textTheme.displayMedium!.copyWith(
                              fontSize: 14,
                              height: 1.2,
                              color: kWhite,
                              decoration: TextDecoration.underline),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.download,
                          color: kWhite,
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 8, vertical: 8),
                  )
            : Text(
                chat.message ?? '',
                style: Get.textTheme.displayMedium!
                    .copyWith(fontSize: 14, height: 1.2, color: kWhite),
              ).paddingSymmetric(horizontal: 8, vertical: 8),
      ),
    ).paddingOnly(bottom: 10);
  }

  Widget _chatOther(ChatItem chat) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Container(
        constraints: BoxConstraints(maxWidth: Get.width - 80),
        decoration: BoxDecoration(
          border: Border.all(color: kPrimary),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
        ),
        child: chat.attachement != null
            ? chat.isAttachImage
                ? InkWell(
                    onTap: () => Get.to(() => ViewImage(),
                        arguments: chat.attachement?.filePath ?? ''),
                    child: CachedNetworkImage(
                      imageUrl: chat.attachement?.filePath ?? '',
                      height: 100,
                      width: 100,
                    ).paddingSymmetric(horizontal: 8, vertical: 8))
                : InkWell(
                    onTap: () => controller.onSaveFile(
                        chat.attachement!.id.toString(),
                        chat.attachement!.fileName),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          chat.message ?? '',
                          style: Get.textTheme.displayMedium!.copyWith(
                              fontSize: 14,
                              height: 1.2,
                              decoration: TextDecoration.underline),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.download,
                          color: Get.textTheme.displayMedium!.color,
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 8, vertical: 8),
                  )
            : Text(
                chat.message ?? '',
                style: Get.textTheme.displayMedium!
                    .copyWith(fontSize: 14, height: 1.2),
              ).paddingSymmetric(horizontal: 8, vertical: 8),
      ),
    ).paddingOnly(bottom: 10);
  }
}
