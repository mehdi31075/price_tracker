// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_active_symbols_request.freezed.dart';
part 'get_active_symbols_request.g.dart';


@freezed
@immutable
class GetActiveSymbolsRequest with _$GetActiveSymbolsRequest {
  const factory GetActiveSymbolsRequest({
    @JsonKey(name: 'active_symbols') @Default('brief') String? activeSymbols,
    @JsonKey(name: 'product_type') @Default('basic') String? productType,
  }) = _GetActiveSymbolsRequest;

  factory GetActiveSymbolsRequest.fromJson(Map<String, dynamic> json) => _$GetActiveSymbolsRequestFromJson(json);

  const GetActiveSymbolsRequest._();
}