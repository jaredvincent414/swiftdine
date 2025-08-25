import 'package:flutter/material.dart';
import '../data/categories.dart';
import 'package:swiftdine/constants/theme.dart';

class CategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onSelectCategory;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final id = categories[index]['id']!;
          final name = categories[index]['name']!;
          final isSelected = selectedCategory == id;

          return ChoiceChip(
            label: Text(
              name,
              style: TextStyle(
                color: isSelected ? AppTheme.softCream : AppTheme.neutralGray,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
              ),
            ),
            selected: isSelected,
            onSelected: (_) => onSelectCategory(id),
            selectedColor: AppTheme.saffronGold,
            backgroundColor: AppTheme.softCream,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected ? AppTheme.saffronGold : AppTheme.neutralGray,
              ),
            ),
          );
        },
      ),
    );
  }
}