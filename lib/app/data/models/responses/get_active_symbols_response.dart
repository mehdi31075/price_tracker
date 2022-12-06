// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_active_symbols_response.freezed.dart';
part 'get_active_symbols_response.g.dart';


@freezed
@immutable
class GetActiveSymbolsActiveSymbolResponse with _$GetActiveSymbolsActiveSymbolResponse {
  const factory GetActiveSymbolsActiveSymbolResponse({
    @JsonKey(name: 'active_symbols') @Default([]) String? activeSymbols,
    @JsonKey(name: 'echo_req') EchoReq? echoReq,
    @JsonKey(name: 'msg_type') String? msgType,
    @JsonKey(name: 'req_id') int? reqId,
  }) = _GetActiveSymbolsActiveSymbolResponse;

  factory GetActiveSymbolsActiveSymbolResponse.fromJson(Map<String, dynamic> json) => _$GetActiveSymbolsActiveSymbolResponseFromJson(json);

  const GetActiveSymbolsActiveSymbolResponse._();
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