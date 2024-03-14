import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:htg_smart_watch/Screens/home.dart';
import 'package:htg_smart_watch/Screens/login_screen.dart';
import 'package:htg_smart_watch/Screens/profile_screen.dart';
import 'package:htg_smart_watch/Screens/shoping_screen.dart';
import 'package:htg_smart_watch/Service/auth_service.dart';
import 'package:htg_smart_watch/cart_screen/cart_screen.dart';
import 'package:htg_smart_watch/firebase_options.dart';
import 'package:htg_smart_watch/models/shop.dart';
import 'package:htg_smart_watch/product_image_array.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => Shop(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthService(),
        child: MaterialApp(
          title: 'HTG Smart Watch',
          debugShowCheckedModeBanner: false,
          home: Consumer<AuthService>(
            builder: (context, authService, _) {
              final user = authService.currentUser;
              return user != null ? MyHomePage() : Login_Screen();
            },
          ),
          // home: ImageListViewArray(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screen = [
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
    ShopingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey.shade400,
        animationDuration: Duration(milliseconds: 500),
        height: 45,
        index: _currentIndex,
        items: [
          Icon(Icons.home),
          Icon(Icons.shopping_cart),
          Icon(Icons.account_circle),
          Icon(Icons.shop),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
