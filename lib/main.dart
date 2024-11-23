import 'package:flutter/material.dart';
// import 'utils/account_initializer.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeAccounts();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marvel Movies',
      theme: ThemeData.dark(),
      home: const LoginPage(),
    );
  }
}
