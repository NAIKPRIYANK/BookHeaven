

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class InitEvent extends HomeEvent{}

class BookInfoEvent extends HomeEvent{
  final int vendorId;
  final BuildContext context;

  const BookInfoEvent({required this.vendorId, required this.context});
}

