import 'package:json_annotation/json_annotation.dart';

part 'tokensDTO.g.dart';

@JsonSerializable()
class TokenDTO {
  final String access_token;
  final String refresh_token;
  final int expires_in;

  TokenDTO(this.access_token, this.refresh_token, this.expires_in);
}