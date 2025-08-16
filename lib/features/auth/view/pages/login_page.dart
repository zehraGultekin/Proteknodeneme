import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proteknodenee/core/router/app_routes.dart';
import 'package:proteknodenee/core/theme/app_colors.dart';
import 'package:proteknodenee/core/theme/app_text_styles.dart';
import 'package:proteknodenee/core/theme/primary_button.dart';
import 'package:proteknodenee/core/widgets/gradient_background.dart';
import 'package:proteknodenee/features/auth/data/repository/auth_repository_impl.dart';
import 'package:proteknodenee/features/auth/view/widgets/textfield.dart';
import 'package:proteknodenee/features/auth/viewmodel/bloc/auth_bloc.dart';
import 'package:proteknodenee/features/auth/viewmodel/event/auth_event.dart';
import 'package:proteknodenee/features/auth/viewmodel/state/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => AuthBloc(AuthRepositoryImpl()),
      child: Scaffold(
        body: GradientBackground(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Container(
                    width: size.width * 0.35,
                    height: size.width * 0.35,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Image.asset(
                        'assets/icons/logo1.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is Authenticated) {
                        context.goNamed(AppRoute.home.name);
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: AppColors.error,
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 25,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          LoginTextField(
                            controller: emailController,
                            hintText: "Email",
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          LoginTextField(
                            controller: passwordController,
                            hintText: "Password",
                            icon: Icons.lock_outline,
                            obscureText: true,
                          ),
                          const SizedBox(height: 24),

                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return const CircularProgressIndicator();
                              }
                              return PrimaryButton(
                                text: "Login",
                                onPressed: () {
                                  context.read<AuthBloc>().add(
                                        LoginRequested(
                                          emailController.text.trim(),
                                          passwordController.text.trim(),
                                        ),
                                      );
                                },
                              );
                            },
                          ),

                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: AppTextStyles.title,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Sign Up",
                          style: AppTextStyles.title,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
