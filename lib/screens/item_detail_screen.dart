import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import 'package:swiftdine/constants/theme.dart';

class ItemDetailScreen extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String name;
  final double price;
  final double rating;
  final String description;
  final List<String> ingredients;
  final List<String> allergens;

  const ItemDetailScreen({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
    required this.ingredients,
    required this.allergens,
  });

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  int quantity = 1;
  final TextEditingController _instructionController = TextEditingController();

  void incrementQuantity() => setState(() => quantity++);
  void decrementQuantity() {
    if (quantity > 1) setState(() => quantity--);
  }

  void addToCart() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addItem(CartItem(
      id: widget.id,
      name: widget.name,
      price: widget.price,
      imageUrl: widget.imageUrl,
      quantity: quantity,
      specialInstructions: _instructionController.text.isNotEmpty ? _instructionController.text : null,
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.name} added to cart'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _instructionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total price based on quantity
    final totalPrice = (widget.price * quantity).toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                label: 'Image of ${widget.name}',
                child: Hero(
                  tag: 'item-image-${widget.id}',
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 250,
                      color: Colors.grey[300],
                      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.broken_image,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lora',
                          ),
                        ),
                        Text(
                          '\$${widget.price.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.basilGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: AppTheme.saffronGold, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          widget.rating.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.neutralGray,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Ingredients',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lora',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: widget.ingredients
                          .map((ing) => Chip(
                        label: Text(
                          ing,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        backgroundColor: AppTheme.softCream,
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Allergens',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lora',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: widget.allergens.isNotEmpty
                          ? widget.allergens
                          .map((allergen) => Semantics(
                        label: 'Allergen: $allergen',
                        child: Chip(
                          label: Text(
                            allergen,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          backgroundColor: AppTheme.softCream,
                        ),
                      ))
                          .toList()
                          : [
                        Text(
                          'None',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.neutralGray,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Special Instructions',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lora',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _instructionController,
                      decoration: InputDecoration(
                        hintText: 'Add extra sauce, no onions...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        fillColor: AppTheme.softCream,
                        filled: true,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lora',
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: AppTheme.tomatoRed),
                              onPressed: decrementQuantity,
                              tooltip: 'Decrease quantity',
                            ),
                            Text(
                              '$quantity',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: AppTheme.tomatoRed),
                              onPressed: incrementQuantity,
                              tooltip: 'Increase quantity',
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.shopping_cart, color: AppTheme.softCream),
                        label: Text(
                          'Add to Cart (\$$totalPrice)',
                          style: TextStyle(
                            color: AppTheme.softCream,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.saffronGold,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: addToCart,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}