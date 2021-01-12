import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class TicketsEvent extends Equatable {
  const TicketsEvent();

  @override
  List<Object> get props => [];
}



class FetchTickets extends TicketsEvent {
  const FetchTickets();

  @override
  List<Object> get props => [];
}