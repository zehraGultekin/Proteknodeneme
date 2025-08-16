import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proteknodenee/features/auth/data/repository/auth_repository.dart';
import '../event/auth_event.dart';
import '../state/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  
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
