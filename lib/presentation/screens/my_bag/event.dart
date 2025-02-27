import 'package:equatable/equatable.dart';


abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitEvent extends CartEvent {}



class RemoveItemEvent extends CartEvent {
  final int itemId;
  RemoveItemEvent(this.itemId);
}

class IncreaseQuantityEvent extends CartEvent {
  final int itemId;
  IncreaseQuantityEvent(this.itemId);
}

class DecreaseQuantityEvent extends CartEvent {
  final int itemId;
  DecreaseQuantityEvent(this.itemId);
}
