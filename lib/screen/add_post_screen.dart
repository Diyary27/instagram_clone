import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("post to"),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/default_profile.png"),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
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
                      image: AssetImage(
                        "assets/default_profile.png",
                      ),
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
