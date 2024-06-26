
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:midterm_project/src/controllers/auth_controller.dart';
import 'package:midterm_project/src/model/post_model.dart';
import 'package:midterm_project/src/routing/router.dart';
import 'package:provider/provider.dart';

//add and delete post works

class RestDemoScreen extends StatefulWidget {
  static const String route = "/rest";

  static const String name = "RestDemoScreen";
  const RestDemoScreen({Key? key}) : super(key: key);

  @override
  State<RestDemoScreen> createState() => _RestDemoScreenState();
}

class _RestDemoScreenState extends State<RestDemoScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PostController>(context, listen: false).loadHivePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        leading: IconButton(
          onPressed: () {
            Provider.of<PostController>(context, listen: false).loadHivePosts();
          },
          icon: const Icon(Icons.refresh),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showNewPostFunction(context);
            },
            icon: const Icon(Icons.add, color: Color(0xFF00BF62)),
          ),
           IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout, color: Colors.red),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<PostController>(
          builder: (context, controller, child) {
            if (controller.error != null) {
              return Center(
                child: Text(controller.error.toString()),
              );
            }

            if (!controller.working) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (Post post in controller.postList)
                      PostCard(
                        post: post,
                        onDelete: () {
                          controller.deletePost(post.id);
                        },
                        onEdit: () {
                          showEditPostFunction(context, post);
                        },
                      ),
                  ],
                ),
              );
            }
            return const Center(
              child: SpinKitChasingDots(
                size: 54,
                color: Color(0xFF00BF62),
              ),
            );
          },
        ),
      ),
    );
  }

  void showNewPostFunction(BuildContext context) {
    AddPostDialog.show(
      context,
      controller: Provider.of<PostController>(context, listen: false),
    );
  }

  void showEditPostFunction(BuildContext context, Post post) async {
    final updatedPost = await EditPostDialog.show(
      context,
      post: post,
      controller: Provider.of<PostController>(context, listen: false),
    );
    if (updatedPost != null) {
      setState(() {
        // Handle post update in the UI if needed
      });
    }
  }
}

void logout(BuildContext context) {
  AuthController.instance.logout();
  GlobalRouter.instance.logout(context);
}

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const PostCard({Key? key, required this.post, required this.onDelete, required this.onEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PostDetailsScreen(post: post),
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF00BF62), width: 2),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
            IconButton(onPressed: onDelete, icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}

class AddPostDialog extends StatefulWidget {
  static show(BuildContext context, {required PostController controller}) =>
      showDialog(
        context: context,
        builder: (dContext) => AddPostDialog(controller),
      );

  const AddPostDialog(this.controller, {Key? key}) : super(key: key);

  final PostController controller;

  @override
  State<AddPostDialog> createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
  late TextEditingController bodyC, titleC;

  @override
  void initState() {
    super.initState();
    bodyC = TextEditingController();
    titleC = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      title: const Text(
        "Add new post",
        style: TextStyle(color: Color(0xFF00BF62)),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await widget.controller.makePost(
              title: titleC.text.trim(),
              body: bodyC.text.trim(),
              userId: 1,
            );
            Navigator.of(context).pop();
          },
          child: const Text("Submit"),
        )
      ],
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: titleC,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: bodyC,
              decoration: const InputDecoration(labelText: "Body"),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    bodyC.dispose();
    titleC.dispose();
    super.dispose();
  }
}

class EditPostDialog extends StatefulWidget {
  static Future<Post?> show(BuildContext context,
          {required Post post, required PostController controller}) =>
      showDialog(
        context: context,
        builder: (dContext) => EditPostDialog(post, controller),
      );

  const EditPostDialog(this.post, this.controller, {Key? key}) : super(key: key);

  final Post post;
  final PostController controller;

  @override
  State<EditPostDialog> createState() => _EditPostDialogState();
}

class _EditPostDialogState extends State<EditPostDialog> {
  late TextEditingController bodyC, titleC;

