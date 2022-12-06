import 'package:price_tracker/app/data/endpoints.dart';
import 'package:price_tracker/app/data/models/requests/get_active_symbols_request.dart';
import 'package:price_tracker/app/data/models/responses/get_active_symbols_response.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ApiProvider {
  final appId = 1089;
  Stream<GetActiveSymbolsResponse> getActiveSymbols({GetActiveSymbolsRequest? request}) async* {
    late WebSocketChannel channel;
    channel = WebSocketChannel.connect(
      Uri.parse('${Endpoints.baseUrl}?app_id=$appId'),
    );
    channel.sink.add(
      request?.toJson(),
    );
    // ignore: void_checks
    channel.stream.listen((event) async* {
      yield GetActiveSymbolsResponse.fromJson(event);
    });
  }
}
