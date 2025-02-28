import 'package:book_heaven/models/bagbook_model.dart';
import 'package:book_heaven/presentation/screens/my_bag/view.dart';
import 'package:equatable/equatable.dart';


enum CartStatus { initial, loading, loaded, error }

class CartState extends Equatable {
  final List<BagBookModel> items;
  final CartStatus status;

  CartState({required this.items, required this.status});

  factory CartState.initial() => CartState(items: [], status: CartStatus.initial);

 

  CartState clone({List<BagBookModel>? items, CartStatus? status}) {
    return CartState(
      items: items ?? this.items,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [items, status];
}
