import '../entities/order.dart';
 
abstract interface class OrderRepository {
  Future<Order> getOrder();
  Future<void> saveOrder(Order order);
}