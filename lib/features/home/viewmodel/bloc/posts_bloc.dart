import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/posts_repository.dart';
import '../event/posts_event.dart';
import '../state/posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository repository;

  PostsBloc(this.repository) : super(PostsInitial()) {
    on<LoadPosts>((event, emit) async {
      emit(PostsLoading());
      final result = await repository.getPosts();
      result.fold(
        (failure) => emit(PostsError(failure)),
        (posts) => emit(PostsLoaded(posts)),
      );
    });
  }
}
