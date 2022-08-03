import 'package:flutter/material.dart';
import 'package:thingstodoapp/models/chat_model.dart';
import 'package:thingstodoapp/models/users_model.dart';

class Chating extends StatefulWidget {
  final Map user;
  const Chating({Key? key, required this.user}) : super(key: key);

  @override
  State<Chating> createState() => _ChatingState();
}

class _ChatingState extends State<Chating> {
  String userStatus = "";
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];
  @override
  void initState() {
    setState(() {
      userStatus = widget.user["lastOnline"];
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            userStatus = "Online Now";
          });
        }
      });
    });
    super.initState();
  }

  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF6035D0),
        title: Text("${widget.user["name"]} ($userStatus)"),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: messages.length,
              padding: EdgeInsets.only(top: 10, bottom: 100),
              itemBuilder: (context, index) {
                return messages[index].messageType == "receiver"
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        "https://media-exp1.licdn.com/dms/image/C4D03AQG2XQsjB_juKA/profile-displayphoto-shrink_100_100/0/1644853536737?e=1665014400&v=beta&t=6OjQaqnspuF_7xJgT9N4OWrAvFeXrUPPDdPymnoEamE")),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: 10, bottom: 10),
                              child: Align(
                                alignment:
                                    (messages[index].messageType == "receiver"
                                        ? Alignment.topLeft
                                        : Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (messages[index].messageType ==
                                            "receiver"
                                        ? Colors.grey.shade200
                                        : Theme.of(context).primaryColor),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    messages[index].messageContent,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: messages[index].messageType ==
                                                "receiver"
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: 10, bottom: 10),
                              child: Align(
                                alignment:
                                    (messages[index].messageType == "receiver"
                                        ? Alignment.topLeft
                                        : Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (messages[index].messageType ==
                                            "receiver"
                                        ? Colors.grey.shade200
                                        : Theme.of(context).primaryColor),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    messages[index].messageContent,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: messages[index].messageType ==
                                                "receiver"
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage(widget.user["url"])),
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 0,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          messages.add(ChatMessage(
                              messageContent: _messageController.text,
                              messageType: "receiver"));
                        });
                        _messageController.clear();
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            userStatus = "Typing...";
                          });
                        });

                        Future.delayed(const Duration(seconds: 10), () {
                          if (mounted) {
                            setState(() {
                              messages.add(ChatMessage(
                                  messageContent: "ok no problem",
                                  messageType: "sender"));
                              userStatus = "Online Now";
                            });
                          }
                        });
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
