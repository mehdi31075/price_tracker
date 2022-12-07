import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/app/data/models/requests/get_symbol_ticks_request.dart';
import 'package:price_tracker/app/data/models/responses/get_symbol_ticks_response.dart';
import 'package:price_tracker/app/data/providers/api_provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SymbolTicksCubit extends Cubit<GetSymbolTicksState> {
  final ApiProvider apiProvider;
  SymbolTicksCubit({required this.apiProvider}) : super(GetSymbolTicksInitialState());
  late WebSocketChannel channel;
  SymbolTick? lastResponse;
  final markets = <String>[];

  getSymbolTicksRequest({
    required GetSymbolTicksRequest request,
  }) async {
    emit(GetSymbolTicksLoadingState());
    try {
      await for (final response in apiProvider.getSymbolTicks(request: request)) {
        emit(
          GetSymbolTicksSuccessState(
            symbolTick: response.tick,
            diff: (lastResponse?.quote ?? 0) - (response.tick?.quote ?? 0),
          ),
        );
        lastResponse = response.tick;
      }
    } on WebSocketChannelException catch (e) {
      channel.sink.close();
      emit(GetSymbolTicksErrorState(e: e));
    }
  }
}

abstract class GetSymbolTicksState {}

class GetSymbolTicksInitialState extends GetSymbolTicksState {}

class GetSymbolTicksLoadingState extends GetSymbolTicksState {}

class GetSymbolTicksSuccessState extends GetSymbolTicksState {
  GetSymbolTicksSuccessState({
    this.symbolTick,
    this.diff = 0.0,
  }) : super();
  final SymbolTick? symbolTick;
  final double diff;
}

class GetSymbolTicksErrorState extends GetSymbolTicksState {
  GetSymbolTicksErrorState({required this.e}) : super();
  final Exception e;
}
