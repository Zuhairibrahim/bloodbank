import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donor_model.dart';
import '../widgets/donor_card.dart';

class AvailableDonorsScreen extends StatefulWidget {
  const AvailableDonorsScreen({Key? key}) : super(key: key);

  @override
  State<AvailableDonorsScreen> createState() => _AvailableDonorsScreenState();
}

class _AvailableDonorsScreenState extends State<AvailableDonorsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  static String _normalize(String text) {
    return text
        .replaceAll(RegExp('[أإآٱ]'), 'ا')
        .replaceAll('ى', 'ي')
        .replaceAll('ئ', 'ي')
        .replaceAll('ؤ', 'و')
        .replaceAll('ة', 'ه')
        .trim();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withValues(alpha: 0.7),
          child: SafeArea(
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
                      const Expanded(
                        child: Text(
                          'المتبرعون المتاحون',
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value.trim()),
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'ابحث بالاسم أو فصيلة الدم (مثل أحمد أو A+)',
                      hintStyle: const TextStyle(color: Colors.white70, fontSize: 15),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.white),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _query = '');
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('donors').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text('حدث خطأ أثناء تحميل البيانات', style: TextStyle(color: Colors.white)));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator(color: Color(0xFFB71C1C)));
                      }

                      final docs = snapshot.data!.docs;
                      if (docs.isEmpty) {
                        return const Center(
                          child: Text(
                            'لا يوجد متبرعون مسجلون حالياً',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        );
                      }

                      final donorsList = docs.map((doc) {
                        return DonorModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
                      }).toList();

                      donorsList.sort(DonorModel.compareArabicNames);

                      final query = _query.toLowerCase();
                      final normQuery = _normalize(query);
                      final filtered = query.isEmpty
                          ? donorsList
                          : donorsList
                              .where((d) =>
                                  d.bloodType.toLowerCase().contains(query) ||
                                  _normalize(d.name.toLowerCase()).contains(normQuery))
                              .toList();

                      if (filtered.isEmpty) {
                        return const Center(
                          child: Text(
                            'لا توجد نتائج مطابقة للبحث',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          return DonorCard(donor: filtered[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
