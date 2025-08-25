import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/theme.dart';
import 'providers/cart_provider.dart';

import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/item_detail_screen.dart'; // Not yet used, but imported for future use

void main() {
  runApp(const SwiftDineApp());
}

class SwiftDineApp extends StatelessWidget {
  const SwiftDineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp( // ✅ FIXED: Was `child MaterialApp(` instead of `child: MaterialApp(`
        title: 'SwiftDine',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.warmTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
          '/menu': (context) => const MenuScreen(tableNumber: '',),
          '/cart': (context) => const CartScreen(),
        },
      ),
    );
  }
}
