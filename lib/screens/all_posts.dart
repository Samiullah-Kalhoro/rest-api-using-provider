import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../providers/auth_provider.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({super.key});

  @override
  State<AllPosts> createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  List<Post> _posts = [];
  bool _isLoading = true;

  Future<void> _fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _posts = data.map((postJson) => Post.fromJson(postJson)).toList();
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  void initState() {
    _fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final currentUser = authProvider.currentUser;

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _posts.length,
            itemBuilder: (context, index) {
              final post = _posts[index];
              final isCurrentUserPost = post.userId == currentUser?.id;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        post.title,
                        style: TextStyle(
                          fontWeight: isCurrentUserPost
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isCurrentUserPost
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                      ),
                      subtitle: Text(post.body),
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          );
  }
}
