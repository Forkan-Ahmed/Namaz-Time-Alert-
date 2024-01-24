import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/doya_provider.dart';
import 'package:search_islam/provider/home_provider.dart';
import 'package:search_islam/provider/location_provider.dart';
import 'package:search_islam/provider/ojifa_provider.dart';
import 'package:search_islam/provider/prayer_time_provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/provider/tasbih_provider.dart';
import 'package:search_islam/provider/zakat_provider.dart';
import 'package:search_islam/view/splash/splash_screen.dart';
import 'di_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<OjifaProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<DoyaProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<TasbihProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ZakatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<QuraanShareefProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<HomeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<PrayerTimeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocationProvider>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.blueAccent, statusBarBrightness: Brightness.dark));
    return MaterialApp(
      title: 'Islamic World',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'kalpurus',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
