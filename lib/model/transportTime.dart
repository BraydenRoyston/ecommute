class TransportTime {
  final String text;
  final int value;

  TransportTime(this.text, this.value);

  factory TransportTime.fromData(Map<String, dynamic> data) {
    return TransportTime(
      data['text'],
      data['value']
    );
  }
}
