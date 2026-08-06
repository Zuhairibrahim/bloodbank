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

  static String _arabicKey(String name) {
    return name
        .replaceAll(RegExp('[أإآٱ]'), 'ا')
        .replaceAll('ى', 'ي')
        .replaceAll('ئ', 'ي')
        .replaceAll('ؤ', 'و')
        .replaceAll('ة', 'ه');
  }

  static int compareArabicNames(DonorModel a, DonorModel b) {
    return _arabicKey(a.name).compareTo(_arabicKey(b.name));
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
