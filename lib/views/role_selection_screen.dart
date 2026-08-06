import 'package:flutter/material.dart';
import 'available_donors_screen.dart';
import 'register_screen.dart';
import 'dart:math' as math;

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // خلفية الصفحة كاملة كصورة غلاف
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      child: Column(
                        children: [
                          // 1. الشعار العلوي
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Flexible(
                                      child: Text(
                                        'تطبيق بنك الدم اليمني الإلكتروني الذكي',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFD32F2F),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    CustomPaint(
                                      size: const Size(18, 18),
                                      painter: HeartPainter(color: const Color(0xFFD32F2F)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Electronic Blood Bank',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // مسافة مرنة علوية لدفع البطاقات والعناصر نحو المنتصف
                          const Spacer(),

                          // المحتوى المراد توسيطه (العنوان + البطاقات + الأزرار)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // 2. العنوان
                              Column(
                                children: [
                                  const Text(
                                    'Welcome to Electronic Blood Bank',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Choose your Role',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),

                              // 3. البطاقتين الكبيرتين (متبرع / محتاج) بتصميم مطابق تماماً للصورة
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildLargeCard(
                                      iconWidget: CustomPaint(
                                        size: const Size(60, 75),
                                        painter: BloodDropPainter(),
                                      ),
                                      title: 'متبرع',
                                      subtitle: 'تبرع بدمك وأنقذ حياة',
                                      onTap: null,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildLargeCard(
                                      iconWidget: CustomPaint(
                                        size: const Size(60, 75),
                                        painter: SeekerHeadsetPainter(),
                                      ),
                                      title: 'محتاج',
                                      subtitle: 'ابحث عن متبرع في منطقتك',
                                      onTap: null,
                                    ),
                                  ),
                                ],
                              ),

                              // المسافة المناسبة بين المربعات والأزرار كما طلبت سابقاً
                              const SizedBox(height: 35),

                              // 4. الأزرار السفلية الطويلة
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const RegisterScreen(isDonor: true)),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFB71C1C),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(26),
                                    ),
                                  ),
                                  child: const Text(
                                    'تبرع بدم',
                                    style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AvailableDonorsScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        child: const Text(
                          'أحتاج دم',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB71C1C),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // مسافة مرنة سفلية لضبط التوسيط تماماً
                const Spacer(),

                // 5. الشعار السفلي في نهاية الشاشة تماماً
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Our Goal: Save Lives ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CustomPaint(
                        size: const Size(12, 12),
                        painter: HeartPainter(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                ],
              ),
            ),
          ),
        ),
      );
      },
    ),
  ),
  ),
);
  }

  Widget _buildLargeCard({
    required Widget iconWidget,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1C0E0E), // لون خلفية المربعات الداكن تماماً كالصورة
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFF5A3E38), // لون الحدود البرونزية الخفيفة المطابقة للصورة
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= رسامين المكونات البرمجية =================

class HeartPainter extends CustomPainter {
  final Color color;
  const HeartPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color..style = PaintingStyle.fill;
    Path path = Path();
    double w = size.width;
    double h = size.height;
    path.moveTo(w / 2, h / 4);
    path.cubicTo(w * 3 / 4, 0, w, h / 3, w / 2, h);
    path.cubicTo(0, h / 3, w / 4, 0, w / 2, h / 4);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BloodDropPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint dropPaint = Paint()..color = const Color(0xFFB71C1C)..style = PaintingStyle.fill;
    Path path = Path();
    double w = size.width;
    double h = size.height;

    path.moveTo(w / 2, 0);
    path.quadraticBezierTo(w, h * 0.6, w, h * 0.75);
    path.arcToPoint(Offset(0, h * 0.75), radius: Radius.circular(w / 2), largeArc: true);
    path.quadraticBezierTo(0, h * 0.6, w / 2, 0);
    path.close();

    canvas.drawPath(path, dropPaint);

    Paint crossPaint = Paint()..color = Colors.white..strokeWidth = 3.5..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w / 2, h * 0.45), Offset(w / 2, h * 0.73), crossPaint);
    canvas.drawLine(Offset(w * 0.36, h * 0.59), Offset(w * 0.64, h * 0.59), crossPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SeekerHeadsetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xFF546E7A)..style = PaintingStyle.fill;
    double w = size.width;
    double h = size.height;

    canvas.drawCircle(Offset(w / 2, h * 0.55), w * 0.24, paint);

    Paint strokePaint = Paint()
      ..color = const Color(0xFF90A4AE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;

    canvas.drawArc(Rect.fromCircle(center: Offset(w / 2, h * 0.55), radius: w * 0.32), math.pi, math.pi, false, strokePaint);

    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.12, h * 0.45, w * 0.1, h * 0.2), const Radius.circular(4)), paint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.78, h * 0.45, w * 0.1, h * 0.2), const Radius.circular(4)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}