// lib/infrastructure/repositories/in_memory_order_repository.dart
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
 
class InMemoryOrderRepository implements OrderRepository {
  Order _order = const Order();
 
  @override
  Future<Order> getOrder() async => _order;
 
  @override
  Future<void> saveOrder(Order order) async {
    _order = order;
  }
}