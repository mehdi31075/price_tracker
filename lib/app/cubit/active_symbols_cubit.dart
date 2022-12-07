import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/app/cubit/symbol_ticks_cubit.dart';
import 'package:price_tracker/app/data/models/active_symbol.dart';
import 'package:price_tracker/app/data/models/requests/get_symbol_ticks_request.dart';
import 'package:price_tracker/app/data/models/responses/get_active_symbols_response.dart';
import 'package:price_tracker/app/data/providers/api_provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ActiveSymbolsCubit extends Cubit<GetActiveSymbolsState> {
  final ApiProvider apiProvider;
  ActiveSymbolsCubit({required this.apiProvider}) : super(GetActiveSymbolsInitialState());
  GetActiveSymbolsResponse? response;
  final markets = <String>[];

  getActiveSymbolRequest() async {
    emit(GetActiveSymbolsLoadingState());
    try {
      await for (final response in apiProvider.getActiveSymbols()) {
        for (var symbol in response.activeSymbols) {
          if (!markets.contains(symbol.market)) {
            markets.add(symbol.market ?? '');
          }
        }
        this.response = response;
        emit(GetActiveSymbolsSuccessState(activeSymbols: response.activeSymbols, markets: markets));
      }
    } on WebSocketChannelException catch (e) {
      emit(GetActiveSymbolsErrorState(e: e));
    }
  }

  selectMarket(String market) {
    if (response != null) {
      emit(
        GetActiveSymbolsSuccessState(
          activeSymbols: response!.activeSymbols
              .where(
                (symbol) => symbol.market == market,
              )
              .toList(),
          markets: markets,
          selectedMarket: market,
        ),
      );
    }
  }

  selectAsset(SymbolTicksCubit bloc, ActiveSymbol asset) {
    if (response != null) {
      emit(
        GetActiveSymbolsSuccessState(
          activeSymbols: response!.activeSymbols,
          markets: markets,
          selectedMarket: asset.market,
          selectedAsset: asset,
        ),
      );
    }
    bloc.getSymbolTicksRequest(
      request: GetSymbolTicksRequest(
        ticks: asset.symbol,
      ),
    );
  }
}

abstract class GetActiveSymbolsState {}

class GetActiveSymbolsInitialState extends GetActiveSymbolsState {}

class GetActiveSymbolsLoadingState extends GetActiveSymbolsState {}

class GetActiveSymbolsSuccessState extends GetActiveSymbolsState {
  GetActiveSymbolsSuccessState({
    required this.activeSymbols,
    required this.markets,
    this.selectedMarket,
    this.selectedAsset,
  }) : super();
  final List<ActiveSymbol> activeSymbols;
  final List<String> markets;
  final String? selectedMarket;
  final ActiveSymbol? selectedAsset;
}

class GetActiveSymbolsErrorState extends GetActiveSymbolsState {
  GetActiveSymbolsErrorState({required this.e}) : super();
  final Exception e;
}
