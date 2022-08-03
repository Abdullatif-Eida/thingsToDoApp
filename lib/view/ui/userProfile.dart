import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thingstodoapp/models/tasks_model.dart';
import 'package:thingstodoapp/view/shared/accordion.dart';
import 'package:thingstodoapp/view/shared/textfield_container.dart';
import 'package:thingstodoapp/view/ui/notifications.dart';
import 'package:thingstodoapp/view/ui/taskDetails.dart';

import '../../services/utils.dart';

class UserProfile extends StatefulWidget {
  final bool isView;
  final Map userProfile;
  const UserProfile({Key? key, required this.isView, required this.userProfile})
      : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _searchController = TextEditingController();
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    getEvents();
  }

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
    }
  }

  Map<DateTime, dynamic> map = {};
  getEvents() async {
    var data = dailyTasks;
    List<Event> eventList = [];

    for (int i = 0; i < data.length; i++) {
      if (data[i]['publisherName'] == widget.userProfile["publisherName"]) {
        var time = DateTime.parse(data[i]['date']);
        var title = data[i]['name'];
        map[time] = [title];
      }
    }

    print(map);
  }

  List _getEventsForDay(DateTime day) {
    final events = LinkedHashMap(equals: isSameDay, hashCode: getHashCode)
      ..addAll(map);
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF6035D0),
        title: const Text('User Profile'),
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
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Center(
              child: CircleAvatar(
                radius: 53,
                backgroundColor: Theme.of(context).primaryColor,
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.isView == true
                        ? widget.userProfile["publisherImage"]
                        : "https://media-exp1.licdn.com/dms/image/C4D03AQG2XQsjB_juKA/profile-displayphoto-shrink_100_100/0/1644853536737?e=1665014400&v=beta&t=6OjQaqnspuF_7xJgT9N4OWrAvFeXrUPPDdPymnoEamE")),
              ),
            ),
            const SizedBox(height: 25),
            TextFieldContainer(
                initialValue: widget.isView == true
                    ? widget.userProfile["publisherName"]
                    : "Abdullatif Eida",
                hintText: widget.isView == true
                    ? widget.userProfile["publisherName"]
                    : "Abdullatif Eida",
                hintTextColor: Colors.black,
                fillcolor: Colors.white,
                suffixIcon: const Padding(padding: EdgeInsets.all(25)),
                border: true,
                errorMsg: "",
                keyboardType: TextInputType.name,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return '';
                  }

                  return null;
                }),
            TextFieldContainer(
                initialValue: widget.isView == true
                    ? widget.userProfile["publisherGender"]
                    : "Male",
                hintText: widget.isView == true
                    ? widget.userProfile["publisherGender"]
                    : "Male",
                hintTextColor: Colors.black,
                fillcolor: Colors.white,
                suffixIcon: const Padding(padding: EdgeInsets.all(25)),
                border: true,
                errorMsg: "",
                keyboardType: TextInputType.name,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return '';
                  }

                  return null;
                }),
            TextFieldContainer(
                initialValue: widget.isView == true
                    ? widget.userProfile["phone1"]
                    : "05057064735",
                hintText: widget.isView == true
                    ? widget.userProfile["phone1"]
                    : "05057064735",
                hintTextColor: Colors.black,
                fillcolor: Colors.white,
                suffixIcon: const Padding(padding: EdgeInsets.all(25)),
                border: true,
                errorMsg: "",
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return '';
                  }

                  return null;
                }),
            TextFieldContainer(
                initialValue: widget.isView == true
                    ? widget.userProfile["country"]
                    : "Turkey",
                hintText: widget.isView == true
                    ? widget.userProfile["country"]
                    : "Turkey",
                suffixIcon: const Padding(padding: EdgeInsets.all(25)),
                hintTextColor: Colors.black,
                fillcolor: Colors.white,
                border: true,
                errorMsg: "",
                keyboardType: TextInputType.name,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return '';
                  }

                  return null;
                }),
            const SizedBox(height: 45),
            if (widget.isView == false)
              Column(
                children: [
                  Accordion(
                    title: Container(
                      width: double.infinity,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "My Tasks",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            Icon(Icons.arrow_drop_down_sharp)
                          ],
                        ),
                      ),
                    ),
                    content: Column(
                      children: [
                        Container(
                          width: double.infinity,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "My Tasks",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Icon(Icons.arrow_left_outlined)
                              ],
                            ),
                          ),
                        ),
                        dailyTasks
                                .where((element) =>
                                    element["publisherName"] ==
                                    "Abdullatif Eida")
                                .isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Text("No Items"),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    for (var dailyTask in dailyTasks.where(
                                        (element) =>
                                            element["publisherName"] ==
                                            "Abdullatif Eida"))
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(dailyTask["time"]),
                                                      const SizedBox(height: 5),
                                                      GestureDetector(
                                                        child: CircleAvatar(
                                                          radius: 12,
                                                          backgroundColor:
                                                              const Color(
                                                                  0XFF6035D0),
                                                          child: CircleAvatar(
                                                            radius: 10,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    dailyTask[
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        child: Text(
                                                          dailyTask["name"],
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                                favoriteTasks.add(
                                                                    dailyTask);
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
                                                            dailyTask[
                                                                    "isFavorite"]
                                                                ? Icons.star
                                                                : Icons
                                                                    .star_border,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                255,
                                                                230,
                                                                0),
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
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TaskDetails(
                                                          itemName:
                                                              dailyTask["name"],
                                                          itemDate:
                                                              dailyTask["date"],
                                                          itemTime:
                                                              dailyTask["time"],
                                                          itemDescription:
                                                              dailyTask[
                                                                  "description"],
                                                          itemCategory:
                                                              dailyTask[
                                                                  "category"],
                                                          itemAddress:
                                                              dailyTask[
                                                                  "address"],
                                                          itemLocation:
                                                              dailyTask[
                                                                  "location"],
                                                          itemContactName:
                                                              dailyTask[
                                                                  "conatct_name"],
                                                          itemTypeName:
                                                              dailyTask[
                                                                  "item_type"],
                                                          itemImage: dailyTask[
                                                              "image"],
                                                          id: dailyTask["guid"],
                                                          dailyTaskMap:
                                                              dailyTask,
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
                  Accordion(
                    title: Container(
                      width: double.infinity,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "My Favorites",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            Icon(Icons.arrow_drop_down_sharp)
                          ],
                        ),
                      ),
                    ),
                    content: Column(
                      children: [
                        Container(
                          width: double.infinity,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "My Favorites",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Icon(Icons.arrow_left_outlined)
                              ],
                            ),
                          ),
                        ),
                        favoriteTasks.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Text("No Items"),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    for (var dailyTask in favoriteTasks)
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(dailyTask["time"]),
                                                      const SizedBox(height: 5),
                                                      GestureDetector(
                                                        child: CircleAvatar(
                                                          radius: 12,
                                                          backgroundColor:
                                                              const Color(
                                                                  0XFF6035D0),
                                                          child: CircleAvatar(
                                                            radius: 10,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    dailyTask[
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        child: Text(
                                                          dailyTask["name"],
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                                favoriteTasks.add(
                                                                    dailyTask);
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
                                                            dailyTask[
                                                                    "isFavorite"]
                                                                ? Icons.star
                                                                : Icons
                                                                    .star_border,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                255,
                                                                230,
                                                                0),
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
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TaskDetails(
                                                          itemName:
                                                              dailyTask["name"],
                                                          itemDate:
                                                              dailyTask["date"],
                                                          itemTime:
                                                              dailyTask["time"],
                                                          itemDescription:
                                                              dailyTask[
                                                                  "description"],
                                                          itemCategory:
                                                              dailyTask[
                                                                  "category"],
                                                          itemAddress:
                                                              dailyTask[
                                                                  "address"],
                                                          itemLocation:
                                                              dailyTask[
                                                                  "location"],
                                                          itemContactName:
                                                              dailyTask[
                                                                  "conatct_name"],
                                                          itemTypeName:
                                                              dailyTask[
                                                                  "item_type"],
                                                          itemImage: dailyTask[
                                                              "image"],
                                                          id: dailyTask["guid"],
                                                          dailyTaskMap:
                                                              dailyTask,
                                                        )));
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            if (widget.isView == true)
              Accordion(
                title: Container(
                  width: double.infinity,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.userProfile["publisherName"]} Tasks",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Icon(Icons.arrow_drop_down_sharp)
                      ],
                    ),
                  ),
                ),
                content: Column(
                  children: [
                    Container(
                      width: double.infinity,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.userProfile["publisherName"]} Tasks",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            Icon(Icons.arrow_left_outlined)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            width: 0,
                            color: Colors.red,
                          )),
                      child: TableCalendar(
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        rangeStartDay: _rangeStart,
                        rangeEndDay: _rangeEnd,
                        eventLoader: (day) {
                          return _getEventsForDay(day);
                        },
                        calendarFormat: CalendarFormat.month,
                        rangeSelectionMode: RangeSelectionMode.disabled,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        calendarStyle: CalendarStyle(
                          isTodayHighlighted: false,
                          rowDecoration: BoxDecoration(
                              border: Border.all(
                                  width: 0, color: Colors.transparent)),
                          markerDecoration: BoxDecoration(
                              color: Colors.orange, shape: BoxShape.circle),
                          selectedDecoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          selectedTextStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        headerStyle: const HeaderStyle(
                          titleCentered: true,
                          formatButtonVisible: false,
                          titleTextStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        onDaySelected: _onDaySelected,
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    dailyTasks
                            .where((element) =>
                                element["date"].toString().split(" ")[0] ==
                                    _selectedDay.toString().split(" ")[0] &&
                                element['publisherName'] ==
                                    widget.userProfile["publisherName"])
                            .isEmpty
                        ? Text("No Items")
                        : Column(
                            children: [
                              for (var dailyTask in dailyTasks.where(
                                  (element) =>
                                      element["date"]
                                              .toString()
                                              .split(" ")[0] ==
                                          _selectedDay
                                              .toString()
                                              .split(" ")[0] &&
                                      element['publisherName'] ==
                                          widget.userProfile["publisherName"]))
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: GestureDetector(
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(dailyTask["time"]),
                                                    const SizedBox(height: 5),
                                                    GestureDetector(
                                                      child: CircleAvatar(
                                                        radius: 12,
                                                        backgroundColor:
                                                            const Color(
                                                                0XFF6035D0),
                                                        child: CircleAvatar(
                                                          radius: 10,
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  dailyTask[
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 200,
                                                      child: Text(
                                                        dailyTask["name"],
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                              favoriteTasks.add(
                                                                  dailyTask);
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
                                                          dailyTask[
                                                                  "isFavorite"]
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_border,
                                                          color: const Color
                                                                  .fromARGB(
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
                                                    itemDescription: dailyTask[
                                                        "description"],
                                                    itemCategory:
                                                        dailyTask["category"],
                                                    itemAddress:
                                                        dailyTask["address"],
                                                    itemLocation:
                                                        dailyTask["location"],
                                                    itemContactName: dailyTask[
                                                        "conatct_name"],
                                                    itemTypeName:
                                                        dailyTask["item_type"],
                                                    itemImage:
                                                        dailyTask["image"],
                                                    id: dailyTask["guid"],
                                                    dailyTaskMap: dailyTask,
                                                  )));
                                    },
                                  ),
                                ),
                            ],
                          ),
                  ],
                ),
              ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }
}
