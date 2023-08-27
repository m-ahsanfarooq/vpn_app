import 'package:flutter/material.dart';
import 'package:vpn_basic_project/models/network_ip_info_model.dart';

class IpInfoWidget extends StatelessWidget {
  IpInfoWidget(this.networkIpInfo, {super.key});

  NetworkIpInfo networkIpInfo;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: size.height * .01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Icon(
          networkIpInfo.iconData!.icon,
          size: networkIpInfo.iconData!.size ?? 28,
        ),
        title: Text(networkIpInfo.title!),
        subtitle: Text(networkIpInfo.subtitle!),
      ),
    );
  }
}
