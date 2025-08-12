import 'package:example/bloc/bloc_status.dart';
import 'package:example/di/di.dart';
import 'package:example/presentation/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeCubit cubit = HomeCubit();

  @override
  void initState() {
    cubit.getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Di().setContext(context);
    return Scaffold(
      backgroundColor: Colors.amber,
      body: BlocBuilder<HomeCubit, BlocStatus>(
        bloc: cubit,
        builder: (context, state) {
          if (state == BlocStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("HOME PAGE"),
                ElevatedButton(
                  onPressed: () => cubit.expireAccess(),
                  child: const Text("Expirar Access"),
                ),
                ElevatedButton(
                  onPressed: () => cubit.expireAccessAndRefresh(),
                  child: const Text("Expirar Access y Refresh"),
                ),
                ElevatedButton(
                  onPressed: () => cubit.authenticatedCall(),
                  child: const Text("Llamada autenticada"),
                ),
                ElevatedButton(
                  onPressed: () => cubit.logout(),
                  child: const Text("Logout"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
