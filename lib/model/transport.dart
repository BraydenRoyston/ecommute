import './transportTime.dart';

class Transport {
  final TransportTime transportDistance;
  final TransportTime transportDuration;
  final TransportTime transportTraffic;
  final String status;

  Transport(this.transportDistance, this.transportDuration, this.transportTraffic, this.status);

  factory Transport.fromData(Map<String, dynamic> data) {
    return Transport(
      TransportTime.fromData(data['distance']),
      TransportTime.fromData(data['duration']),
      TransportTime.fromData(data['duration_in_traffic']),
      data['status']
    );
  }
}
