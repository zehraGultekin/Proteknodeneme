import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proteknodenee/core/router/app_routes.dart';
import 'package:proteknodenee/features/auth/data/repository/auth_repository_impl.dart';
import 'package:proteknodenee/features/auth/viewmodel/bloc/auth_bloc.dart';
import 'package:proteknodenee/features/auth/viewmodel/event/auth_event.dart';
import 'package:proteknodenee/features/auth/viewmodel/state/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => AuthBloc(AuthRepositoryImpl()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Login Page")),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              context.goNamed(AppRoute.home.name);
            }
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                LoginRequested(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                ),
                              );
                        },
                        child: const Text("Login"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
