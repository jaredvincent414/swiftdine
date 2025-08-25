import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';
import 'package:swiftdine/constants/theme.dart';

class CheckoutScreen extends StatefulWidget {
  final String tableNumber;

  const CheckoutScreen({super.key, required this.tableNumber});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _notesController = TextEditingController();
  String selectedPaymentMethod = 'Card';

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _placeOrder(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Confirm Order',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: 'Lora',
            color: AppTheme.tomatoRed,
          ),
        ),
        content: Text(
          'Place order for Table ${widget.tableNumber} via $selectedPaymentMethod?',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppTheme.neutralGray),
            ),
          ),
          TextButton(
            onPressed: () {
              cartProvider.clearCart();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Order placed for Table ${widget.tableNumber} via $selectedPaymentMethod',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to previous screen
            },
            child: Text(
              'Confirm',
              style: TextStyle(color: AppTheme.saffronGold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Summary',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lora',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Table No: ${widget.tableNumber}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.neutralGray,
                  ),
                ),
                Text(
                  'Items: ${cartProvider.itemCount}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.neutralGray,
                  ),
                ),
                Text(
                  'Total Quantity: ${cartProvider.items.fold(0, (sum, item) => sum + item.quantity)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.neutralGray,
                  ),
                ),
                const SizedBox(height: 16),
                ...cartProvider.items.map((item) => _buildItemCard(context, item)),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lora',
                          ),
                        ),
                        Text(
                          '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.basilGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Payment Method',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lora',
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.start,
                  children: [
                    _buildPaymentCard(
                      context,
                      icon: Icons.credit_card,
                      label: 'Card',
                      isSelected: selectedPaymentMethod == 'Card',
                      onTap: () => setState(() => selectedPaymentMethod = 'Card'),
                    ),
                    _buildPaymentCard(
                      context,
                      icon: Icons.money,
                      label: 'Cash',
                      isSelected: selectedPaymentMethod == 'Cash',
                      onTap: () => setState(() => selectedPaymentMethod = 'Cash'),
                    ),
                    _buildPaymentCard(
                      context,
                      icon: Icons.schedule,
                      label: 'Pay Later',
                      isSelected: selectedPaymentMethod == 'Pay Later',
                      onTap: () => setState(() => selectedPaymentMethod = 'Pay Later'),
                    ),
                    _buildPaymentCard(
                      context,
                      icon: Icons.qr_code,
                      label: 'UPI',
                      isSelected: selectedPaymentMethod == 'UPI',
                      onTap: () => setState(() => selectedPaymentMethod = 'UPI'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Additional Notes',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lora',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _notesController,
                  decoration: InputDecoration(
                    hintText: 'Any special requests for your order',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fillColor: AppTheme.softCream,
                    filled: true,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estimated Time',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lora',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: AppTheme.neutralGray),
                            const SizedBox(width: 8),
                            Text(
                              '20-30 min',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.neutralGray,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _placeOrder(context, cartProvider),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.saffronGold,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Place Order',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.softCream,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, CartItem item) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(
              '${item.quantity}×',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Lora',
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '\$${(item.price * item.quantity).toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.basilGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(
      BuildContext context, {
        required IconData icon,
        required String label,
        required bool isSelected,
        required VoidCallback onTap,
      }) {
    return Semantics(
      label: 'Payment method: $label${isSelected ? ', selected' : ''}',
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: isSelected ? 4 : 2,
          color: isSelected ? AppTheme.saffronGold : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: SizedBox(
            width: 80,
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isSelected ? AppTheme.softCream : AppTheme.neutralGray,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isSelected ? AppTheme.softCream : AppTheme.neutralGray,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}