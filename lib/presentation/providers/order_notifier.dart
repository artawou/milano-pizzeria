
import 'package:flutter/foundation.dart';

import '../../application/use_cases/add_item_to_order_use_case.dart';
import '../../application/use_cases/clear_order_use_case.dart';
import '../../application/use_cases/get_order_use_case.dart';
import '../../application/use_cases/remove_item_from_order_use_case.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_line.dart';
import '../../domain/entities/pizza_item.dart';

class OrderNotifier extends ChangeNotifier {
  OrderNotifier({
    required GetOrderUseCase getOrder,
    required AddItemToOrderUseCase addItem,
    required RemoveItemFromOrderUseCase removeItem,
    required ClearOrderUseCase clearOrder,
  })  : _getOrder = getOrder,
        _addItem = addItem,
        _removeItem = removeItem,
        _clearOrder = clearOrder;

  final GetOrderUseCase _getOrder;
  final AddItemToOrderUseCase _addItem;
  final RemoveItemFromOrderUseCase _removeItem;
  final ClearOrderUseCase _clearOrder;

  Order _order = const Order();

  List<OrderLine> get lines => _order.lines;
  int get totalCount => _order.totalCount;
  double get total => _order.total;

  int quantityOf(PizzaItem item) => _order.quantityOf(item);

  Future<void> load() async {
    _order = await _getOrder();
    notifyListeners();
  }

  Future<void> increment(PizzaItem item) async {
    _order = await _addItem(item);
    notifyListeners();
  }

  Future<void> decrement(PizzaItem item) async {
    _order = await _removeItem(item);
    notifyListeners();
  }

  Future<void> clear() async {
    _order = await _clearOrder();
    notifyListeners();
  }
}