import 'package:flutter/material.dart';
import 'package:reactive_exploration/common/widgets/cart_button.dart';
import 'package:reactive_exploration/common/widgets/theme.dart';
import 'package:reactive_exploration/src/cart/bloc_cart_page.dart';
import 'package:reactive_exploration/src/cart/cart_bloc.dart';
import 'package:reactive_exploration/src/cart/cart_provider.dart';
import 'package:reactive_exploration/src/catalog/catalog_bloc.dart';
import 'package:reactive_exploration/src/product_grid/product_grid.dart';
import 'package:reactive_exploration/src/services/catalog.dart';

void main() {
  // Initiate services.
  final catalogService = CatalogService();

  // Build top-level components.
  // In a real world app, this would also rope in HTTP clients and such.
  final catalog = CatalogBloc(catalogService);
  final cart = CartBloc();

  // Start the app.
  runApp(MyApp(catalog, cart));
}

class MyApp extends StatelessWidget {
  final CatalogBloc catalog;

  final CartBloc cart;

  MyApp(this.catalog, this.cart);

  @override
  Widget build(BuildContext context) {
    // Here we're providing the catalog component ...
    return CatalogProvider(
      catalog: catalog,
      // ... and the cart component via InheritedWidget like so.
      // But BLoC works with any other mechanism, including passing
      // down the widget tree.
      key: ValueKey("mainCatalogProvicer"),
      child: CartProvider(
        cartBloc: cart,
        key: ValueKey("mainMaterialApp"),
        child: MaterialApp(
          title: 'Bloc Complex',
          theme: appTheme,
          home: MyHomePage(),
          routes: {BlocCartPage.routeName: (context) => BlocCartPage()},
        ),
      ),
    );
  }
}

/// The sample app's main page
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartBloc = CartProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Complex"),
        actions: <Widget>[
          StreamBuilder<int>(
            stream: cartBloc.itemCount,
            builder: (context, snapshot) => CartButton(
              itemCount: snapshot.data ?? 0,
              key: ValueKey("asdas"),
              onPressed: () {
                Navigator.of(context).pushNamed(BlocCartPage.routeName);
              },
            ),
          )
        ],
      ),
      body: ProductGrid(),
    );
  }
}
