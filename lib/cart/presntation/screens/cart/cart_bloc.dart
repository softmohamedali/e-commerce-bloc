import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entites/cart_item.dart';
import 'cart_events.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(items: [])) {
    on<LoadCart>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isLoading: false));
    });

    on<AddToCart>((event, emit) {
      final updatedItems = List<CartItem>.from(state.items)..add(event.item);
      emit(state.copyWith(items: updatedItems));
    });

    on<RemoveFromCart>((event, emit) {
      final updatedItems = List<CartItem>.from(state.items)..removeAt(event.index);
      emit(state.copyWith(items: updatedItems));
    });

    on<UpdateQuantity>((event, emit) {
      final updatedItems = List<CartItem>.from(state.items);
      updatedItems[event.index].quantity = event.quantity;
      emit(state.copyWith(items: updatedItems));
    });
  }

  double get totalPrice => state.items.fold(
      0,
          (sum, item) => sum + (item.price * item.quantity)
  );
}