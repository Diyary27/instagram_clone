import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _descriptionController.clear();
    super.dispose();
  }

  // select image dialogue box
  selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create a post"),
            contentPadding: EdgeInsets.all(20),
            children: [
              SimpleDialogOption(
                child: Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                child: Text("Select from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SizedBox(height: 12),
              SimpleDialogOption(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  // save post content
  postImage() async {
    setState(() {
      _isLoading = true;
    });

    final String res = await FireStoreMethods().uploadPost(
      description: _descriptionController.text,
      image: _file!,
    );

    if (res == "Success") {
      _file = null;
      _descriptionController.clear();
      showSnackBar(context, "Posted Successfully!");
    } else {
      showSnackBar(context, res);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Center(
            child: IconButton(
                onPressed: () => selectImage(context),
                icon: Icon(
                  Icons.upload,
                )),
          )
        : Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.arrow_back),
              title: Text("post to"),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: postImage,
                  child: Text(
                    "post",
                    style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              backgroundColor: mobileBackgroundColor,
            ),
            body: Column(
              children: [
                _isLoading ? LinearProgressIndicator() : Container(),
                SizedBox(width: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          hintText: 'Write a caption...',
                          border: InputBorder.none,
                        ),
                        // maxLines: 4,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
