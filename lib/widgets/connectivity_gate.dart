import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityGate extends StatefulWidget {
  final Widget child;
  const ConnectivityGate({super.key, required this.child});

  @override
  State<ConnectivityGate> createState() => _ConnectivityGateState();
}

class _ConnectivityGateState extends State<ConnectivityGate> {
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _online = false;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    _subscription = Connectivity().onConnectivityChanged.listen((_) {
      _checkConnection();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _checkConnection() async {
    final results = await Connectivity().checkConnectivity();
    final hasNetwork = results.any((r) => r != ConnectivityResult.none);
    if (!hasNetwork) {
      _setOnline(false);
      return;
    }
    try {
      final list = await InternetAddress.lookup('google.com');
      _setOnline(list.isNotEmpty && list.first.rawAddress.isNotEmpty);
    } catch (_) {
      _setOnline(false);
    }
  }

  void _setOnline(bool value) {
    if (mounted && _online != value) {
      setState(() => _online = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (!_online)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.75),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E0C0C),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF5A3E38), width: 1.5),
                    boxShadow: const [
                      BoxShadow(color: Colors.black54, blurRadius: 20, offset: Offset(0, 6)),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Color(0xFFB71C1C),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.wifi_off, color: Colors.white, size: 36),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'لا يوجد اتصال بالإنترنت',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'تحقق من اتصالك بالإنترنت للدخول إلى التطبيق',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.white70, height: 1.5),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: _checkConnection,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB71C1C),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23),
                            ),
                          ),
                          child: const Text(
                            'إعادة المحاولة',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
