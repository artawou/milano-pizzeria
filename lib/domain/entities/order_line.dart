// lib/domain/entities/order_line.dart
import 'pizza_item.dart';
 
class OrderLine {
  const OrderLine(this.item, this.quantity);
 
  final PizzaItem item;
  final int quantity;
 
  double get subtotal => item.price * quantity;
}