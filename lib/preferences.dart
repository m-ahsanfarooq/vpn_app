import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'models/vpn_model.dart';

class Preferences {
  static late Box boxOfData;

  static Future<void> initHive() async {
    await Hive.initFlutter();
    boxOfData = await Hive.openBox('data');
  }

  static bool get isModeDark => boxOfData.get('isModeDark') ?? false;

  static set isModeDark(bool value) => boxOfData.put('isModeDark', value);

  static VpnInfo get vpnInfoObj =>
      VpnInfo.fronJson(jsonDecode(boxOfData.get('vpn')?? '{}'));
  static set vpnInfoObj(VpnInfo value) => boxOfData.put('vpn', jsonEncode(value));

  static List<VpnInfo> get vpnList{
    List<VpnInfo> tempVpnList =[];
    final dataVpn= jsonDecode(boxOfData.get('vpnList')??'[]');

    for (var data in dataVpn){
      tempVpnList.add(VpnInfo.fronJson(data));
    }
    return tempVpnList;
  }

  static set vpnList(List<VpnInfo> value) => boxOfData.put('vpnList', jsonEncode(value));





}
