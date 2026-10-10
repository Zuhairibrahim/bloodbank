import 'package:flutter/material.dart';
import 'available_donors_screen.dart';
import 'register_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'أحسمن دم',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB71C1C),
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.favorite, color: Color(0xFFB71C1C), size: 22),
                ],
              ),
              const Text(
                'BloodConnect',
                style: TextStyle(fontSize: 12, color: Colors.grey, letterSpacing: 0.5),
              ),
              const SizedBox(height: 50),
              const Text(
                'Welcome to BloodConnect',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 4),
              const Text(
                'Choose your Role',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, spreadRadius: 2)
                          ],
                        ),
                        child: const Icon(Icons.bloodtype, size: 36, color: Color(0xFFB71C1C)),
                      ),
                      const SizedBox(height: 10),
                      const Text('Donor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, spreadRadius: 2)
                          ],
                        ),
                        child: const Icon(Icons.support_agent, size: 36, color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 10),
                      const Text('Seeker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB71C1C),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen(isDonor: true)),
                    );
                  },
                  child: const Text(
                    'تبرع بدم',
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFB71C1C), width: 1.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AvailableDonorsScreen()),
                    );
                  },
                  child: const Text(
                    'أحتاج دم',
                    style: TextStyle(fontSize: 16, color: Color(0xFFB71C1C), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Our Goal: Save Lives ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Icon(Icons.favorite, color: Colors.red, size: 12),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
