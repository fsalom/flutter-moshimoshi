import 'package:authentication_flow/bloc/bloc_status.dart';
import 'package:authentication_flow/services/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<BlocStatus> {
  LoginCubit() : super(BlocStatus.success);

  Future<void> login() async {
    try {
      emit(BlocStatus.loading);
      await Auth().login();
      emit(BlocStatus.success);
    } catch (error) {
      emit(BlocStatus.error);
    }
  }
}
