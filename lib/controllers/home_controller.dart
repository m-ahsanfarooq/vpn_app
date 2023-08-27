import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/vpn_configuration_model.dart';
import '../models/vpn_model.dart';
import '../preferences.dart';
import '../vpnEngine/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<VpnInfo> vpnInfo = Preferences.vpnInfoObj.obs;

  final vpnConnectionState = VpnEngine.vpnDisconnectedNow.obs;

  Future<void> connectToVpnNow() async {
    if (vpnInfo.value.base64OpenVpnConfigurationData!.isEmpty) {
      Get.snackbar(
          'Country / Location', 'Please select country / location first');
      return;
    }
    if (vpnConnectionState.value == VpnEngine.vpnDisconnectedNow) {
      final dataConfiguration = const Base64Decoder()
          .convert(vpnInfo.value.base64OpenVpnConfigurationData!);
      final configuration = const Utf8Decoder().convert(dataConfiguration);
      final vpnConfiguration = VpnConfiguration(
          userName: 'vpn',
          password: 'vpn',
          countryName: vpnInfo.value.countryLongName,
          config: configuration);
      await VpnEngine.startVpnNow(vpnConfiguration);
    } else {
      VpnEngine.stopVpnNow();
    }
  }

  Color get getRoundButtonColor {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return Colors.redAccent;

      case VpnEngine.vpnConnectedNow:
        return Colors.green;

      default:
        return Colors.orangeAccent;
    }
  }

  String get getRoundButtonText {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return 'Tap to Connect';

      case VpnEngine.vpnConnectedNow:
        return 'Disconnect';

      default:
        return 'Connecting...';
    }
  }
}
