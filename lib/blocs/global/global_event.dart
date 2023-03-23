abstract class GlobalEvent {}

class AddCartItem extends GlobalEvent {
  AddCartItem();
}

class RemoveCartItem extends GlobalEvent {
  RemoveCartItem();
}
