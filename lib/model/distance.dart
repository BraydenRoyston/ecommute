class Distance {
  final List destinations;
  final List origins;
  final List rows;
  final String status;

  Distance(this.destinations, this.origins, this.rows, this.status);

  factory Distance.fromData(Map<String, dynamic> data) {
    return Distance(
      data['destination_addresses'],
      data['origin_addresses'],
      data['rows'],
      data['status']
    );
  }
}
