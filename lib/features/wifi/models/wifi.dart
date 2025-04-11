class Wifi {
  final int id;
  final String name;
  final String password;

  Wifi({
    required this.id,
    required this.name,
    required this.password,
  });

  factory Wifi.fromJson(Map<String, dynamic> json) {
    return Wifi(
      id: json['id'],
      name: json['name'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'password': password,
  };

}