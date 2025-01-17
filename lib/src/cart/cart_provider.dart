import 'package:flutter/widgets.dart';
import 'package:reactive_exploration/src/cart/cart_bloc.dart';

/// This is an InheritedWidget that wraps around [CartBloc]. Think about this
/// as Scoped Model for that specific class.
///
/// This merely solves the "passing reference down the tree" problem for us.
/// You can solve this in other ways, like through dependency injection.
///
/// Also note that this does not call [CartBloc.dispose]. If your app
/// ever doesn't need to access the cart, you should make sure it's
/// disposed of properly.
class CartProvider extends InheritedWidget {
  final CartBloc cartBloc;

  CartProvider({
    required Key key,
    required CartBloc cartBloc,
    required Widget child,
  })  : cartBloc = cartBloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CartBloc of(BuildContext context) => (context.dependOnInheritedWidgetOfExactType<CartProvider>() as CartProvider).cartBloc;
}
