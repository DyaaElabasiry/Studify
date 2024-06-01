import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'global_variables_for_library.dart';




class BodyOfPosts extends ConsumerStatefulWidget {
  final double width;

  const BodyOfPosts({required this.width});
  @override
  ConsumerState<BodyOfPosts> createState() => _BodyOfPostsState();
}

class _BodyOfPostsState extends ConsumerState<BodyOfPosts> {
  late ScrollController scrollController;

  @override
  void initState() {
    getPosts(width: widget.width, ref: ref);
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset == scrollController.position.maxScrollExtent) {
          if(ref.read(searchTagsProvider).isNotEmpty){
            getSearchPostsAtMaximumScrollingOffset(width: widget.width, ref: ref);
          } else {
            getPostsAtMaximumScrollingOffset(width: widget.width, ref: ref);
          }
          if (ref.read(lastDocumentProvider) != null) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent - 20);
          } //scrolls to the last post
        }
      });
    super.initState();
  }
  @override
  dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);
    return SingleChildScrollView(
      controller: scrollController,
      // physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          ...posts,
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}