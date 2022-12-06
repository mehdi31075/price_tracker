// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:price_tracker/app/data/models/active_symbol.dart';

part 'get_active_symbols_response.freezed.dart';
part 'get_active_symbols_response.g.dart';


@freezed
@immutable
class GetActiveSymbolsResponse with _$GetActiveSymbolsResponse {
  const factory GetActiveSymbolsResponse({
    @JsonKey(name: 'active_symbols') @Default([]) List<ActiveSymbol> activeSymbols,
    @JsonKey(name: 'echo_req') EchoReq? echoReq,
    @JsonKey(name: 'msg_type') String? msgType,
    @JsonKey(name: 'req_id') int? reqId,
  }) = _GetActiveSymbolsResponse;

  factory GetActiveSymbolsResponse.fromJson(Map<String, dynamic> json) => _$GetActiveSymbolsResponseFromJson(json);

  const GetActiveSymbolsResponse._();
}

@freezed
@immutable
class EchoReq with _$EchoReq {
  const factory EchoReq({
    @JsonKey(name: 'active_symbols') String? activeSymbols,
    @JsonKey(name: 'product_type') String? productType,
    @JsonKey(name: 'req_id') int? reqId,
  }) = _EchoReq;

  factory EchoReq.fromJson(Map<String, dynamic> json) => _$EchoReqFromJson(json);

  const EchoReq._();
}