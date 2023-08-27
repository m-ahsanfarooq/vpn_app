class VpnStatus {
  String? byteIn;
  String? byteOut;
  String? durationTime;
  String? lastPacketReceived;

  VpnStatus(
      {this.byteIn, this.byteOut, this.durationTime, this.lastPacketReceived});

  factory VpnStatus.fromJson(Map<String, dynamic> jsonData) => VpnStatus(
    byteIn: jsonData['byte_in'],
      byteOut: jsonData['byte_out'],
      durationTime: jsonData['duration'],
      lastPacketReceived: jsonData['last_packet_receive']);

  Map<String,dynamic> toJson() =>{
    'byte_in': byteIn,
    'byte_out': byteOut,
    'duration': durationTime,
    'last_packet_receive': lastPacketReceived,
  };
}
