import 'package:price_tracker/app/data/models/active_symbol.dart';
import 'package:price_tracker/app/data/providers/api_provider.dart';

class ApiRepository {
  final ApiProvider apiProvider;
  ApiRepository({
    required this.apiProvider,
  });

  Stream<List<ActiveSymbol>> getActiveSymbols() async* {
    try {
      // ignore: void_checks
      apiProvider.getActiveSymbols().listen((response) async* {
        yield response.activeSymbols;
      });
    } on Exception {
      rethrow;
    }
  }
}
