import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/apiVpnGate/api_vpn_gate.dart';
import 'package:vpn_basic_project/models/ip_info_model.dart';
import 'package:vpn_basic_project/models/network_ip_info_model.dart';
import 'package:vpn_basic_project/utlis/ip_info_widget.dart';

class IpInfoScreen extends StatelessWidget {
  const IpInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ipInfo = IpInfo.fromJson({}).obs;
    ApiVpnGate.getIPDetails(ipInfo: ipInfo);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(23, 69, 113, 1),
        title: Text(
          'Ip Information',
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Obx(
        () =>  ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(8),
                children: [
                  IpInfoWidget(NetworkIpInfo(
                      title: 'Ip Address',
                      subtitle: ipInfo.value.query,
                      iconData: Icon(
                        Icons.my_location_rounded,
                        color: Colors.redAccent,
                      ))),
                  IpInfoWidget(NetworkIpInfo(
                      title: 'Isp',
                      subtitle: ipInfo.value.internetServiceProvider,
                      iconData: Icon(
                        Icons.my_location_rounded,
                        color: Colors.deepOrangeAccent,
                      ))),
                  IpInfoWidget(NetworkIpInfo(
                      title: 'Location',
                      subtitle: ipInfo.value.countryName==null?'':ipInfo.value.countryName!.isEmpty
                          ? 'Getting Location ....'
                          : '${ipInfo.value.cityName},${ipInfo.value.regionName}',
                      iconData: Icon(
                        CupertinoIcons.location_solid,
                        color: Colors.green,
                      ))),
                  IpInfoWidget(NetworkIpInfo(
                      title: 'Zin Code',
                      subtitle: ipInfo.value.zipCode,
                      iconData: Icon(
                        CupertinoIcons.map_pin_ellipse,
                        color: Colors.purpleAccent,
                      ))),
                  IpInfoWidget(NetworkIpInfo(
                      title: 'Time Zone',
                      subtitle: ipInfo.value.timeZone,
                      iconData: Icon(
                        Icons.share_arrival_time_outlined,
                        color: Colors.cyan,
                      ))),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Color.fromRGBO(23, 69, 113, 1),
        onPressed: () {
          ipInfo.value = IpInfo.fromJson({});
          ApiVpnGate.getIPDetails(ipInfo: ipInfo);
        },
        child: Icon(CupertinoIcons.refresh_circled),
      ),
    );
  }
}
