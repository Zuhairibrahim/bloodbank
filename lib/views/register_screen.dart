import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'role_selection_screen.dart';

class RegisterScreen extends StatefulWidget {
  final bool isDonor;
  const RegisterScreen({super.key, required this.isDonor});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedBloodType;
  String? _selectedCity;

  final List<String> _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final List<String> _cities = [
    'أمانة العاصمة صنعاء',
    'عدن',
    'تعز',
    'الحديدة',
    'إب',
    'ذمار',
    'حضرموت',
    'المهرة',
    'أبين',
    'لحج',
    'شبوة',
    'البيضاء',
    'مأرب',
    'الجوف',
    'صعدة',
    'المحويت',
    'عمران',
    'الضالع',
    'ريمة',
    'حجة',
    'سقطرى',
    'صنعاء',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.45),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 10, 4, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          widget.isDonor ? 'سجل كمتبرع دم' : 'سجل كمحتاج دم',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Fill in Your Details',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 30),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedBloodType,
                            isExpanded: true,
                            menuMaxHeight: 300,
                            dropdownColor: const Color(0xFF3B0909),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            hint: const Text(
                              'فصيلة الدم',
                              style: TextStyle(color: Colors.white54),
                            ),
                            icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
                            decoration: _inputDecoration(
                              hintText: 'فصيلة الدم',
                              icon: Icons.bloodtype_outlined,
                            ),
                            items: _bloodTypes.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black54,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    type,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            selectedItemBuilder: (context) {
                              return _bloodTypes.map((type) {
                                return Text(
                                  type,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              }).toList();
                            },
                            onChanged: (val) => setState(() => _selectedBloodType = val),
                            validator: (val) => val == null ? 'الرجاء اختيار فصيلة الدم' : null,
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedCity,
                            isExpanded: true,
                            menuMaxHeight: 300,
                            dropdownColor: const Color(0xFF3B0909),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            hint: const Text(
                              'المحافظة',
                              style: TextStyle(color: Colors.white54),
                            ),
                            icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
                            decoration: _inputDecoration(
                              hintText: 'المحافظة',
                              icon: Icons.location_on_outlined,
                            ),
                            items: _cities.map((city) {
                              return DropdownMenuItem(
                                value: city,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black54,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    city,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            selectedItemBuilder: (context) {
                              return _cities.map((city) {
                                return Text(
                                  city,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              }).toList();
                            },
                            onChanged: (val) => setState(() => _selectedCity = val),
                            validator: (val) => val == null ? 'الرجاء اختيار المحافظة' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _nameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: _inputDecoration(
                              hintText: 'الاسم الرباعي',
                              icon: Icons.person_outline,
                            ),
                            validator: (val) {
                              final trimmed = val?.trim() ?? '';
                              if (trimmed.isEmpty) return 'الرجاء إدخال الاسم';
                              final words = trimmed
                                  .split(RegExp(r'\s+'))
                                  .where((w) => w.isNotEmpty)
                                  .toList();
                              if (words.length < 4) {
                                final remaining = 4 - words.length;
                                switch (remaining) {
                                  case 1:
                                    return 'باقي اسم واحد';
                                  case 2:
                                    return 'باقي اسمين';
                                  default:
                                    return 'باقي $remaining أسماء';
                                }
                              }
                              if (words.length > 4) return 'الاسم الرباعي يتكون من 4 أسماء فقط';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(color: Colors.white),
                            decoration: _inputDecoration(
                              hintText: 'رقم التلفون',
                              icon: Icons.phone_outlined,
                            ),
                            validator: (val) {
                              final phone = val?.trim() ?? '';
                              if (phone.isEmpty) return 'الرجاء إدخال رقم الهاتف';
                              if (!RegExp(r'^(77|78|73|71)\d{7}$').hasMatch(phone)) {
                                return 'رقم الهاتف يجب أن يكون 9 أرقام ويبدأ بـ 77 أو 78 أو 73 أو 71';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB71C1C),
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _saveDonor({
                                    'bloodType': _selectedBloodType,
                                    'name': _nameController.text.trim(),
                                    'phone': _phoneController.text.trim(),
                                    'city': _selectedCity,
                                    'isDonor': widget.isDonor,
                                    'createdAt': FieldValue.serverTimestamp(),
                                  });

                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    barrierColor: Colors.black54,
                                    builder: (context) => Dialog(
                                      backgroundColor: const Color(0xFF1E0C0C),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(24),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 70,
                                              height: 70,
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            const Text(
                                              'تم اضافتك كمتبرع دم بنجاح',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );

                                  await Future.delayed(const Duration(seconds: 2));

                                  if (!context.mounted) return;
                                  Navigator.pop(context);

                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
                                    (route) => false,
                                  );
                                }
                              },
                              child: const Text(
                                'تأكيد',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            'Your information is secure.',
                            style: TextStyle(color: Colors.white60, fontSize: 12),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _saveDonor(Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('donors').add(data);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء الحفظ: $e')),
        );
      }
    }
  }

  InputDecoration _inputDecoration({required String hintText, required IconData icon}) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFF1E0C0C).withValues(alpha: 0.75),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: Colors.white70),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF5A3E38), width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF5A3E38), width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFB71C1C), width: 1.8),
      ),
    );
  }
}
