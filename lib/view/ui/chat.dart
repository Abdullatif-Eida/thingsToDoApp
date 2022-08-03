import 'package:flutter/material.dart';
import 'package:thingstodoapp/models/groups_model.dart';
import 'package:thingstodoapp/models/users_model.dart';
import 'package:thingstodoapp/view/shared/textfield_container.dart';
import 'package:thingstodoapp/view/ui/chating.dart';
import 'package:thingstodoapp/view/ui/notifications.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF6035D0),
        title: const Text('Chat'),
        actions: [
          GestureDetector(
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Notifications()));
              },
              icon: const Icon(
                Icons.notifications_active_outlined,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            color: const Color(0XFF6035D0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFieldContainer(
                hintText: "Search Task",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/search.png?alt=media&token=a1caee7a-d469-4034-88ed-2637094fd863",
                    height: 25,
                    width: 25,
                  ),
                ),
                errorMsg: "",
                keyboardType: TextInputType.name,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400]!,
                    blurRadius: 0.5,
                    offset: const Offset(0, 0),
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                      "Groups",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var group in groups)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          NetworkImage(group["image"])),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Expanded(
                child: ListView(
                  children: [
                    for (var user in users)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[400]!,
                                blurRadius: 0.5,
                                offset: const Offset(0, 0),
                                spreadRadius: 0.5,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            const Color(0XFF6035D0),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage:
                                              NetworkImage(user["url"]),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Chating(
                                                      user: user,
                                                    )));
                                      },
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 200,
                                          child: Text(
                                            user["name"],
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          user["lastOnline"],
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Chating(
                                                            user: user,
                                                          )));
                                            },
                                            icon: Icon(
                                              Icons.chat,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
