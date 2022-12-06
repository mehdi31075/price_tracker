// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_symbol.freezed.dart';
part 'active_symbol.g.dart';


@freezed
@immutable
class ActiveSymbol with _$ActiveSymbol {
  const factory ActiveSymbol({
    @JsonKey(name: 'allow_forward_starting') int? allowForwardStarting,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'display_order') int? displayOrder,
    @JsonKey(name: 'exchange_is_open') int? exchangeIsOpen,
    @JsonKey(name: 'is_trading_suspended') int? isTradingSuspended,
    @JsonKey(name: 'market') String? market,
    @JsonKey(name: 'market_display_name') String? marketDisplayName,
    @JsonKey(name: 'pip') double? pip,
    @JsonKey(name: 'subgroup') String? subgroup,
    @JsonKey(name: 'subgroup_display_name') String? subgroupDisplayName,
    @JsonKey(name: 'submarket') String? submarket,
    @JsonKey(name: 'submarket_display_name') String? submarketDisplayName,
    @JsonKey(name: 'symbol') String? symbol,
    @JsonKey(name: 'symbol_type') String? symbolType,
  }) = _ActiveSymbol;

  factory ActiveSymbol.fromJson(Map<String, dynamic> json) => _$ActiveSymbolFromJson(json);

  const ActiveSymbol._();
}