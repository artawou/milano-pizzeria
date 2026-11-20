// lib/domain/entities/pizza_item.dart
enum MenuCategory { pizza, drinks, snacks, desserts, sauces }
 
class PizzaItem {
  const PizzaItem({
    required this.title,
    required this.description,
    required this.price,
    required this.category,
  });
 
  final String title;
  final String description;
  final double price;
  final MenuCategory category;
}