import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pexel/Service/Providers/board_index_provider.dart';
import 'package:pexel/Service/Providers/photo_load_provider.dart';
import 'package:pexel/View/home_screen.dart';
import 'package:provider/provider.dart';
 
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BoardIndexProvider()),
        ChangeNotifierProvider(create: (context) => PhotoLoadProvider()),
      ],
      child: Builder(builder: ((context) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen() 
        );
      })),
    );
  }
}
