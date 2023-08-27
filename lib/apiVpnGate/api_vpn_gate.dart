import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/ip_info_model.dart';
import '../models/vpn_model.dart';
import '../preferences.dart';

class ApiVpnGate {

  static Future<List<VpnInfo>> getAllFreeVpnServer() async {
    final List<VpnInfo> vpnServerList = [];
    try {
      final resp =
          await http.get(Uri.parse('http://www.vpngate.net/api/iphone'));
      final commaSeperatedString = resp.body.split('#')[1].replaceAll('*', '');
      List<List<dynamic>> listData =
          const CsvToListConverter().convert(commaSeperatedString);
      debugPrint('============${listData[0]}');
      final header = listData[0];

      for (int count = 1; count < listData.length - 1; count++) {
        Map<String, dynamic> jsonData = {};
        for (int innerCount = 0; innerCount < header.length; innerCount++) {
          jsonData.addAll(
              {header[innerCount].toString(): listData[count][innerCount]});
        }
        vpnServerList.add(VpnInfo.fronJson(jsonData));
      }
    } catch (error) {
      Get.snackbar('Error Occurred', error.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.redAccent.withOpacity(0.8));
    }

    vpnServerList.shuffle();
    if (vpnServerList.isNotEmpty) {
      Preferences.vpnList = vpnServerList;
    }

    return vpnServerList;
  }

  static Future<void> getIPDetails({required Rx<IpInfo> ipInfo}) async {
    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(response.body);
      ipInfo.value = IpInfo.fromJson(data);
    } catch (error) {
      Get.snackbar('Error Occurred', error.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.redAccent.withOpacity(0.8));
    }
  }
}
