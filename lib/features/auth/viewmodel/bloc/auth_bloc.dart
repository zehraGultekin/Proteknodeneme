import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proteknodenee/features/auth/data/repository/auth_repository_impl.dart';
import 'package:proteknodenee/features/auth/viewmodel/event/auth_event.dart';
import 'package:proteknodenee/features/auth/viewmodel/state/auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await repository.login(event.email, event.password);
      result.fold(
        (failure) => emit(AuthError(failure)),
        (user) => emit(Authenticated(user)),
      );
    });

    on<LogoutRequested>((event, emit) {
      emit(Unauthenticated());
    });
  }
}
