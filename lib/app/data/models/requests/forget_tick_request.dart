// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_tick_request.freezed.dart';
part 'forget_tick_request.g.dart';


@freezed
@immutable
class ForgetTickRequest with _$ForgetTickRequest {
  const factory ForgetTickRequest({
    @JsonKey(name: 'forget') String? forget,
    @JsonKey(name: 'req_id') int? reqId,
  }) = _ForgetTickRequest;

  factory ForgetTickRequest.fromJson(Map<String, dynamic> json) => _$ForgetTickRequestFromJson(json);

  const ForgetTickRequest._();
}