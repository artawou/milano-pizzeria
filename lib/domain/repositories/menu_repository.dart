import '../entities/pizza_item.dart';
 
abstract interface class MenuRepository {
  Future<List<PizzaItem>> getMenu();
}