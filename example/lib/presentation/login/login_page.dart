import 'package:authentication_flow/bloc/bloc_status.dart';
import 'package:authentication_flow/presentation/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final LoginCubit cubit = LoginCubit();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: BlocBuilder<LoginCubit, BlocStatus>(
          bloc: cubit,
          builder: (context, state) {
            if (state == BlocStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("LOGIN PAGE"),
                  ElevatedButton(
                    onPressed: () => cubit.login(),
                    child: const Text("Login"),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
