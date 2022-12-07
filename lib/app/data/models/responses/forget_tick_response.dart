// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_tick_response.freezed.dart';
part 'forget_tick_response.g.dart';


@freezed
@immutable
class ForgetTickResponse with _$ForgetTickResponse {
  const factory ForgetTickResponse({
    @JsonKey(name: 'req_id') int? reqId,
    @JsonKey(name: 'msg_type') String? msgType,
    @JsonKey(name: 'echo_req') EchoReq? echoReq,
    @JsonKey(name: 'forget') int? forget,
  }) = _ForgetTickResponse;

  factory ForgetTickResponse.fromJson(Map<String, dynamic> json) => _$ForgetTickResponseFromJson(json);

  const ForgetTickResponse._();
}

@freezed
@immutable
class EchoReq with _$EchoReq {
  const factory EchoReq({
    @JsonKey(name: 'forget') String? forget,
    @JsonKey(name: 'req_id') int? reqId,
  }) = _EchoReq;

  factory EchoReq.fromJson(Map<String, dynamic> json) => _$EchoReqFromJson(json);

  const EchoReq._();
}