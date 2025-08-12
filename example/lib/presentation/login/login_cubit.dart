import 'package:example/bloc/bloc_status.dart';
import 'package:example/constants/constants.dart';
import 'package:example/di/di.dart';
import 'package:example/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<BlocStatus> {
  LoginCubit() : super(BlocStatus.success);

  Future<void> login() async {
    try {
      emit(BlocStatus.loading);
      Map<String, dynamic> data = {
        "grant_type": "password",
        'email': "desarrollo@rudo.es",
        'password': "12345678A",
        "client_id": "1gzyJeSOyjUOmbSHREbsothngkBMato1VypQz35D",
        "client_secret":
            "ynM8CpvlDHivO1jma1Q3Jv1RIJraBbJ9EtK5XI3dw4RpkxDgi9cZnmJlQs0XzuVCGWCNwQd8qJKAHFrLdHlRRDIzx8B08HJ0Htu6XFzP4kTRTWYIPHuCpldjouJhKvoA"
      };
      await Di().authenticator?.getNewToken(parameters: data);
      if (Constants.navKey.currentContext != null) {
        Navigator.of(Constants.navKey.currentContext!).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      }
      emit(BlocStatus.success);
    } catch (error) {
      emit(BlocStatus.error);
    }
  }
}
