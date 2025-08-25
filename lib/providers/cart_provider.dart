import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get totalPrice =>
      _items.fold(0, (total, item) => total + (item.price * item.quantity));

  // FIXED: Calculate total item count (sum of quantities)
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  CartProvider() {
    _loadCart();
  }

  Future<void> _loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('cart');
      if (data != null) {
        final List decoded = jsonDecode(data);
        _items = decoded.map((e) => CartItem.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Cart load error: $e");
    }
  }

  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = jsonEncode(_items.map((e) => e.toJson()).toList());
      await prefs.setString('cart', data);
    } catch (e) {
      debugPrint("Cart save error: $e");
    }
  }

  void addItem(CartItem newItem) {
    final index = _items.indexWhere((item) => item.id == newItem.id);
    if (index != -1) {
      final item = _items[index];
      _items[index] = item.copyWith(quantity: item.quantity + newItem.quantity);
    } else {
      _items.add(newItem);
    }
    _saveCart();
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    _saveCart();
    notifyListeners();
  }

  void updateItemQuantity(String id, int newQty) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index] = _items[index].copyWith(quantity: newQty);
      _saveCart();
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    _saveCart();
    notifyListeners();
  }
}