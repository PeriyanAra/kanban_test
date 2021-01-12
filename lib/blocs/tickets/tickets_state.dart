import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

/* Models */
import 'package:kanban_test/models/ticket.dart';

abstract class TicketsState extends Equatable {
  const TicketsState();

  @override
  List<Object> get props => [];
}



class TicketsLoading extends TicketsState {}

class TicketsLoaded extends TicketsState {
  final Map<String, List<Ticket>> ticketsMap;

  TicketsLoaded({
    @required this.ticketsMap
  });

  @override
  List<Object> get props => [ticketsMap];
}