import 'package:flutter/material.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';

class UserChatTile extends StatelessWidget {
  final ImageProvider userImage; // user avatar
  final Widget userName; // user name
  final Widget lastMessage; // last message sent by friend
  final int unseenMessgae; // number of unseen messages
  final double userImageHeight; // user image height
  final double userImageWidget; // user image width
  final Widget lastSeen;

  UserChatTile(
      {Key key,
        @required this.userImage,
        @required this.userName,
        @required this.lastMessage,
        @required this.lastSeen,
        this.unseenMessgae = 0,
        this.userImageHeight = 50,
        this.userImageWidget = 50})
      : super(key: key) {
    assert(this.userName != null, "username can't be null");
    assert(this.userImage != null, "userImage can't be null");
    assert(this.lastMessage != null, "lastMessage can't be null");
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        leading: Container(
          height: this.userImageHeight,
          width: this.userImageWidget,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(212, 212, 212, 1),
              image: DecorationImage(image: this.userImage)),
        ),
        title: this.userName,
        subtitle: this.lastMessage,
        trailing: Column(
          children: [
            lastSeen,
            SizedBox(
              height: 10,
            ),
            /*Container(
              alignment: Alignment.center,
              height: 27,
              width: 27,
              decoration: BoxDecoration(
                  color: baseColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                this.unseenMessgae.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),*/
          ],
        )
    );
  }
}
