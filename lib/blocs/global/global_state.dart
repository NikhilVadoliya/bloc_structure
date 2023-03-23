abstract class GlobalState {
  final int cartCount;

  GlobalState(this.cartCount);
}

class InitGlobalState extends GlobalState {
  InitGlobalState() : super(0);
}

class UpdatedCartItem extends GlobalState {
  UpdatedCartItem(super.cartCount);
}
