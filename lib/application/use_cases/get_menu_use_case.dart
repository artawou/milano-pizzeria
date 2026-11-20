import '../../domain/entities/pizza_item.dart';
import '../../domain/repositories/menu_repository.dart';

class GetMenuUseCase {
  const GetMenuUseCase(this._menu);

  final MenuRepository _menu;

  Future<List<PizzaItem>> call() => _menu.getMenu();
}