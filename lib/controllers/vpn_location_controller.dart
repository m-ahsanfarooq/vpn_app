import 'package:get/get.dart';

import '../apiVpnGate/api_vpn_gate.dart';
import '../models/vpn_model.dart';
import '../preferences.dart';

class VpnLocationController extends GetxController{
  List<VpnInfo> vpnServerList = Preferences.vpnList;

  final RxBool isLoadingNewLocation = false.obs;

  Future<void> getVpnInformation () async{
    isLoadingNewLocation.value = true;
    vpnServerList.clear();

    vpnServerList = await ApiVpnGate.getAllFreeVpnServer();

    isLoadingNewLocation.value = false;
  }
}