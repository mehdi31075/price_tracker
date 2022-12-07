// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_symbol_ticks_request.freezed.dart';
part 'get_symbol_ticks_request.g.dart';


@freezed
@immutable
class GetSymbolTicksRequest with _$GetSymbolTicksRequest {
  const factory GetSymbolTicksRequest({
    @JsonKey(name: 'ticks') String? ticks,
    @JsonKey(name: 'subscribe') @Default(1) int? subscribe,
  }) = _GetSymbolTicksRequest;

  factory GetSymbolTicksRequest.fromJson(Map<String, dynamic> json) => _$GetSymbolTicksRequestFromJson(json);

  const GetSymbolTicksRequest._();
}