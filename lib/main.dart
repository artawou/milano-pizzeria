
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'application/use_cases/add_item_to_order_use_case.dart';
import 'application/use_cases/clear_order_use_case.dart';
import 'application/use_cases/get_menu_use_case.dart';
import 'application/use_cases/get_order_use_case.dart';
import 'application/use_cases/remove_item_from_order_use_case.dart';

import 'domain/repositories/menu_repository.dart';
import 'domain/repositories/order_repository.dart';

import 'infrastructure/repositories/in_memory_menu_repository.dart';
import 'infrastructure/repositories/in_memory_order_repository.dart';

import 'presentation/providers/order_notifier.dart';
import 'presentation/providers/theme_notifier.dart';
import 'presentation/screens/home_screen.dart';

List<SingleChildWidget> buildProviders() {
  // Infrastructure: конкретні реалізації репозиторіїв.
  final MenuRepository menuRepository = InMemoryMenuRepository();
  final OrderRepository orderRepository = InMemoryOrderRepository();

  // Application: створення Use Cases.
  final getMenu = GetMenuUseCase(menuRepository);
  final getOrder = GetOrderUseCase(orderRepository);
  final addItem = AddItemToOrderUseCase(orderRepository);
  final removeItem = RemoveItemFromOrderUseCase(orderRepository);
  final clearOrder = ClearOrderUseCase(orderRepository);

  // Presentation: передавання залежностей у Provider-и.
  return [
    Provider<GetMenuUseCase>.value(value: getMenu),

    ChangeNotifierProvider(
      create: (_) => OrderNotifier(
        getOrder: getOrder,
        addItem: addItem,
        removeItem: removeItem,
        clearOrder: clearOrder,
      ),
    ),

    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
    ),
  ];
}

void main() {
  runApp(
    MultiProvider(
      providers: buildProviders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.select<ThemeNotifier, ThemeMode>(
      (theme) => theme.mode,
    );

    const seed = Color(0xFF6750A4);

    return MaterialApp(
      title: 'Піцерія — меню',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
      ),

      themeMode: mode,
      home: const HomeScreen(),
    );
  }
}