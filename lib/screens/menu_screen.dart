import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/categories.dart';
import '../data/menu_data.dart';
import '../components/menu_card.dart';
import '../widgets/category_filter.dart';
import '../models/menu_item.dart';
import '../providers/cart_provider.dart';
import 'package:swiftdine/constants/theme.dart';

class MenuScreen extends StatefulWidget {
  final String tableNumber; // Added for dynamic table number

  const MenuScreen({super.key, required this.tableNumber});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String selectedCategory = 'all';
  String searchTerm = '';
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  List<String> get pageCategories => categories.map((c) => c['id']!).toList(); // Removed hardcoded 'all'

  void handleCategorySelect(String categoryId) {
    setState(() => selectedCategory = categoryId);
    final index = pageCategories.indexOf(categoryId);
    if (index >= 0) _pageController.jumpToPage(index);
  }

  void _onNavTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 1) {
      Navigator.pushNamed(context, '/cart');
    }
  }

  List<MenuItem> getFilteredItems(String categoryId) {
    final items = categoryId == 'all'
        ? allMenuItems
        : allMenuItems.where((item) => item.category == categoryId).toList();

    if (searchTerm.trim().isEmpty) return items;

    return items.where(
          (item) => item.name.toLowerCase().contains(searchTerm.toLowerCase()),
    ).toList();
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: AppTheme.neutralGray),
          hintText: 'Search dish',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          fillColor: AppTheme.softCream,
          filled: true,
        ),
        onChanged: (value) => setState(() => searchTerm = value),
      ),
    );
  }

  Widget buildCartIcon() {
    return Stack(
      children: [
        Icon(Icons.shopping_cart, color: AppTheme.neutralGray),
        Positioned(
          right: 0,
          top: 0,
          child: Consumer<CartProvider>(
            builder: (_, cart, __) {
              return cart.itemCount > 0
                  ? Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppTheme.tomatoRed,
                  borderRadius: BorderRadius.circular(12),
                ),
                constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                child: Text(
                  '${cart.itemCount}',
                  style: const TextStyle(
                    color: AppTheme.softCream,
                    fontSize: 12,
                    fontFamily: 'Roboto',
                  ),
                  textAlign: TextAlign.center,
                ),
              )
                  : const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget buildMenuPage(String categoryId) {
    final filteredItems = getFilteredItems(categoryId);
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: filteredItems.length,
      itemBuilder: (_, index) => MenuCard(item: filteredItems[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.tomatoRed,
            fontFamily: 'Lora',
          ),
        ),
        backgroundColor: AppTheme.softCream,
        centerTitle: true,
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: true),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Table No: ${widget.tableNumber}', // Dynamic table number
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontFamily: 'Lora',
                    color: AppTheme.neutralGray,
                  ),
                ),
              ),
            ),
            buildSearchBar(),
            CategoryFilter(
              selectedCategory: selectedCategory,
              onSelectCategory: handleCategorySelect,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (pageIndex) {
                  final catId = pageCategories[pageIndex];
                  setState(() => selectedCategory = catId);
                },
                itemCount: pageCategories.length,
                itemBuilder: (_, index) => buildMenuPage(pageCategories[index]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        selectedItemColor: AppTheme.saffronGold,
        unselectedItemColor: AppTheme.neutralGray,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant, color: AppTheme.neutralGray),
            activeIcon: Icon(Icons.restaurant, color: AppTheme.saffronGold),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: buildCartIcon(),
            activeIcon: buildCartIcon(),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}