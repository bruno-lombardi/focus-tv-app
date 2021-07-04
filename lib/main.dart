import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_tv_app/features/device/presentation/pages/activate_device_page.dart';
import 'injection_container.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
      },
      child: MaterialApp(
        title: 'Focus TV Ads',
        theme: ThemeData(
          primaryColor: Color(0xFFF25160),
          backgroundColor: Color(0xFFE6E6E6),
          accentColor: Color(0xFF2C6072),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ActivateDevicePage(),
      ),
    );
  }
}
