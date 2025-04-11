class Relay {
  final int id;
  final bool relay_status;

  Relay({
    required this.id,
    required this.relay_status,
  });

  factory Relay.fromJson(Map<String, dynamic> json) {
    return Relay(
      id: json['id'],
      relay_status: json['relay_status'] == 1,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'relay_status': relay_status ? 1 : 0,
      };


}
