import 'dart:async';
import 'dart:convert';

import 'package:price_tracker/app/data/endpoints.dart';
import 'package:price_tracker/app/data/models/requests/forget_tick_request.dart';
import 'package:price_tracker/app/data/models/requests/get_active_symbols_request.dart';
import 'package:price_tracker/app/data/models/requests/get_symbol_ticks_request.dart';
import 'package:price_tracker/app/data/models/responses/forget_tick_response.dart';
import 'package:price_tracker/app/data/models/responses/get_active_symbols_response.dart';
import 'package:price_tracker/app/data/models/responses/get_symbol_ticks_response.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ApiProvider {
  final appId = 33750;
  late WebSocketChannel _getSymbolTicksChannel;

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
      _getSymbolTicksChannel = WebSocketChannel.connect(
        Uri.parse('${Endpoints.baseUrl}?app_id=$appId'),
      );
      _getSymbolTicksChannel.sink.add(
        jsonEncode(request.toJson()),
      );
      await for (var element in _getSymbolTicksChannel.stream) {
        yield GetSymbolTicksResponse.fromJson(jsonDecode(element));
      }
    } on Exception {
      rethrow;
    }
  }

  Stream<ForgetTickResponse> forgetTick({required ForgetTickRequest request}) async* {
    try {
      _getSymbolTicksChannel.sink.close();
      final channel = WebSocketChannel.connect(
        Uri.parse('${Endpoints.baseUrl}?app_id=$appId'),
      );
      channel.sink.add(
        jsonEncode(request.toJson()),
      );
      await for (var element in channel.stream) {
        yield ForgetTickResponse.fromJson(jsonDecode(element));
        channel.sink.close();
      }
    } on Exception {
      rethrow;
    }
  }
}
