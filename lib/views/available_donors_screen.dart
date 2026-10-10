import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donor_model.dart';
import '../widgets/donor_card.dart';

class AvailableDonorsScreen extends StatelessWidget {
  const AvailableDonorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المتبرعون المتاحون'),
        backgroundColor: const Color(0xFFB71C1C),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donors').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFB71C1C)));
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(
              child: Text(
                'لا يوجد متبرعون مسجلون حالياً',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          final donorsList = docs.map((doc) {
            return DonorModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
          }).toList();

          return ListView.builder(
            itemCount: donorsList.length,
            itemBuilder: (context, index) {
              return DonorCard(donor: donorsList[index]);
            },
          );
        },
      ),
    );
  }
}
