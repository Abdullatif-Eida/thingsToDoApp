import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thingstodoapp/models/notifications_model.dart';
import 'package:thingstodoapp/models/tasks_model.dart';
import 'package:thingstodoapp/view/ui/taskDetails.dart';

import 'addNewTask.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _LaterTasksState();
}

class _LaterTasksState extends State<Notifications> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        notifications.add({
          "guid": "87323EE8-3F24-6378-56D6-B81AA7415242",
          "name": "Ali completed Call Mom",
          "phone": "(301) 513-8928",
          "time": "2:23 PM",
          "category": "Friend",
          "Priority": "orange",
          "isFavorite": false,
          "publisherName": "Jarrod Alvarez",
          "publisherGender": "Male",
          "phone1": "(309) 537-4939",
          "country": "United Kingdom",
          "date": "2022-08-26 20:21:20",
          "description":
              "cursus in, hendrerit consectetuer, cursus et, magna. Praesent interdum ligula eu enim. Etiam imperdiet dictum magna. Ut",
          "item_type": "Task",
          "address": "278-8026 Bibendum Rd.",
          "location": "Ap #511-3706 Ullamcorper Rd.",
          "conatct_name": "Justina Rosa",
          "publisherImage": "https://source.unsplash.com/random/200x200?sig=13",
          "image": "https://source.unsplash.com/random/200x200?sig=13"
        });
      });
    });
    Future.delayed(const Duration(seconds: 20), () {
      setState(() {
        notifications.add({
          "guid": "87323EE8-3F24-6378-56D6-B81AA7415242",
          "name": "A task has been moved",
          "phone": "(301) 513-8928",
          "time": "1:13 AM",
          "category": "Friend",
          "Priority": "orange",
          "isFavorite": false,
          "publisherName": "Jarrod Alvarez",
          "publisherGender": "Male",
          "phone1": "(309) 537-4939",
          "country": "United Kingdom",
          "date": "2022-08-26 20:21:20",
          "description":
              "cursus in, hendrerit consectetuer, cursus et, magna. Praesent interdum ligula eu enim. Etiam imperdiet dictum magna. Ut",
          "item_type": "Task",
          "address": "278-8026 Bibendum Rd.",
          "location": "Ap #511-3706 Ullamcorper Rd.",
          "conatct_name": "Justina Rosa",
          "publisherImage": "https://source.unsplash.com/random/200x200?sig=13",
          "image": "https://source.unsplash.com/random/200x200?sig=13"
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF6035D0),
        title: const Text('Notifications Items'),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (notifications.isNotEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 5.0,
                        offset: const Offset(0, 0),
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            for (var dailyTask in notifications)
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Text(dailyTask["time"]),
                                              const SizedBox(height: 5),
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundColor:
                                                    const Color(0XFF6035D0),
                                                child: CircleAvatar(
                                                  radius: 10,
                                                  backgroundImage: NetworkImage(
                                                      dailyTask[
                                                          "publisherImage"]),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: 15),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  dailyTask["name"],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                dailyTask["category"],
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TaskDetails(
                                                  itemName: dailyTask["name"],
                                                  itemDate: dailyTask["date"],
                                                  itemTime: dailyTask["time"],
                                                  itemDescription:
                                                      dailyTask["description"],
                                                  itemCategory:
                                                      dailyTask["category"],
                                                  itemAddress:
                                                      dailyTask["address"],
                                                  itemLocation:
                                                      dailyTask["location"],
                                                  itemContactName:
                                                      dailyTask["conatct_name"],
                                                  itemTypeName:
                                                      dailyTask["item_type"],
                                                  itemImage: dailyTask["image"],
                                                  id: dailyTask["guid"],
                                                  dailyTaskMap: dailyTask,
                                                )));
                                  },
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
          if (notifications.isEmpty)
            Align(
              alignment: Alignment.center,
              child: Text("No Items"),
            )
        ],
      )),
    );
  }
}
