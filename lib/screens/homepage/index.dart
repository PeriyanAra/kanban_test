import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* Blocs */
import 'package:kanban_test/blocs/authentication/bloc.dart';
import 'package:kanban_test/blocs/tickets/bloc.dart';

/* Models */
import 'package:kanban_test/models/ticket.dart';

/* Widgets */
import 'package:kanban_test/screens/homepage/tickets_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AuthenticationBloc _authenticationBloc;
  TicketsBloc _ticketsBloc;

  List<Tab> _tabs = [
    Tab(
      text: 'On hold',
    ),
    Tab(
      text: 'In progress',
    ),
    Tab(
      text: 'Needs review',
    ),
    Tab(
      text: '“Approved”',
    )
  ];
  TabController _tabController;

  @override
  void initState() { 
    super.initState();
    
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _ticketsBloc = BlocProvider.of<TicketsBloc>(context);
    _tabController = TabController(length: _tabs.length, vsync: this);

    _ticketsBloc.add(FetchTickets());
  }

  void _handleLogoutButtonTap() {
    _authenticationBloc.add(AuthenticationLoggedOut());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketsBloc, TicketsState>(
      builder: (BuildContext context, TicketsState _ticketsState) {
        Map<String, List<Ticket>> ticketsMap;
        
        if (_ticketsState is TicketsLoaded) {
          ticketsMap = _ticketsState.ticketsMap;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Trello'),
            bottom: TabBar(
              tabs: _tabs,
              controller: _tabController,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: _handleLogoutButtonTap,
              ),
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _ticketsState is TicketsLoading ? Container(child: Center(child: CircularProgressIndicator(),),) : TicketsList(ticketsList: ticketsMap['0'],),
              _ticketsState is TicketsLoading ? Container(child: Center(child: CircularProgressIndicator(),),) : TicketsList(ticketsList: ticketsMap['1'],),
              _ticketsState is TicketsLoading ? Container(child: Center(child: CircularProgressIndicator(),),) : TicketsList(ticketsList: ticketsMap['2'],),
              _ticketsState is TicketsLoading ? Container(child: Center(child: CircularProgressIndicator(),),) : TicketsList(ticketsList: ticketsMap['3'],)
            ],
          ),
        );
      }
    );
  }
}