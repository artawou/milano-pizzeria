import 'package:flutter_test/flutter_test.dart';

import 'package:milano_pizzeria/domain/entities/order.dart';
import 'package:milano_pizzeria/domain/entities/pizza_item.dart';
import 'package:milano_pizzeria/domain/repositories/order_repository.dart';

import 'package:milano_pizzeria/application/use_cases/add_item_to_order_use_case.dart';
import 'package:milano_pizzeria/application/use_cases/remove_item_from_order_use_case.dart';

class FakeOrderRepository implements OrderRepository {
  Order saved = const Order();

  @override
  Future<Order> getOrder() async => saved;

  @override
  Future<void> saveOrder(Order order) async {
    saved = order;
  }
}

void main() {
  const margherita = PizzaItem(
    title: 'Маргарита',
    description: 'Томатний соус, моцарела, свіжий базилік',
    price: 169.00,
    category: MenuCategory.pizza,
  );

  test('AddItemToOrderUseCase збільшує кількість і суму', () async {
    final repo = FakeOrderRepository();
    final addItem = AddItemToOrderUseCase(repo);

    await addItem(margherita);
    final order = await addItem(margherita);

    expect(order.totalCount, 2);
    expect(order.total, 338.00);
    expect(repo.saved.totalCount, 2);
  });

  test('RemoveItemFromOrderUseCase не змінює порожнє замовлення', () async {
    final repo = FakeOrderRepository();

    final order = await RemoveItemFromOrderUseCase(repo)(margherita);

    expect(order.isEmpty, isTrue);
  });
}