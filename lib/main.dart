// ============================================================================
//  © 2026 Zuhair Ibrahim — ALL RIGHTS RESERVED | جميع الحقوق محفوظة © زهير إبراهيم
//  Project: BloodConnect — بنك الدم
//  This code contains a proprietary embedded copyright fingerprint.
//  Selling, redistributing, or removing this notice is strictly forbidden.
//  ============================================================================

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'views/role_selection_screen.dart';

/// بصمة الملكية الفكرية — يُمنع حذفها أو تعديلها (انظر ملف LICENSE)
/// Proprietary ownership fingerprint — must NOT be removed or altered (see LICENSE).
const String kAppOwnershipFingerprint =
    'OWNER:Zuhair-Ibrahim|PROJECT:bloodconnect|YEAR:2026|'
    'LICENSE:ALL-RIGHTS-RESERVED|SIG:ZI-2026-BLD-PROPRIETARY';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BloodConnectApp());
}

class BloodConnectApp extends StatelessWidget {
  const BloodConnectApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloodConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        fontFamily: 'Cairo',
      ),
      home: const RoleSelectionScreen(),
    );
  }
}
