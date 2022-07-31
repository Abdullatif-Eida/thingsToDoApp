import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thingstodoapp/models/tasks_model.dart';
import 'package:thingstodoapp/view/ui/addNewTask.dart';
import 'package:thingstodoapp/view/ui/homePage.dart';

class TaskDetails extends StatefulWidget {
  final String itemName;
  final String itemDate;
  final String itemTime;
  final String itemDescription;
  final String itemCategory;
  final String itemAddress;
  final String itemLocation;
  final String itemContactName;
  final String itemTypeName;
  final String itemImage;
  final String id;
  final Map dailyTaskMap;
  const TaskDetails({
    Key? key,
    required this.itemName,
    required this.itemDate,
    required this.itemTime,
    required this.itemDescription,
    required this.itemCategory,
    required this.itemAddress,
    required this.itemLocation,
    required this.itemContactName,
    required this.itemTypeName,
    required this.itemImage,
    required this.id,
    required this.dailyTaskMap,
  }) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF6F6F8),
      bottomSheet: widget.dailyTaskMap["publisherName"] == "Abdullatif Eida"
          ? Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              dailyTasks.removeWhere(
                                  (element) => element["guid"] == widget.id);
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("The item has been deleted",
                                  style: TextStyle(fontFamily: "Almarai")),
                            ));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.grey,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddNewTask(
                                        dailyTaskMap: widget.dailyTaskMap,
                                        isEdit: true)));
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.grey,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              dailyTasks.removeWhere(
                                  (element) => element["guid"] == widget.id);
                              laterTasks.add(widget.dailyTaskMap);
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "The item has been added to later list",
                                  style: TextStyle(fontFamily: "Almarai")),
                            ));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          },
                          icon: const Icon(
                            Icons.history,
                            color: Colors.grey,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              dailyTasks.removeWhere(
                                  (element) => element["guid"] == widget.id);
                              doneTasks.add(widget.dailyTaskMap);
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "The item has been added to done list",
                                  style: TextStyle(fontFamily: "Almarai")),
                            ));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          },
                          icon: const Icon(
                            Icons.check_box_outlined,
                            color: Colors.grey,
                            size: 30,
                          )),
                    ]),
              ),
            )
          : null,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF6035D0),
        title: const Text('Item Details'),
        actions: [
          const Icon(
            Icons.notifications_active_outlined,
            size: 30,
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNewTask(
                              dailyTaskMap: widget.dailyTaskMap,
                              isEdit: true,
                            )));
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
          Stack(
            children: [
              Positioned(
                child: Container(
                  padding: const EdgeInsets.all(55),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            widget.itemName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${DateFormat.yMMMMd().format(DateTime.parse(widget.itemDate))} | ${widget.itemTime}",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[500]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.itemDescription,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Category: ${widget.itemCategory}"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Address: ${widget.itemAddress}"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Location: ${widget.itemLocation}"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Contact Name: ${widget.itemContactName}"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Item Type: ${widget.itemTypeName}"),
                          const SizedBox(
                            height: 140,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 53,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    widget.itemImage.contains("200x200")
                                        ? NetworkImage(widget.itemImage)
                                            as ImageProvider
                                        : FileImage(
                                            File(widget.itemImage),
                                          ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
