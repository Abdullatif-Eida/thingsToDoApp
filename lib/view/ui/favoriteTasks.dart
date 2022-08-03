import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thingstodoapp/models/tasks_model.dart';
import 'package:thingstodoapp/view/ui/notifications.dart';
import 'package:thingstodoapp/view/ui/taskDetails.dart';
import 'package:thingstodoapp/view/ui/userProfile.dart';

import 'addNewTask.dart';

class FavoriteTasks extends StatefulWidget {
  const FavoriteTasks({Key? key}) : super(key: key);

  @override
  State<FavoriteTasks> createState() => _FavoriteTasksState();
}

class _FavoriteTasksState extends State<FavoriteTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF6035D0),
        title: const Text('Favorite Items'),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddNewTask(
                              dailyTaskMap: {},
                              isEdit: false,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (favoriteTasks.isNotEmpty)
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
                            for (var dailyTask in favoriteTasks)
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  child: Slidable(
                                    key: const ValueKey(0),
                                    startActionPane: ActionPane(
                                      // A motion is a widget used to control how the pane animates.
                                      motion: const ScrollMotion(),

                                      // A pane can dismiss the Slidable.

                                      // All actions are defined in the children parameter.
                                      children: [
                                        // A SlidableAction can have an icon and/or a label.
                                        SlidableAction(
                                          onPressed: (context) {
                                            setState(() {
                                              dailyTasks.removeWhere(
                                                  (element) =>
                                                      element["guid"] ==
                                                      dailyTask["guid"]);
                                              doneTasks.add(dailyTask);
                                            });
                                          },
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                          icon: Icons.paste_outlined,
                                          label: 'Done',
                                        ),
                                      ],
                                    ),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        // A SlidableAction can have an icon and/or a label.
                                        SlidableAction(
                                          onPressed: (context) {
                                            setState(() {
                                              dailyTasks.removeWhere(
                                                  (element) =>
                                                      element["guid"] ==
                                                      dailyTask["guid"]);
                                              laterTasks.add(dailyTask);
                                            });
                                          },
                                          backgroundColor:
                                              const Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.history,
                                          label: 'Later',
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(dailyTask["time"]),
                                                const SizedBox(height: 5),
                                                GestureDetector(
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor:
                                                        const Color(0XFF6035D0),
                                                    child: CircleAvatar(
                                                      radius: 10,
                                                      backgroundImage:
                                                          NetworkImage(dailyTask[
                                                              "publisherImage"]),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    UserProfile(
                                                                      isView:
                                                                          true,
                                                                      userProfile:
                                                                          dailyTask,
                                                                    )));
                                                  },
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 200,
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
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      if (dailyTask[
                                                              "isFavorite"] ==
                                                          false) {
                                                        setState(() {
                                                          favoriteTasks
                                                              .add(dailyTask);
                                                        });
                                                      } else {
                                                        setState(() {
                                                          favoriteTasks.removeWhere(
                                                              (element) =>
                                                                  element[
                                                                      "guid"] ==
                                                                  dailyTask[
                                                                      "guid"]);
                                                        });
                                                      }

                                                      setState(() {
                                                        dailyTask[
                                                                "isFavorite"] =
                                                            !dailyTask[
                                                                "isFavorite"];
                                                      });
                                                    },
                                                    icon: Icon(
                                                      dailyTask["isFavorite"]
                                                          ? Icons.star
                                                          : Icons.star_border,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 255, 230, 0),
                                                      size: 30,
                                                    )),
                                                Image.network(
                                                  dailyTask["Priority"] ==
                                                          "important"
                                                      ? "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/red.png?alt=media&token=e1bc1428-cce3-4c50-8dc1-359f517e996e"
                                                      : dailyTask["Priority"] ==
                                                              "orange"
                                                          ? "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/orange.png?alt=media&token=620f460f-ff2e-434c-936f-ee27e689df55"
                                                          : dailyTask["Priority"] ==
                                                                  "blue"
                                                              ? "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/blue.png?alt=media&token=5ef89bae-a583-41d4-93cb-b84c25aeab9f"
                                                              : "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/green.png?alt=media&token=da123f8c-fc63-40e0-9436-3a4cc0e218c8",
                                                  height: 25,
                                                  width: 25,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
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
          if (favoriteTasks.isEmpty)
            Align(
              alignment: Alignment.center,
              child: Text("No Items"),
            )
        ],
      )),
    );
  }
}
