// lib/domain/entities/order.dart
import 'order_line.dart';
import 'pizza_item.dart';
 
class Order {
  const Order([this.lines = const []]);
 
  final List<OrderLine> lines;
 
  bool get isEmpty => lines.isEmpty;
  int get totalCount => lines.fold(0, (sum, l) => sum + l.quantity);
  double get total => lines.fold(0.0, (sum, l) => sum + l.subtotal);
 
  int quantityOf(PizzaItem item) {
    for (final line in lines) {
      if (line.item.title == item.title) return line.quantity;
    }
    return 0;
  }
 
  Order increment(PizzaItem item) =>
      _withQuantity(item, quantityOf(item) + 1);
 
  Order decrement(PizzaItem item) {
    final current = quantityOf(item);
    // Нульову кількість не зменшуємо: це не помилка, а no-op.
    if (current == 0) return this;
    return _withQuantity(item, current - 1);
  }
 
  Order _withQuantity(PizzaItem item, int quantity) {
    final updated = <OrderLine>[];
    var found = false;
    for (final line in lines) {
      if (line.item.title == item.title) {
        found = true;
        if (quantity > 0) updated.add(OrderLine(item, quantity));
      } else {
        updated.add(line);
      }
    }
    if (!found && quantity > 0) updated.add(OrderLine(item, quantity));
    return Order(List.unmodifiable(updated));
  }
}