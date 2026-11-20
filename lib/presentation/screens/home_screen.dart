
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/use_cases/get_menu_use_case.dart';
import '../../domain/entities/pizza_item.dart';
import '../providers/order_notifier.dart';
import '../providers/theme_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<PizzaItem>> _menuFuture;

  @override
  void initState() {
    super.initState();
    _menuFuture = context.read<GetMenuUseCase>()();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<OrderNotifier>().load();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Milano Pizzeria'),
        actions: [
          IconButton(
            onPressed: theme.toggle,
            icon: Icon(
              theme.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
          Consumer<OrderNotifier>(
            builder: (context, order, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Badge(
                    label: Text('${order.totalCount}'),
                    child: const Icon(Icons.shopping_cart),
                  ),
                ),
              );
            },
          ),
        ],
      ),

      body: FutureBuilder<List<PizzaItem>>(
        future: _menuFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Не вдалося завантажити меню'),
            );
          }

          final menu = snapshot.data ?? [];

          if (menu.isEmpty) {
            return const Center(
              child: Text('Меню поки порожнє'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: menu.length,
            itemBuilder: (context, index) {
              final pizza = menu[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.local_pizza,
                        size: 40,
                      ),
                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pizza.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(pizza.description),
                            const SizedBox(height: 8),
                            Text('${pizza.price} грн'),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          context
                              .read<OrderNotifier>()
                              .increment(pizza);
                        },
                        icon: const Icon(Icons.add_circle),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}