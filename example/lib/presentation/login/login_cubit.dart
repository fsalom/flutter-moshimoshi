
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
      'email': "mangelRudo@rudo.es",
      'password': "12345678A#",
      "client_id": "eCThzMke1zIxhvPVKGLIoxZkvB5sFRyZdpxXqxgJ",
      "client_secret":
          "i8lFXztdl6fOUktHGF2b8kHKqbRqhMJ36ocZ9by66uTp1xmj7YhFYqGlxuiH0sLYx533SYDR6Rgyk7uxeCNoooTetxJli9IUlgmyrbZ4PZa0b8m3KdStkgIgJIZDLCbh"
    };
      await Di().authenticator?.getNewToken(data);
      if (Constants.navKey.currentContext != null) {
        Navigator.of(Constants.navKey.currentContext!)
            .pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
      }
      emit(BlocStatus.success);
    } catch (error) {
      emit(BlocStatus.error);
    }
  }
}
