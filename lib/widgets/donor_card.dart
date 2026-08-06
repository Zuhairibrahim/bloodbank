import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/donor_model.dart';

class DonorCard extends StatelessWidget {
  final DonorModel donor;

  const DonorCard({Key? key, required this.donor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: donor.isDonor ? const Color(0xFFA52A2A) : const Color(0xFF37474F),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white.withValues(alpha: 0.25),
            child: Text(
              donor.name.isNotEmpty ? donor.name[0] : 'U',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donor.name,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(
                  'فصيلة الدم: ${donor.bloodType}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  'المحافظة: ${donor.city}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  donor.phone,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () async {
                  final Uri url = Uri(scheme: 'tel', path: donor.phone);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF8A80),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.phone, color: Colors.white, size: 16),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
