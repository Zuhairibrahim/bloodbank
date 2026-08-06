import 'package:flutter_test/flutter_test.dart';
import 'package:bloodbank/models/donor_model.dart';

void main() {
  test('DonorModel.toMap converts to Firestore map', () {
    final donor = DonorModel(
      name: 'محمد علي زيد',
      bloodType: 'O+',
      phone: '778066436',
      city: 'صنعاء',
      isDonor: true,
    );
    final map = donor.toMap();
    expect(map['name'], 'محمد علي زيد');
    expect(map['bloodType'], 'O+');
    expect(map['isDonor'], true);
  });

  test('DonorModel.fromMap restores from Firestore map', () {
    final donor = DonorModel.fromMap('doc123', {
      'name': 'أحمد',
      'bloodType': 'B-',
      'phone': '123',
      'city': 'تعز',
      'isDonor': false,
    });
    expect(donor.id, 'doc123');
    expect(donor.name, 'أحمد');
    expect(donor.bloodType, 'B-');
    expect(donor.isDonor, false);
  });

  test('DonorModel.fromMap falls back to defaults', () {
    final donor = DonorModel.fromMap('doc456', {});
    expect(donor.name, '');
    expect(donor.isDonor, true);
  });
}