  @override
  void initState() {
    super.initState();
    bodyC = TextEditingController(text: widget.post.body);
    titleC = TextEditingController(text: widget.post.title);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      title: const Text(
        "Edit Post",
        style: TextStyle(color: Color(0xFF00BF62)),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await widget.controller.updatePost(
              Post(
                id: widget.post.id,
                title: titleC.text.trim(),
                body: bodyC.text.trim(),
                userId: widget.post.userId,
              ),
            );
            Navigator.of(context).pop();
          },
          child: const Text("Save"),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Title"),
          TextFormField(
            controller: titleC,
          ),
          const SizedBox(height: 8),
          const Text("Content"),
          TextFormField(
            controller: bodyC,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    bodyC.dispose();
    titleC.dispose();
    super.dispose();
  }
}

class PostDetailsScreen extends StatefulWidget {
  final Post post;

  const PostDetailsScreen({required this.post, super.key});

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  late Post _post;

  @override
  void initState() {
    super.initState();
    _post = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_post.title),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Color(0xFF00BF62),
            ),
            onPressed: () => showEditPostFunction(context, _post),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Text(_post.body),
        ),
      ),
    );
  }

  showEditPostFunction(BuildContext context, Post post) async {
    final updatedPost = await EditPostDialog.show(
      context,
      post: post,
      controller: Provider.of<PostController>(context, listen: false),
    );
    if (updatedPost != null) {
      setState(() {
        _post = updatedPost;
      });
    }
  }
}

//added update, and delete post
class PostController with ChangeNotifier {
  int userId = 1;
  Box<Post> _postBox = Hive.box<Post>('posts');
  bool working = false;
  Object? error;

  List<Post> get postList => _postBox.values.toList();

  Future<void> loadHivePosts() async {
    notifyListeners();
  }

  Future<void> makePost({required String title, required String body, required int userId}) async {
    try {
      working = true;
      notifyListeners();

      // Create new post with unique ID
      int newId = (_postBox.keys.isNotEmpty ? _postBox.keys.last + 1 : 1) as int;

      Post newPost = Post(
        id: newId,
        title: title,
        body: body,
        userId: userId,
      );

      _postBox.put(newId, newPost);
      working = false;
      notifyListeners();
    } catch (e, st) {
      print(e);
      print(st);
      error = e;
      working = false;
      notifyListeners();
    }
  }

  Future<void> updatePost(Post updatedPost) async {
    try {
      working = true;
      notifyListeners();

      _postBox.put(updatedPost.id, updatedPost);
      working = false;
      notifyListeners();
    } catch (e) {
      error = e;
      working = false;
      notifyListeners();
    }
  }

  Future<void> deletePost(int id) async {
    try {
      working = true;
      notifyListeners();

      _postBox.delete(id);
      working = false;
      notifyListeners();
    } catch (e, st) {
      print(e);
      print(st);
      error = e;
      working = false;
      notifyListeners();
    }
  }

  void clear() {
    _postBox.clear();
    notifyListeners();
  }
}


// class UserController with ChangeNotifier {
//   Map<String, dynamic> users = {};
//   bool working = true;
//   Object? error;

//   List<User> get userList => users.values.whereType<User>().toList();

//   getUsers() async {
//     try {
//       working = true;
//       List result = [];
//       http.Response res = await HttpService.get(
//           url: "https://jsonplaceholder.typicode.com/users");
//       if (res.statusCode != 200 && res.statusCode != 201) {
//         throw Exception("${res.statusCode} | ${res.body}");
//       }
//       result = jsonDecode(res.body);

//       List<User> tmpUser = result.map((e) => User.fromJson(e)).toList();
//       users = {for (User u in tmpUser) "${u.id}": u};
//       working = false;
//       notifyListeners();
//     } catch (e, st) {
//       print(e);
//       print(st);
//       error = e;
//       working = false;
//       notifyListeners();
//     }
//   }

//   clear() {
//     users = {};
//     notifyListeners();
//   }
// }

