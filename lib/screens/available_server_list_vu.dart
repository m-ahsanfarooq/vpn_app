import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/vpn_location_controller.dart';
import '../utlis/vpn_location_cell_design.dart';

class AvailableServerListScreen extends StatelessWidget {
  AvailableServerListScreen({super.key});

  final vpnLocationController = VpnLocationController();

  @override
  Widget build(BuildContext context) {
    if (vpnLocationController.vpnServerList.isEmpty) {
      vpnLocationController.getVpnInformation();
    }

    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor:  Color.fromRGBO(23, 69, 113, 1),
            title: Text(
                'Vpn Location (${vpnLocationController.vpnServerList.length})'),
          ),
          body: vpnLocationController.isLoadingNewLocation.value
              ? loadingUiWidget()
              : vpnLocationController.vpnServerList.isEmpty
                  ? noVpnServerFound()
                  : availableData(),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 10),
            child: FloatingActionButton(
              backgroundColor:  Color.fromRGBO(23, 69, 113, 1),
              onPressed: () {
                vpnLocationController.getVpnInformation();
              },
              child: const Icon(CupertinoIcons.refresh_circled,size: 40,),
            ),
          ),
        ));
  }

  loadingUiWidget() {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>( Color.fromRGBO(23, 69, 113, 1)),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Gathering Data .....',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  noVpnServerFound() {
    return const Center(
      child: Text(
        'No Vpn Found. Try Again',
        style: TextStyle(
            color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  availableData() {
    return ListView.builder(
        itemCount: vpnLocationController.vpnServerList.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(3),
        itemBuilder: (context, index) {
          return VpnLocationCellDesign(
              vpnLocationController.vpnServerList[index]);
        });
  }
}
