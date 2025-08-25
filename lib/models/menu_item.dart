
// lib/models/menu_item.dart

class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;
  final int reviews;
  final int preparationTime;
  final List<String> ingredients;
  final List<String> allergens;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.reviews,
    required this.preparationTime,
    required this.ingredients,
    required this.allergens,
  });
}
