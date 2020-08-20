import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techexperiment001/constants.dart';

class StoryPanel extends StatelessWidget {
  StoryPanel({@required this.photoURL});
  final String photoURL;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AddStory(
            'https://i.pinimg.com/736x/f3/b4/e0/f3b4e0ee78d97b14a8a11927c59fc4c4.jpg',
          ),
          // Stories(
          //     'https://1.bp.blogspot.com/-imHxVupb2m8/XQMofGdADzI/AAAAAAAAAIY/kYUS486BlF0FDoWX0ltDkpk0nanZj3TVgCLcBGAs/s1600/2001284889634654744.jpg',
          //     'Neha',
          //     true),
          // Stories(
          //     'https://i.pinimg.com/736x/f3/b4/e0/f3b4e0ee78d97b14a8a11927c59fc4c4.jpg',
          //     'Sarvo Bro',
          //     true),
          // Stories(
          //     'https://i.pinimg.com/originals/4c/28/1a/4c281ababcaab1b95f75d9f7f2c62db4.jpg',
          //     'Krushna',
          //     false),
          // Stories(
          //     'https://images.unsplash.com/photo-1569333070762-921e7c0f13ea?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
          //     'Vishal Bro',
          //     false),
          // Stories(
          //     'https://i.pinimg.com/236x/35/d1/92/35d192a38ee4065fef1a2846a41f7518.jpg',
          //     'Chakli',
          //     false),
          // Stories(
          //     'https://www.youngisthan.in/wp-content/uploads/2017/10/indian-mom-1280x720.jpg',
          //     'MOM',
          //     false),
        ],
      ),
    );
  }
}

class AddStory extends StatelessWidget {
  final String imgURL;
  AddStory(
    this.imgURL,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 14.0, 0.0, 4.0),
          child: Container(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: CircleAvatar(
                    radius: 28.0,
                    backgroundImage: NetworkImage(imgURL),
                  ),
                ),
                Positioned(
                  left: 42.0,
                  bottom: 0,
                  child: CircleAvatar(
                    backgroundColor: Color(0xFF1D1B1D),
                    radius: 12.0,
                    child: Container(
                      width: 18.0,
                      height: 18.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: themeColorC,
                      ),
                      child: Icon(
                        FontAwesomeIcons.plus,
                        size: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0, left: 5.0),
          child: Text(
            'Your Story',
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

class Stories extends StatelessWidget {
  final String imgURL, name;
  final bool viewed;
  Stories(this.imgURL, this.name, this.viewed);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 4.0, 5.0),
          child: Container(
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: viewed ? Colors.grey : Colors.blue,
                  radius: 30.0,
                  child: CircleAvatar(
                    radius: 28.0,
                    backgroundImage: NetworkImage(imgURL),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0, left: 5.0),
          child: Text(
            name,
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
