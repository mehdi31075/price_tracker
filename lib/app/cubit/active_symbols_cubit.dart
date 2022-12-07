import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/app/data/models/active_symbol.dart';
import 'package:price_tracker/app/data/providers/api_provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ActiveSymbolsCubit extends Cubit<GetActiveSymbolsState> {
  final ApiProvider apiProvider;
  ActiveSymbolsCubit({required this.apiProvider}) : super(GetActiveSymbolsInitialState());
  late WebSocketChannel channel;

  getActiveSymbolRequest() async {
    emit(GetActiveSymbolsLoadingState());
    final markets = <String>[];
    try {
      await for (final response in apiProvider.getActiveSymbols()) {
        for (var symbol in response.activeSymbols) {
          if (!markets.contains(symbol.market)) {
            markets.add(symbol.market ?? '');
          }
        }
        emit(GetActiveSymbolsSuccessState(activeSymbols: response.activeSymbols, markets: markets));
      }
    } on WebSocketChannelException catch (e) {
      channel.sink.close();
      emit(GetActiveSymbolsErrorState(e: e));
    }
  }
}

abstract class GetActiveSymbolsState {}

class GetActiveSymbolsInitialState extends GetActiveSymbolsState {}

class GetActiveSymbolsLoadingState extends GetActiveSymbolsState {}

class GetActiveSymbolsSuccessState extends GetActiveSymbolsState {
  GetActiveSymbolsSuccessState({
    required this.activeSymbols,
    required this.markets,
  }) : super();
  final List<ActiveSymbol> activeSymbols;
  final List<String> markets;
}

class GetActiveSymbolsErrorState extends GetActiveSymbolsState {
  GetActiveSymbolsErrorState({required this.e}) : super();
  final Exception e;
}
