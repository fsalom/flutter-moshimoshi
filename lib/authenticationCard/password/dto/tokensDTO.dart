import 'package:json_annotation/json_annotation.dart';

part 'tokensDTO.g.dart';

@JsonSerializable()
class TokenDTO {
  final String access_token;
  final String refresh_token;
  final int expires_in;
  int expirationTime;

  TokenDTO(this.expirationTime, {required this.access_token, required this.refresh_token, required this.expires_in}) {
    var expirationDate = DateTime.now().add(Duration(seconds: expires_in));
    expirationTime = expirationDate.microsecondsSinceEpoch;
  }
}