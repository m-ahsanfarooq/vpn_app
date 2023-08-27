class VpnInfo {
  String? hostName;
  String? ip;
  String? ping;
  // int? speed;
  String? countryLongName;
  String? countryShortName;
  int? vpnSessionNums;
  String? base64OpenVpnConfigurationData;

  VpnInfo(
      {required this.hostName,
      required this.ip,
      required this.ping,
      // required this.speed,
      required this.countryLongName,
      required this.countryShortName,
      required this.vpnSessionNums,
      required this.base64OpenVpnConfigurationData});

  VpnInfo.fronJson(Map<String,dynamic> jsonData){
    hostName = jsonData["HostName"]??'';
    ip = jsonData["IP"]??'';
    ping =jsonData["Ping"].toString();
    // speed = 0 ;
    countryLongName = jsonData["CountryLong"]??'';
    countryShortName = jsonData["CountryShort"]??'';
    vpnSessionNums = jsonData["NumVpnSessions"]??0;
    base64OpenVpnConfigurationData = jsonData["OpenVPN_ConfigData_Base64"]??'';
  }

  Map<String,dynamic> toJson(){
    final jsonData =<String,dynamic>{};
    jsonData["HostName"] = hostName;
    jsonData["IP"] = ip;
    jsonData["Speed"] = ping;
    jsonData["CountryLong"] = countryLongName;
    jsonData["CountryShort"] = countryShortName;
    jsonData["NumVpnSessions"] = vpnSessionNums;
    jsonData["OpenVPN_ConfigData_Base64"] = base64OpenVpnConfigurationData;

    return jsonData;
  }
}
