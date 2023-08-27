import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/app.dart';

import '../controllers/home_controller.dart';
import '../models/vpn_model.dart';
import '../preferences.dart';
import '../vpnEngine/vpn_engine.dart';

class VpnLocationCellDesign extends StatelessWidget {
  const VpnLocationCellDesign(this.vpnInfo, {super.key});

  final VpnInfo vpnInfo;

  String formatSpeedByte(int speedBytes, int decimals) {
    if (speedBytes <= 0) {
      return '0 B';
    }
    const suffixTitle = ['Bps', 'Kbps', 'Mbps', 'Gbps', 'Tbps'];
    var speedTitleIndex = (log(speedBytes) / log(1024)).floor();

    return '${(speedBytes / pow(1024, speedTitleIndex)).toStringAsFixed(decimals)} ${suffixTitle[speedTitleIndex]}';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeController = Get.find<HomeController>();
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: size.height * .01),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          homeController.vpnInfo.value = vpnInfo;
          Preferences.vpnInfoObj = vpnInfo;
          Get.back();

          if(homeController.vpnConnectionState.value == VpnEngine.vpnConnectedNow ){
            VpnEngine.stopVpnNow();
            
            Future.delayed(const Duration(seconds: 3),()=> homeController.connectToVpnNow());
          }
          else{
            homeController.connectToVpnNow();
          }
        },
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          leading: CircleAvatar(
            backgroundColor: Color.fromRGBO(23, 69, 113, 1),
            child: Image.asset(
              'assets/${vpnInfo.countryShortName!.toLowerCase()}.png',
              height: 40,
              width: size.width * .15,
              fit: BoxFit.cover,
            ),
          ),
          title: Text('${vpnInfo.countryLongName}'),
          subtitle: Row(
            children: [
              const Icon(
                Icons.shutter_speed,
                color: Colors.redAccent,
                size: 20,
              ),
              const SizedBox(
                width: 4,
              ),
              // Text(
              //   formatSpeedByte(vpnInfo.speed!, 2),
              //   style: const TextStyle(fontSize: 13),
              // )
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpnInfo.vpnSessionNums.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).lightTextColor),
              ),
              const SizedBox(width: 4),
              const Icon(
                CupertinoIcons.person_2_alt,
                color: Colors.redAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
