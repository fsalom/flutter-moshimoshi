import 'package:flutter_moshimoshi/core/utils/logs/hybrid_logger_wrapper.dart';
import 'package:flutter_moshimoshi/entities/token.dart';

class Tokens {
  Token accessToken;
  Token refreshToken;

  Tokens({required this.accessToken, required this.refreshToken}) {
    accessToken = accessToken;
    HybridLoggerWrapper().logger.info("AccessToken: $accessToken");
    refreshToken = refreshToken;
    HybridLoggerWrapper().logger.info("RefreshToken: $refreshToken");
  }
}
