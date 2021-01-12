import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kanban_test/configs/env.dart';



class TicketsRepository {
  Future<Map> fetchTickets() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String token = sharedPreferences.getString('token');

      var response = await http.get('${Env.base_url}/api/v1/cards/', 
        headers: {
          "Authorization": "JWT $token"
        },
      );

      return {
        'result': utf8.decode(response.bodyBytes)
      };
    } on Error catch (_) {
      return {
        'errors': {
          'network': 'Something went wrong'
        }
      };
    } catch (_) {
      return {
        'errors': {
          'network': 'Something went wrong'
        }
      };
    }
  }
}