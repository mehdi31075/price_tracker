import 'dart:async';
import 'dart:convert';

import 'package:price_tracker/app/data/endpoints.dart';
import 'package:price_tracker/app/data/models/requests/get_active_symbols_request.dart';
import 'package:price_tracker/app/data/models/requests/get_symbol_ticks_request.dart';
import 'package:price_tracker/app/data/models/responses/get_active_symbols_response.dart';
import 'package:price_tracker/app/data/models/responses/get_symbol_ticks_response.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ApiProvider {
  final appId = 33750;
  Stream<GetActiveSymbolsResponse> getActiveSymbols({GetActiveSymbolsRequest? request}) async* {
    try {
      final channel = WebSocketChannel.connect(
        Uri.parse('${Endpoints.baseUrl}?app_id=$appId'),
      );
      channel.sink.add(
        jsonEncode(
          (request ?? const GetActiveSymbolsRequest()).toJson(),
        ),
      );
      await for (var element in channel.stream) {
        yield GetActiveSymbolsResponse.fromJson(jsonDecode(element));
        channel.sink.close();
      }
    } on Exception {
      rethrow;
    }
  }

  Stream<GetSymbolTicksResponse> getSymbolTicks({required GetSymbolTicksRequest request}) async* {
    try {
      final channel = WebSocketChannel.connect(
        Uri.parse('${Endpoints.baseUrl}?app_id=$appId'),
      );
      channel.sink.add(
        jsonEncode(request.toJson()),
      );
      await for (var element in channel.stream) {
        yield GetSymbolTicksResponse.fromJson(jsonDecode(element));
      }
    } on Exception {
      rethrow;
    }
  }
}
