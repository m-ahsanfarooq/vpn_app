class IpInfo {
  String? countryName;
  String? regionName;
  String? cityName;
  String? zipCode;
  String? timeZone;
  String? internetServiceProvider;
  String? query;

  IpInfo(
      {this.countryName,
      this.regionName,
      this.cityName,
      this.zipCode,
      this.timeZone,
      this.internetServiceProvider,
      this.query});

  IpInfo.fromJson(Map<String,dynamic> jsonData){
    countryName = jsonData['country'];
    regionName = jsonData['regionName']??'';
    cityName = jsonData['city']??'';
    zipCode = jsonData['zip']??'';
    timeZone = jsonData['timezone']??'Unknown';
    internetServiceProvider = jsonData['isp']??'Unknown';
    query = jsonData['query']??'Not Available';
  }
}
