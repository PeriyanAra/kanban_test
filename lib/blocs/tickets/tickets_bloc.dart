import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

/* Services */
import 'package:kanban_test/services/tickets_repository.dart';

/* Models */
import 'package:kanban_test/models/ticket.dart';

import 'bloc.dart';

class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  final TicketsRepository _ticketsRepository = TicketsRepository();

  TicketsBloc(initialState) : super(initialState);

  @override
  Stream<TicketsState> mapEventToState(TicketsEvent event) async* {
    if (event is FetchTickets) {
      yield* _fetchTickets(event);
    }
  }



  Stream<TicketsState> _fetchTickets(FetchTickets event) async* {
    final Map fetchResponse = await _ticketsRepository.fetchTickets();

    if (fetchResponse['result'] != null) {
      List<Ticket> onHoldTickets = [];
      List<Ticket> inprogressTickets = [];
      List<Ticket> reviewNeededTickets = [];
      List<Ticket> approvedTickets = [];

      for (var singleTicketJson in jsonDecode(fetchResponse['result'])) {
        if (singleTicketJson['row'] == '0') {
          print('zzz - ${fetchResponse['result']}');
          onHoldTickets.add(
            Ticket(
              id: singleTicketJson['id'],
              text: singleTicketJson['text']
            )
          );
        } else if (singleTicketJson['row'] == '1') {
          inprogressTickets.add(
            Ticket(
              id: singleTicketJson['id'],
              text: singleTicketJson['text']
            )
          );
        } else if (singleTicketJson['row'] == '2') {
          reviewNeededTickets.add(
            Ticket(
              id: singleTicketJson['id'],
              text: singleTicketJson['text']
            )
          );
        } else if (singleTicketJson['row'] == '3') {
          approvedTickets.add(
            Ticket(
              id: singleTicketJson['id'],
              text: singleTicketJson['text']
            )
          );
        }
      }

      yield TicketsLoaded(
        ticketsMap: {
          '0': onHoldTickets,
          '1': inprogressTickets,
          '2': reviewNeededTickets,
          '3': approvedTickets
        }
      );
    }
  }
}