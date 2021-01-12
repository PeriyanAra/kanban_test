import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'package:kanban_test/configs/env.dart';

class AuthenticationRepository {
  Future<Map> authenticate({
    @required String username,
    @required String password
  }) async {
    try {
      var response = await http.post('${Env.base_url}/api/v1/users/login/', 
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'username': username,
          'password': password
        })
      ).timeout(const Duration(seconds: 10));

      return json.decode(response.body);
    } on TimeoutException catch (_) {
      return {
        'errors': {
          'network': 'Something went wrong'
        }
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