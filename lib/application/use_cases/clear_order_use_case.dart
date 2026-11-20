import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

class ClearOrderUseCase {
  const ClearOrderUseCase(this._orders);

  final OrderRepository _orders;

  Future<Order> call() async {
    const empty = Order();
    await _orders.saveOrder(empty);
    return empty;
  }
}