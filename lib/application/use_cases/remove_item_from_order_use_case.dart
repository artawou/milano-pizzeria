import '../../domain/entities/order.dart';
import '../../domain/entities/pizza_item.dart';
import '../../domain/repositories/order_repository.dart';

class RemoveItemFromOrderUseCase {
  const RemoveItemFromOrderUseCase(this._orders);

  final OrderRepository _orders;

  Future<Order> call(PizzaItem item) async {
    final order = (await _orders.getOrder()).decrement(item);
    await _orders.saveOrder(order);
    return order;
  }
}