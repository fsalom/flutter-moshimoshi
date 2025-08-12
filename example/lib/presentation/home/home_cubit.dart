import 'package:example/bloc/bloc_status.dart';
import 'package:example/constants/constants.dart';
import 'package:example/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_moshimoshi/core/utils/logs/hybrid_logger_wrapper.dart';
import 'package:flutter_moshimoshi/entities/token.dart';

class HomeCubit extends Cubit<BlocStatus> {
  HomeCubit() : super(BlocStatus.success);

  void getInfo() async {}

  void logout() async {
    try {
      emit(BlocStatus.loading);
      Di().setContext(Constants.navKey.currentContext!);
      await Di().authenticator?.logout();
      emit(BlocStatus.success);
    } catch (error) {
      emit(BlocStatus.error);
    }
  }

  void expireAccess() async {
    try {
      emit(BlocStatus.loading);
      Token token = await Di().tokenStore.getAccessToken();
      var newToken = Token(token.value, 0, 0);
      Di().tokenStore.setAccessToken(newToken);
      emit(BlocStatus.success);
    } catch (error) {
      emit(BlocStatus.error);
    }
  }

  void expireAccessAndRefresh() async {
    try {
      emit(BlocStatus.loading);
      Token token = await Di().tokenStore.getAccessToken();
      var newToken = Token(token.value, 0, 0);
      Di().tokenStore.setAccessToken(newToken);
      Token refreshToken = await Di().tokenStore.getRefreshToken();
      var newRefreshToken = Token(refreshToken.value, 0, 0);
      Di().tokenStore.setRefreshToken(newRefreshToken);
      emit(BlocStatus.success);
    } catch (error) {
      emit(BlocStatus.error);
    }
  }

  void authenticatedCall() async {
    try {
      emit(BlocStatus.loading);
      var data = Di()
          .moshi
          ?.callAuthenticated
          .get("${Constants.baseUrl}/sites/favorites?page=1");
      HybridLoggerWrapper().logger.info(data.toString());
      emit(BlocStatus.success);
    } catch (error) {
      emit(BlocStatus.error);
    }
  }
}
