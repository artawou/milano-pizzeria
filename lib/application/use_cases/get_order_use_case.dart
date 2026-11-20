import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

class GetOrderUseCase {
  const GetOrderUseCase(this._orders);

  final OrderRepository _orders;

  Future<Order> call() => _orders.getOrder();
}