import '../../domain/entities/order.dart';
import '../../domain/entities/pizza_item.dart';
import '../../domain/repositories/order_repository.dart';

class AddItemToOrderUseCase {
  const AddItemToOrderUseCase(this._orders);

  final OrderRepository _orders;

  Future<Order> call(PizzaItem item) async {
    final order = (await _orders.getOrder()).increment(item);
    await _orders.saveOrder(order);
    return order;
  }
}