//added put and delete service
// class HttpService {
//   static Future<http.Response> get(
//       {required String url, Map<String, dynamic>? headers}) async {
//     Uri uri = Uri.parse(url);
//     return http.get(uri, headers: {
//       'Content-Type': 'application/json',
//       if (headers != null) ...headers
//     });
//   }

//   static Future<http.Response> post(
//       {required String url,
//       required Map<dynamic, dynamic> body,
//       Map<String, dynamic>? headers}) async {
//     Uri uri = Uri.parse(url);
//     return http.post(uri, body: jsonEncode(body), headers: {
//       'Content-Type': 'application/json',
//       if (headers != null) ...headers
//     });
//   }

//   static Future<http.Response> put(
//       {required String url,
//       required Map<dynamic, dynamic> body,
//       Map<String, dynamic>? headers}) async {
//     Uri uri = Uri.parse(url);
//     return http.put(uri, body: jsonEncode(body), headers: {
//       'Content-Type': 'application/json',
//       if (headers != null) ...headers,
//     });
//   }

//   static Future<http.Response> delete(
//       {required String url, Map<String, dynamic>? headers}) async {
//     Uri uri = Uri.parse(url);
//     return http.delete(uri, headers: {
//       'Content-Type': 'application/json',
//       if (headers != null) ...headers,
//     });
//   }
// }

// class PostDetailsScreen extends StatefulWidget {
//   final Post post;

//   const PostDetailsScreen({required this.post, super.key});

//   @override
//   _PostDetailsScreenState createState() => _PostDetailsScreenState();
// }

// class _PostDetailsScreenState extends State<PostDetailsScreen> {
//   late Post _post;

//   @override
//   void initState() {
//     super.initState();
//     _post = widget.post;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_post.title),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.edit,
//               color: Color(0xFF00BF62),
//             ),
//             onPressed: () => showEditPostFunction(context, _post),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: SingleChildScrollView(
//           child: Text(_post.body),
//         ),
//       ),
//     );
//   }

//   showEditPostFunction(BuildContext context, Post post) async {
//     final updatedPost = await EditPostDialog.show(
//       context,
//       post: post,
//       controller: Provider.of<PostController>(context, listen: false),
//     );
//     if (updatedPost != null) {
//       setState(() {
//         _post = updatedPost;
//       });
//     }
//   }
// }

// class EditPostDialog extends StatefulWidget {
//   static Future<Post?> show(BuildContext context,
//           {required Post post, required PostController controller}) =>
//       showDialog(
//         context: context,
//         builder: (dContext) => EditPostDialog(post, controller),
//       );

//   const EditPostDialog(this.post, this.controller, {super.key});

//   final Post post;
//   final PostController controller;

//   @override
//   State<EditPostDialog> createState() => _EditPostDialogState();
// }

// class _EditPostDialogState extends State<EditPostDialog> {
//   late TextEditingController bodyC, titleC;

//   @override
//   void initState() {
//     super.initState();
//     bodyC = TextEditingController(text: widget.post.body);
//     titleC = TextEditingController(text: widget.post.title);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//       title: const Text(
//         "Edit Post",
//         style: TextStyle(color: Color(0xFF00BF62)),
//       ),
//       actions: [
//         ElevatedButton(
//           onPressed: () async {
//             await widget.controller.updatePost(
//               id: widget.post.id,
//               title: titleC.text.trim(),
//               body: bodyC.text.trim(),
//               userId: widget.post.userId,
//             );
//             Navigator.of(context).pop(Post(
//               id: widget.post.id,
//               title: titleC.text.trim(),
//               body: bodyC.text.trim(),
//               userId: widget.post.userId,
//             ));
//           },
//           child: const Text("Save"),
//         ),
//       ],
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("Title"),
//           TextFormField(
//             controller: titleC,
//           ),
//           const SizedBox(height: 8),
//           const Text("Content"),
//           TextFormField(
//             controller: bodyC,
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     bodyC.dispose();
//     titleC.dispose();
//     super.dispose();
//   }
// }