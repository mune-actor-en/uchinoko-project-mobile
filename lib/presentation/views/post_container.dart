import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uchinoko_project_mobile/presentation/views/configuration.dart';

class PostContainer extends StatefulWidget {
  final String postImageUrl;
  final String petImageUrl;
  final String name;
  final String description;

  const PostContainer({
    this.postImageUrl =
        'https://images.pexels.com/photos/669015/pexels-photo-669015.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    this.petImageUrl =
        'https://images.pexels.com/photos/615369/pexels-photo-615369.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    this.name = 'sample name',
    this.description =
        'sample description, this is a shot when we spent in Russia',
  });

  @override
  _PostContainerState createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  bool isFavorite;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  void initState() {
    isFavorite = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        boxShadow: shadowList,
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.petImageUrl),
            ),
            title: Text(widget.name),
          ),
          Container(
            child: Image.network(widget.postImageUrl),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                child: Text(
                  widget.description,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 3
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isFavorite
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: Colors.redAccent,
                      ),
                      onPressed: () => _toggleFavorite(),
                    ),
                    SizedBox(width: 9),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.shareAlt,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text('SNSシェア'),
                              content: Container(
                                height: 200,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        child: Icon(
                                          FontAwesomeIcons.facebookF,
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Color(0xFF3B5998),
                                      ),
                                      title: Text('Facebookにシェア'),
                                      onTap: () => Navigator.pop(context),
                                    ),
                                    ListTile(
                                      leading: CircleAvatar(
                                        child: Icon(
                                          FontAwesomeIcons.instagram,
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Color(0xFFD93177),
                                      ),
                                      title: Text('Instagramにシェア'),
                                      onTap: () => Navigator.pop(context),
                                    ),
                                    ListTile(
                                      leading: CircleAvatar(
                                        child: Icon(
                                          FontAwesomeIcons.twitter,
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Color(0xFF1DA1F2),
                                      ),
                                      title: Text('Twitterにシェア'),
                                      onTap: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'キャンセル',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
