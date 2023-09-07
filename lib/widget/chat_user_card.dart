import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/chat_user.dart';

late Size mediaQuery;

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    // mediaQuery = MediaQuery.of(context).size;

    return Card(
      // color: Colors.blue.shade100,
      margin: EdgeInsets.fromLTRB(12, 4, 12, 4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 1,
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: CircleAvatar(child: Icon(CupertinoIcons.person)),
          title: Text(widget.user.name),
          subtitle: Text(widget.user.about, maxLines: 1),
          trailing: Text(
            widget.user.lastActive,
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
