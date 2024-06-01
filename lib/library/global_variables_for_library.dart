import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:user_studify/library/post_card/post_card_widget.dart';
import 'library_create_post_page.dart';
import 'library_search_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final searchTagsProvider = StateProvider<List<String>>((ref) => []);
final postsProvider = StateProvider<List<Widget>>((ref) => []);
final lastDocumentProvider = StateProvider<DocumentSnapshot?>((ref)=> null);


/////////    navigation    ////////////
void goToSearchPage(context){
  Navigator.of(context).push(PageRouteBuilder(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) {
      return LibrarySearchPage();
    },
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) {
      return FadeTransition(
          opacity: animation,
          child: child
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
  ));
}

void goToCreatePostPage(context){
  Navigator.of(context).push(PageRouteBuilder(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) {
      return const LibraryCreatePostPage();
    },
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: animation.drive(Tween(begin: 1.1, end: 1.0)),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
    reverseTransitionDuration: const Duration(milliseconds: 150),
  ));
}





/////////    getting posts    /////////////
FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;


void  getPosts({required double width,required WidgetRef ref}){
  List <Widget> posts = [];
  _firestoreInstance.collection('library').orderBy('likes',descending: true).limit(8).get().then((value) {
    if(value.docs.isNotEmpty){
        for (var element in value.docs) {
            posts.add(PostCard(width: width, post: element.data(), documentId: element.id,));
      }
        ref.read(postsProvider.state).state = posts ;
        ref.read(lastDocumentProvider.state).state = value.docs.last ;
    }
  });
}

void getPostsAtMaximumScrollingOffset ({required double width,required WidgetRef ref}){
  var posts = [...ref.read(postsProvider)];
  var lastDocument = ref.read(lastDocumentProvider) ;
  if(lastDocument == null){
    print('first');
  }
  else{
    print('second');
    _firestoreInstance.collection('library').orderBy('likes',descending: true).startAfterDocument(lastDocument).limit(8).get().then((value) {
      if(value.docs.isNotEmpty){

        for (var element in value.docs) {

          posts.add(PostCard(width: width, post: element.data(), documentId: element.id,));
        }
        ref.read(postsProvider.state).state = posts ;
        ref.read(lastDocumentProvider.state).state = value.docs.last ;
      }else if(value.docs.isEmpty){
        print('third');
        posts.add(const Text('No more results',style: TextStyle(color: Colors.grey,fontSize: 30),));
        ref.read(postsProvider.state).state = posts ;
        ref.read(lastDocumentProvider.state).state = null ;
      }
    });
  }

}

void getSearchPosts({required double width,required WidgetRef ref}){
  List <Widget> posts = [];
  List<String> tags = ref.read(searchTagsProvider);
  if (tags.isNotEmpty) {
    _firestoreInstance.collection('library').where('tags',arrayContainsAny: tags).orderBy('likes',descending: true).limit(8).get().then((value) {
      if(value.docs.isNotEmpty){
          for (var element in value.docs) {
              posts.add(PostCard(width: width, post: element.data(), documentId: element.id,));
        }
          ref.read(postsProvider.state).state = posts ;
          ref.read(lastDocumentProvider.state).state = value.docs.last ;
      }
    });
  }
}

void getSearchPostsAtMaximumScrollingOffset ({required double width,required WidgetRef ref}){
  var posts = [...ref.read(postsProvider)];
  var lastDocument = ref.read(lastDocumentProvider) ;
  if(lastDocument == null){
    print('first');
  }
  else{
    print('second');
    List<String> tags = ref.read(searchTagsProvider);
    _firestoreInstance.collection('library').where('tags',arrayContainsAny: tags).orderBy('likes',descending: true).startAfterDocument(lastDocument).limit(8).get().then((value) {
      if(value.docs.isNotEmpty){

        for (var element in value.docs) {

          posts.add(PostCard(width: width, post: element.data(), documentId: element.id,));
        }
        ref.read(postsProvider.state).state = posts ;
        ref.read(lastDocumentProvider.state).state = value.docs.last ;
      }else if(value.docs.isEmpty){
        print('third');
        posts.add(const Text('No more results',style: TextStyle(color: Colors.grey,fontSize: 30),));
        ref.read(postsProvider.state).state = posts ;
        ref.read(lastDocumentProvider.state).state = null ;
      }
    });
  }

}