import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:icourseapp/dio/dio_client.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../main.dart';

mixin Pusher {
  /// Data *********************************************************************
  final pusher = PusherChannelsFlutter.getInstance();

  /// Init *********************************************************************
  initPusher({required String channelName}) async {
    try {
      await pusher.init(
        apiKey: 'c72ccfe636c1167b71d5',
        cluster: 'mt1',
        onAuthorizer: onAuthorizer,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
      );
      await pusher.subscribe(channelName: channelName);
      await pusher.connect();
    } catch (e) {
      debugPrint("Pusher  ERROR: $e");
    }
  }

  /// Callbacks ****************************************************************
  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    debugPrint("PusherState :: Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    debugPrint("PusherState onError: $message code: $code exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    debugPrint("PusherState onSubscriptionSucceeded: $channelName data: $data");
  }

  void onEvent(PusherEvent event);

  void onSubscriptionError(String message, dynamic e) {
    debugPrint("PusherState onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    debugPrint("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    debugPrint("PusherState onMemberAdded: $channelName member: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    debugPrint("PusherState onMemberRemoved: $channelName member: $member");
  }

  dynamic onAuthorizer(
      String channelName, String socketId, dynamic options) async {
    try{
      DioClient dioClient = DioClient(baseUrl:const String.fromEnvironment("BASE_URL") );
      //DioClient dioClient = DioClient(baseUrl:"https://tobeacademy.ietls-gtwenty.live/broadcasting/auth" );
      var response = await dioClient.dio.get('',data: {
        'socket_id':socketId,
        'channel_name': channelName
      });
      return response.data;
    }catch(e){
    }
  }
}
