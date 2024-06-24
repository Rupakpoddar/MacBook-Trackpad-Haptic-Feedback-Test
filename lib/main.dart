import 'package:flutter/material.dart';
import 'package:macos_haptic_feedback/macos_haptic_feedback.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _macosHapticFeedback = MacosHapticFeedback();
  bool triggerHaptics = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: const Color.fromRGBO(0, 123, 255, 1.0),
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('MacBook Trackpad Haptic Feedback Test'),
        // ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...[
                (
                text: '10 ms',
                delay: 10,
                ),
                (
                text: '25 ms',
                delay: 25,
                ),
                (
                text: '50 ms',
                delay: 50,
                )
              ].map((e) => Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 123, 255, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                margin: const EdgeInsets.all(10),
                width: 200,
                height: 200,
                child: MouseRegion(
                  onEnter: (event) async {
                    if (!triggerHaptics) {
                      triggerHaptics = true;
                    }
                    while (triggerHaptics) {
                      _macosHapticFeedback.generic();
                      await Future.delayed(Duration(milliseconds: e.delay));
                    }
                  },
                  onExit: (event) {
                    if (triggerHaptics) {
                      triggerHaptics = false;
                    }
                  },
                  child: Center(
                    child: Text(
                      e.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    )
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
