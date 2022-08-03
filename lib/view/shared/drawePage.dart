import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:thingstodoapp/view/ui/DoneTasks.dart';
import 'package:thingstodoapp/view/ui/LaterTasks.dart';
import 'package:thingstodoapp/view/ui/Login%20copy.dart';
import 'package:thingstodoapp/view/ui/addNewTask.dart';
import 'package:thingstodoapp/view/ui/chat.dart';
import 'package:thingstodoapp/view/ui/groups.dart';
import 'package:thingstodoapp/view/ui/userProfile.dart';

import '../ui/favoriteTasks.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 70,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://media-exp1.licdn.com/dms/image/C4D03AQG2XQsjB_juKA/profile-displayphoto-shrink_200_200/0/1644853536737?e=1665014400&v=beta&t=z5-P75FwmP2G5ygf809I3fDMyO184fWCj8Hoc-Y5Ds4"),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserProfile(
                                      isView: false,
                                      userProfile: {},
                                    )));
                      },
                    ),
                    const Text(
                      "Abdullatif Eida",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.add,
                            size: 25,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                          SizedBox(width: 15),
                          Text(
                            "New Task",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddNewTask(
                                    dailyTaskMap: {}, isEdit: false)));
                      },
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.star_border,
                            size: 25,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                          SizedBox(width: 15),
                          Text(
                            "Important",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FavoriteTasks()));
                      },
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.check_box_outlined,
                            size: 25,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                          SizedBox(width: 15),
                          Text(
                            "Done",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DoneTasks()));
                      },
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.history,
                            size: 25,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                          SizedBox(width: 15),
                          Text(
                            "Later",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LaterTasks()));
                      },
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.chat,
                            size: 25,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                          SizedBox(width: 15),
                          Text(
                            "Chat",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Chat()));
                      },
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.groups_rounded,
                            size: 25,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                          SizedBox(width: 15),
                          Text(
                            "Groups",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Groups()));
                      },
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.settings,
                            size: 25,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                          SizedBox(width: 15),
                          Text(
                            "Settings",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {},
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.logout,
                            size: 25,
                            color: Color.fromARGB(255, 85, 85, 85),
                          ),
                          SizedBox(width: 15),
                          Text(
                            "Log out",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 224,
      child: const Divider(
        color: Colors.white,
      ),
    );
  }
}

class drawerItem extends StatelessWidget {
  IconData wantedIcon;
  String itemName;
  Function()? onTap;
  drawerItem(
      {Key? key, required this.wantedIcon, required this.itemName, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0, bottom: 2),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                wantedIcon,
                size: 20,
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                itemName,
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      onTap: onTap ?? () {},
    );
  }
}
