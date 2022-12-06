import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/app/data/models/active_symbol.dart';
import 'package:price_tracker/app/data/repositories/api_repository.dart';

class ActiveSymbolsCubit extends Cubit<GetActiveSymbolsState> {
  final ApiRepository apiRepository;
  ActiveSymbolsCubit({required this.apiRepository}) : super( GetActiveSymbolsInitialState());

  getActiveSymbolRequest() async {
    emit( GetActiveSymbolsLoadingState());
    try {
      apiRepository.getActiveSymbols().listen((activeSymbols) {
        emit( GetActiveSymbolsSuccessState(activeSymbols: activeSymbols));
      });
    } on Exception catch (e) {
      emit( GetActiveSymbolsErrorState(e: e));
    }
  }
}

abstract class GetActiveSymbolsState {}

class  GetActiveSymbolsInitialState extends GetActiveSymbolsState {}

class  GetActiveSymbolsLoadingState extends GetActiveSymbolsState {}

class  GetActiveSymbolsSuccessState extends GetActiveSymbolsState {
   GetActiveSymbolsSuccessState({required this.activeSymbols}) : super();
  final List<ActiveSymbol> activeSymbols;
}

class  GetActiveSymbolsErrorState extends GetActiveSymbolsState {
   GetActiveSymbolsErrorState({required this.e}) : super();
  final Exception e;
}
