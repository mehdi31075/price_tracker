import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/app/data/models/active_symbol.dart';
import 'package:price_tracker/app/data/repositories/api_repository.dart';

class ActiveSymbolsCubit extends Cubit<GetActiveSymbolsState> {
  final ApiRepository apiRepository;
  ActiveSymbolsCubit({required this.apiRepository}) : super(GetActiveSymbolsInitialState());

  getActiveSymbolRequest() async {
    emit(GetActiveSymbolsLoadingState());
    try {
      final markets = <String>[];
      apiRepository.getActiveSymbols().listen((activeSymbols) {
        for (var symbol in activeSymbols) {
          if (!markets.contains(symbol.market)) {
            markets.add(symbol.market ?? '');
          }
        }
        emit(
          GetActiveSymbolsSuccessState(
            activeSymbols: activeSymbols,
            markets: markets,
          ),
        );
      });
    } on Exception catch (e) {
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
