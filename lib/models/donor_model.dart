class DonorModel {
  final String? id;
  final String name;
  final String bloodType;
  final String phone;
  final String city;
  final bool isDonor;

  DonorModel({
    this.id,
    required this.name,
    required this.bloodType,
    required this.phone,
    required this.city,
    required this.isDonor,
  });

  factory DonorModel.fromMap(String id, Map<String, dynamic> map) {
    return DonorModel(
      id: id,
      name: map['name'] ?? '',
      bloodType: map['bloodType'] ?? '',
      phone: map['phone'] ?? '',
      city: map['city'] ?? '',
      isDonor: map['isDonor'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bloodType': bloodType,
      'phone': phone,
      'city': city,
      'isDonor': isDonor,
    };
  }
}
