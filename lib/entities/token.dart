import 'package:json_annotation/json_annotation.dart';
part 'token.g.dart';

@JsonSerializable()
class Token {
  final String accessToken;
  final int expiresIn;
  late final DateTime expirationTime;

  Token({required this.accessToken, required this.expiresIn}) {
    expirationTime = DateTime.now().add(Duration(seconds: expiresIn));
  }
}