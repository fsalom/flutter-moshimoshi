import 'package:authentication_flow/bloc/bloc_status.dart';
import 'package:authentication_flow/constants/constants.dart';
import 'package:authentication_flow/services/auth.dart';
import 'package:authentication_flow/services/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<BlocStatus> {
  HomeCubit() : super(BlocStatus.success);

  void getInfo() async {
    try {
      emit(BlocStatus.loading);
      String accessToken = await Auth().getAccessToken() ?? "";
      Map<String, dynamic> headers = {'Authorization': "Bearer $accessToken"};
      await DioService.dio.get("${Constants.baseUrl}/sites/favorites?page=1", options: Options(headers: headers));
      emit(BlocStatus.success);
    } catch (error) {
      emit(BlocStatus.error);
    }
  }

  void logout() async {
    try {
      emit(BlocStatus.loading);
      await Auth().logout();
      emit(BlocStatus.success);
    } catch (error) {
      emit(BlocStatus.error);
    }
  }
}
