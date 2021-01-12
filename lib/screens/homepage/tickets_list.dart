import 'package:flutter/material.dart';

/* Models */
import 'package:kanban_test/models/ticket.dart';

class TicketsList extends StatelessWidget {
  final List<Ticket> ticketsList;

  const TicketsList({
    Key key,
    @required this.ticketsList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ticketsList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${ticketsList[index].id}'),
              Text(ticketsList[index].text)
            ],
          ),
        );
      },
    );
  }
}