import 'dart:developer';

import 'package:book_heaven/database/sqflite_database_service.dart';
import 'package:book_heaven/models/bagbook_model.dart';
import 'package:book_heaven/presentation/screens/my_bag/event.dart';
import 'package:book_heaven/presentation/screens/my_bag/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<InitEvent>(_init);

    on<RemoveItemEvent>(_removeItem);
    on<IncreaseQuantityEvent>(_increaseQuantity);
    on<DecreaseQuantityEvent>(_decreaseQuantity);
  }

  Future<void> _init(InitEvent event, Emitter<CartState> emit) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt("userId");

      List<BagBookModel> bagbookList =
          await DatabaseHelper.instance.getUserBagBooks(userId ?? 0);

      emit(state.clone(items: bagbookList, status: CartStatus.loaded));
    } catch (e) {
      log("Error initializing cart: $e");
      emit(state.clone(status: CartStatus.error));
    }
  }

  Future<void> _removeItem(
      RemoveItemEvent event, Emitter<CartState> emit) async {
    try {
      int result =
          await DatabaseHelper.instance.removeBookFromBag(event.itemId);

      if (result > 0) {
        // Show toast notification
        Fluttertoast.showToast(
            msg: "Item removed successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.redAccent);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        final userId = prefs.getInt("userId");

        List<BagBookModel> updatedBookBagList =
            await DatabaseHelper.instance.getUserBagBooks(userId ?? 0);

        // ✅ Emit new state with updated cart items
        emit(state.clone(items: updatedBookBagList, status: CartStatus.loaded));
      } else {
        log("Failed to remove item");
      }
    } catch (e) {
      log("Error removing item: $e");
      emit(state.clone(status: CartStatus.error));
    }
  }

  Future<void> _increaseQuantity(
      IncreaseQuantityEvent event, Emitter<CartState> emit) async {
    try {
      int result =
          await DatabaseHelper.instance.increaseBookQuantity(event.itemId);

      if (result > 0) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final userId = prefs.getInt("userId");

        List<BagBookModel> updatedBagList =
            await DatabaseHelper.instance.getUserBagBooks(userId ?? 0);

        // ✅ Emit new state with updated cart items
        emit(state.clone(items: updatedBagList, status: CartStatus.loaded));
      } else {
        log("Failed to increase book quantity");
      }
    } catch (e) {
      log("Error increasing book quantity: $e");
      emit(state.clone(status: CartStatus.error));
    }
  }

  Future<void> _decreaseQuantity(
      DecreaseQuantityEvent event, Emitter<CartState> emit) async {
    try {
      int result =
          await DatabaseHelper.instance.decreaseBookQuantity(event.itemId);

      if (result > 0) {
        log("Book quantity decreased successfully");

        SharedPreferences prefs = await SharedPreferences.getInstance();
        final userId = prefs.getInt("userId");

        List<BagBookModel> updatedBagList =
            await DatabaseHelper.instance.getUserBagBooks(userId ?? 0);

        // ✅ Emit new state with updated cart items
        emit(state.clone(items: updatedBagList, status: CartStatus.loaded));
      } else {
        log("Failed to decrease book quantity");
      }
    } catch (e) {
      log("Error decreasing book quantity: $e");
      emit(state.clone(status: CartStatus.error));
    }
  }
}
