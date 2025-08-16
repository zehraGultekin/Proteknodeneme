import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proteknodenee/features/home/data/posts_repository_impl.dart';
import 'package:proteknodenee/features/home/viewmodel/bloc/posts_bloc.dart';
import 'package:proteknodenee/features/home/viewmodel/event/posts_event.dart';
import 'package:proteknodenee/features/home/viewmodel/state/posts_state.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsBloc(PostsRepositoryImpl())..add(LoadPosts()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Home Page")),
        body: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostsLoaded) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  );
                },
              );
            } else if (state is PostsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
