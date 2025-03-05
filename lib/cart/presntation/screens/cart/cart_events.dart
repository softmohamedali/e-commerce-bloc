import '../../../domain/entites/cart_item.dart';

abstract class CartEvent {}

class LoadCart extends CartEvent {}
class AddToCart extends CartEvent {
  final CartItem item;
  AddToCart(this.item);
}
class RemoveFromCart extends CartEvent {
  final int index;
  RemoveFromCart(this.index);
}
class UpdateQuantity extends CartEvent {
  final int index;
  final int quantity;
  UpdateQuantity(this.index, this.quantity);
}