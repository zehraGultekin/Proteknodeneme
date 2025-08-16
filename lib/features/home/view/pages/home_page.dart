import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proteknodenee/core/theme/app_colors.dart';
import 'package:proteknodenee/core/theme/app_text_styles.dart';
import 'package:proteknodenee/core/widgets/gradient_background.dart';
import 'package:proteknodenee/features/home/data/posts_repository_impl.dart';
import 'package:proteknodenee/features/home/view/widgets/post_card.dart';
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
        backgroundColor: Colors.transparent,
        body: GradientBackground(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Home", style: AppTextStyles.heading),
                ),

                const SizedBox(height: 10),
                Expanded(
                  child: BlocBuilder<PostsBloc, PostsState>(
                    builder: (context, state) {
                      if (state is PostsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is PostsLoaded) {
                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            final post = state.posts[index];
                            return PostCard(
                              title: post.title,
                              body: post.body,
                            );
                          },
                        );
                      } else if (state is PostsError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: AppColors.error),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
