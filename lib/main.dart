import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/home/home_screen.dart';
import 'screens/admin/admin_screen.dart';
import 'theme/app_theme.dart';
import 'config/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String supabaseUrl;
  String supabaseAnonKey;

  try {
    // محاولة تحميل .env للتطوير المحلي
    await dotenv.load(fileName: ".env");
    supabaseUrl = dotenv.env['SUPABASE_URL'] ?? EnvConfig.supabaseUrl;
    supabaseAnonKey =
        dotenv.env['SUPABASE_ANON_KEY'] ?? EnvConfig.supabaseAnonKey;
  } catch (e) {
    // إذا فشل تحميل .env (مثل في الإنتاج)، استخدم القيم من EnvConfig
    supabaseUrl = EnvConfig.supabaseUrl;
    supabaseAnonKey = EnvConfig.supabaseAnonKey;
  }

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(const WaslaApp());
}

class WaslaApp extends StatelessWidget {
  const WaslaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasla (وصلة)',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const Directionality(
              textDirection: TextDirection.rtl,
              child: WaslaHomePage(),
            ),
        '/admin': (context) => const Directionality(
              textDirection: TextDirection.rtl,
              child: AdminScreen(),
            ),
      },
    );
  }
}
