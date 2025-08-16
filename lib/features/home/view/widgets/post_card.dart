import 'package:flutter/material.dart';
import 'package:proteknodenee/core/theme/app_colors.dart';
import 'package:proteknodenee/core/theme/app_text_styles.dart';


class PostCard extends StatelessWidget {
  final String title;
  final String body;

  const PostCard({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        title: Text(title, style: AppTextStyles.title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(body, style: AppTextStyles.body),
        ),
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: const Icon(Icons.article, color: AppColors.primary),
        ),
      ),
    );
  }
}
