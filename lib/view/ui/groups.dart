import 'package:flutter/material.dart';
import 'package:thingstodoapp/models/groups_model.dart';
import 'package:thingstodoapp/view/shared/textfield_container.dart';
import 'package:thingstodoapp/view/ui/newGroup.dart';
import 'package:thingstodoapp/view/ui/notifications.dart';

import 'addNewTask.dart';

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF6035D0),
        title: const Text("Groups"),
        actions: [
          GestureDetector(
            child: const Icon(
              Icons.notifications_active_outlined,
              size: 30,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Notifications()));
            },
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NewGroup()));
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              )),
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
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(groups.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[400]!,
                            blurRadius: 5.0,
                            offset: const Offset(0, 0),
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            groups[index]["image"],
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: 130,
                          ),
                          Text(groups[index]["company"]),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: groups[index]["company"] !=
                                      "Abdullatif family group"
                                  ? Color(0XFF6035D0)
                                  : Colors.green,
                            ),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                groups[index]["company"] ==
                                        "Abdullatif family group"
                                    ? "Joined"
                                    : "Join",
                                style: const TextStyle(color: Colors.white),
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
