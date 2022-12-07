// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_symbol_ticks_response.freezed.dart';
part 'get_symbol_ticks_response.g.dart';


@freezed
@immutable
class GetSymbolTicksResponse with _$GetSymbolTicksResponse {
  const factory GetSymbolTicksResponse({
    @JsonKey(name: 'tick') SymbolTick? tick,
    @JsonKey(name: 'echo_req') EchoReq? echoReq,
    @JsonKey(name: 'msg_type') String? msgType,
    @JsonKey(name: 'req_id') int? reqId,
  }) = _GetSymbolTicksResponse;

  factory GetSymbolTicksResponse.fromJson(Map<String, dynamic> json) => _$GetSymbolTicksResponseFromJson(json);

  const GetSymbolTicksResponse._();
}

@freezed
@immutable
class EchoReq with _$EchoReq {
  const factory EchoReq({
    @JsonKey(name: 'ticks') String? ticks,
    @JsonKey(name: 'subscribe') int? subscribe,
  }) = _EchoReq;

  factory EchoReq.fromJson(Map<String, dynamic> json) => _$EchoReqFromJson(json);

  const EchoReq._();
}

@freezed
@immutable
class SymbolTick with _$SymbolTick {
  const factory SymbolTick({
    @JsonKey(name: 'ask') double? ask,
    @JsonKey(name: 'bid') double? bid,
    @JsonKey(name: 'quote') double? quote,
    @JsonKey(name: 'symbol') String? symbol,
    @JsonKey(name: 'epoch') int? epoch,
    @JsonKey(name: 'pip_size') int? pipSize,
    @JsonKey(name: 'id') String? id,
  }) = _SymbolTick;

  factory SymbolTick.fromJson(Map<String, dynamic> json) => _$SymbolTickFromJson(json);

  const SymbolTick._();
}