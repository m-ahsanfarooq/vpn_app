import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/vpn_configuration_model.dart';
import '../models/vpn_status_model.dart';

class VpnEngine {
  static final String eventChannelVpnStage = 'vpnStage';
  static final String eventChannelVpnStatus = 'vpnStatus';
  static final String methodChannelVpnControl = 'vpnControl';
  static const String vpnConnectedNow = 'connected';
  static const String vpnDisconnectedNow = 'disconnected';
  static const String vpnWaitConnectedNow = 'wait_connection';
  static const String vpnAuthenticationNow = 'authentication';
  static const String vpnReconnectNow = 'reconnect';
  static const String vpnNoConnectNow = 'no_connection';
  static const String vpnConnectingNow = 'connecting';
  static const String vpnPrepareNow = 'prepare';
  static const String vpnDeniedNow = 'denied';

  //vpn connection stage
  static Stream<String> snapshotVpnStage() =>
      EventChannel(eventChannelVpnStage).receiveBroadcastStream().cast();

  //vpn connection status
  static Stream<VpnStatus> snapshotVpnStatus() =>
      EventChannel(eventChannelVpnStatus)
          .receiveBroadcastStream()
          .map((eventStatus) => VpnStatus.fromJson(jsonDecode(eventStatus)))
          .cast();

  static Future<void> startVpnNow(VpnConfiguration vpnConfiguration) async {
    return MethodChannel(methodChannelVpnControl).invokeMethod('start', {
      'config': vpnConfiguration.config,
      'country': vpnConfiguration.countryName,
      'username': vpnConfiguration.userName,
      'password': vpnConfiguration.password
    });
  }

  static Future<void> stopVpnNow() {
    return MethodChannel(methodChannelVpnControl).invokeMethod('stop');
  }

  static Future<void> killSwitchOpenNow() {
    return MethodChannel(methodChannelVpnControl).invokeMethod('kill_switch');
  }

  static Future<void> refreshStageNow() {
    return MethodChannel(methodChannelVpnControl).invokeMethod('refresh');
  }

  static Future<String?> getStageNow() {
    return MethodChannel(methodChannelVpnControl).invokeMethod('stage');
  }

  static Future<bool> isConnectedNow() {
    return getStageNow().then((valueStage) => valueStage!.toLowerCase()=='connected');
  }



}
