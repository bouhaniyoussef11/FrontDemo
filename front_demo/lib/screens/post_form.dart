import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constant.dart';
import '../models/api_response.dart';
import '../models/post.dart';
import '../services/post_service.dart';
import '../services/user_service.dart';
import 'login_page.dart';

class PostForm extends StatefulWidget {
  final Post? post;
  final String? title;

  const PostForm({super.key, this.post, this.title});

  @override
  // _PostFormState createState() => _PostFormState();
  State<StatefulWidget> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtControllerdescription =
      TextEditingController();
  final TextEditingController _txtControllerTitle = TextEditingController();
  bool _loading = false;
  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _createPost() async {
    String? image = _imageFile == null ? null : getStringImage(_imageFile);
    ApiResponse response = await createPost(
        _txtControllerdescription.text, _txtControllerTitle.text, image);

    if (response.error == null) {
      if (!mounted) return;
      Navigator.of(context).pop();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false)
          });
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        _loading = !_loading;
      });
    }
  }

  // edit post
  void _editPost(int postId) async {
    ApiResponse response =
        await editPost(postId, _txtControllerdescription.text);
    if (response.error == null) {
      if (!mounted) return;
      Navigator.of(context).pop();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false)
          });
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        _loading = !_loading;
      });
    }
  }

  @override
  void initState() {
    if (widget.post != null) {
      _txtControllerdescription.text = widget.post!.description ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                widget.post != null
                    ? const SizedBox()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            image: _imageFile == null
                                ? null
                                : DecorationImage(
                                    image: FileImage(_imageFile ?? File('')),
                                    fit: BoxFit.cover)),
                        child: Center(
                          child: IconButton(
                            icon: const Icon(Icons.image,
                                size: 50, color: Colors.black38),
                            onPressed: () {
                              getImage();
                            },
                          ),
                        ),
                      ),
                Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    children: [
                      TextFormField(
                        controller: _txtControllerTitle,
                        keyboardType: TextInputType.name,
                        validator: (val) =>
                            val!.isEmpty ? 'Post body is required' : null,
                        decoration: const InputDecoration(
                            hintText: "Post body...",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black38))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _txtControllerdescription,
                        keyboardType: TextInputType.multiline,
                        maxLines: 9,
                        validator: (val) =>
                            val!.isEmpty ? 'Post body is required' : null,
                        decoration: const InputDecoration(
                            hintText: "Post body...",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black38))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: kTextButton('Post', () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _loading = !_loading;
                      });
                      if (widget.post == null) {
                        _createPost();
                      } else {
                        _editPost(widget.post!.id ?? 0);
                      }
                    }
                  }),
                )
              ],
            ),
    );
  }
}
