class DeviceName {
  final String id;
  final String name;

  DeviceName({
    required this.id,
    required this.name,
  });

  factory DeviceName.fromJson(Map<String, dynamic> json) {
    return DeviceName(
      id: json['id'],
      name: json['name'],
    );
  }
}