// lib/infrastructure/repositories/in_memory_menu_repository.dart
import '../../domain/entities/pizza_item.dart';
import '../../domain/repositories/menu_repository.dart';
 
class InMemoryMenuRepository implements MenuRepository {
  final List<PizzaItem> _menu = [
    const PizzaItem(
      title: 'Маргарита',
      description: 'Томатний соус, моцарела, свіжий базилік',
      price: 169,
      category: MenuCategory.pizza,
    ),
    const PizzaItem(
      title: 'Пепероні',
      description: 'Гостра салямі пепероні, моцарела, соус',
      price: 199,
      category: MenuCategory.pizza,
    ),
    // ... решта позицій меню перенесена з menu_data.dart без змін
  ];
 
  @override
  Future<List<PizzaItem>> getMenu() async => List.unmodifiable(_menu);
}