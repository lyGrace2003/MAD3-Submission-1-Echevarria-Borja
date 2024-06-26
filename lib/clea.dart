import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:midterm_project/src/model/post_model.dart';

class ClearDataScreen extends StatelessWidget {
  final Box<Post> _postBox = Hive.box<Post>('posts');

  void clearHiveData() {
    _postBox.clear(); // Clear all data in the 'posts' box
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clear Data'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            clearHiveData();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Data cleared successfully.'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: Text('Clear Data'),
        ),
      ),
    );
  }
}
