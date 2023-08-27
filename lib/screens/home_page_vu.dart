import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../models/vpn_status_model.dart';
import '../preferences.dart';
import '../utlis/custom_widget.dart';
import '../utlis/timer_widger.dart';
import '../vpnEngine/vpn_engine.dart';
import 'available_server_list_vu.dart';
import 'ip_info_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    VpnEngine.snapshotVpnStage().listen((event) {
      homeController.vpnConnectionState.value = event;
    });

    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(23, 69, 113, 1),
          title: const Text('Free Vpn'),
          leading: IconButton(
            onPressed: () {
              Get.to(IpInfoScreen());
            },
            icon: const Icon(Icons.perm_device_info_outlined),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.changeThemeMode(
                    Preferences.isModeDark ? ThemeMode.light : ThemeMode.dark);
                Preferences.isModeDark = !Preferences.isModeDark;
              },
              icon: const Icon(Icons.brightness_2_outlined),
            ),
          ]),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
                  () =>
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomWidget(
                          roundWidget: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.redAccent,
                            backgroundImage: homeController
                                .vpnInfo.value.countryLongName!.isEmpty
                                ? null
                                : AssetImage(
                                'assets/${homeController.vpnInfo.value
                                    .countryShortName!.toLowerCase()}.png'),
                            child: homeController
                                .vpnInfo.value.countryLongName!.isEmpty
                                ? const Icon(
                              Icons.flag_circle,
                              color: Colors.white,
                              size: 30,
                            )
                                : null,
                          ),
                          titleText:
                          homeController.vpnInfo.value.countryLongName!.isEmpty
                              ? 'Location'
                              : homeController.vpnInfo.value.countryLongName!,
                          subTitleText: 'Free'),
                      CustomWidget(
                          roundWidget: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black54,
                            child: Icon(
                              Icons.graphic_eq,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          titleText: homeController.vpnInfo.value.ping!.isEmpty
                              ? 'Speed'
                              : homeController.vpnInfo.value.ping! + 'ms',
                          subTitleText: 'Ping')
                    ],
                  ),
            ),
            SizedBox(height: 20),
            Obx(
                  () => vpnConnectionButton(size, homeController),
            ),
            StreamBuilder<VpnStatus?>(
                initialData: VpnStatus(),
                stream: VpnEngine.snapshotVpnStatus(),
                builder: (context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomWidget(
                          roundWidget: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.arrow_circle_down,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          titleText: snapshot.data!.byteIn ?? '0 kb/s',
                          subTitleText: 'Download'),
                      CustomWidget(
                          roundWidget: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.purpleAccent,
                            child: Icon(
                              Icons.arrow_circle_up,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          titleText: snapshot.data!.byteOut ?? '0 kb/s',
                          subTitleText: 'Upload')
                    ],
                  );
                })
          ],
        ),
      ),
      bottomSheet: InkWell(
        onTap: () {
          Get.to(() => AvailableServerListScreen());
        },
        child: Container(
          color:  Color.fromRGBO(23, 69, 113, 1),
          child: const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.flag_circle,
                  color: Colors.white,
                  size: 36,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Select Country/Location',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color:  Color.fromRGBO(23, 69, 113, 1),
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget vpnConnectionButton(size, HomeController homeController) {
  return Column(
    children: [
      Semantics(
        button: true,
        child: InkWell(
          onTap: () {
            homeController.connectToVpnNow();
          },
          borderRadius: BorderRadius.circular(100),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: homeController.getRoundButtonColor.withOpacity(0.1),
            ),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: homeController.getRoundButtonColor.withOpacity(0.3),
              ),
              child: Container(
                height: size.height * .15,
                width: size.height * .15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.getRoundButtonColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.power_settings_new,
                      size: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      homeController.getRoundButtonText.toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(
            top: size.height * .02, bottom: size.height * .02),
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(16)
        ),
        child: Text(homeController.vpnConnectionState.value ==
            VpnEngine.vpnDisconnectedNow
            ? 'Not Connected'
            : homeController.vpnConnectionState.replaceAll('_', ' ').toUpperCase(),
          style: TextStyle(fontSize: 13,color: Colors.white),
        ),
      ),
      Obx(() => TimerWidget(initTimer: homeController.vpnConnectionState.value == VpnEngine.vpnConnectedNow,))
    ],
  );
}
