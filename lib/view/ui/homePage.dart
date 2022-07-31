import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thingstodoapp/models/tasks_model.dart';
import 'package:thingstodoapp/services/utils.dart';
import 'package:thingstodoapp/view/shared/drawePage.dart';
import 'package:thingstodoapp/view/shared/textfield_container.dart';
import 'package:thingstodoapp/view/ui/addNewTask.dart';
import 'package:thingstodoapp/view/ui/taskDetails.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  TabController? _tabController;
  @override
  void initState() {
    setState(() {
      _searchResult = dailyTasks;
    });
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController!.addListener(_handleTabIndex);
    getEvents();
  }

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  @override
  void dispose() {
    _tabController!.removeListener(_handleTabIndex);
    _tabController!.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  List _searchResult = [];

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
    var data = _searchResult;
    List<Event> eventList = [];

    for (int i = 0; i < data.length; i++) {
      var time = DateTime.parse(data[i]['date']);
      var title = data[i]['name'];
      map[time] = [title];
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
      backgroundColor: const Color(0XFFF6F6F8),
      drawer: const DrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF6035D0),
        title: Image.network(
          "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/Group%2015.png?alt=media&token=4ae0ccae-842e-4ff7-aaeb-2401a8339706",
          height: 150,
          width: 150,
        ),
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
        children: [
          Container(
            color: const Color(0XFF6035D0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFieldContainer(
                controller: _searchController,
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
          Container(
            decoration: BoxDecoration(
                color: const Color(0XFF6035D0),
                border: Border.all(
                  width: 0,
                  color: const Color(0XFF6035D0),
                )),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: TabBar(
                controller: _tabController,
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                labelStyle: const TextStyle(
                    fontFamily: 'Almarai', fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(
                    text: "DAILY",
                  ),
                  Tab(text: "WEEKLY"),
                  Tab(text: "MONTHLY"),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              Column(
                children: [
                  if (_searchResult.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
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
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Text("Good Morning,"),
                                      Text(" Abdullatif Eida",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "TODAY",
                                    style: TextStyle(
                                        color: Color(0XFF6035D0),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    DateFormat.yMMMMd().format(DateTime.now()),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Completed",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Text(
                                        "${doneTasks.length.toString()} /",
                                        style: const TextStyle(
                                            color: Colors.green),
                                      ),
                                      Text(
                                        dailyTasks
                                            .where((element) =>
                                                element["date"]
                                                    .toString()
                                                    .split(" ")[0] ==
                                                DateTime.now()
                                                    .toString()
                                                    .split(" ")[0])
                                            .length
                                            .toString(),
                                        style:
                                            const TextStyle(color: Colors.red),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  _searchResult.isEmpty
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(38),
                            child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/Content.png?alt=media&token=77393fdb-29d3-4ffd-a74a-eba9d2608702"),
                          ),
                        )
                      : Expanded(
                          child: ListView(
                            children: [
                              for (var dailyTask in _searchResult.where(
                                  (element) =>
                                      element["date"]
                                          .toString()
                                          .split(" ")[0] ==
                                      DateTime.now().toString().split(" ")[0]))
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
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                      backgroundImage:
                                                          NetworkImage(dailyTask[
                                                              "publisherImage"]),
                                                    ),
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
                        ),
                ],
              ),
              Column(
                children: [
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
                      calendarFormat: CalendarFormat.week,
                      rangeSelectionMode: RangeSelectionMode.disabled,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      calendarStyle: const CalendarStyle(
                          outsideDaysVisible: true,
                          isTodayHighlighted: false,
                          withinRangeDecoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          markerDecoration: BoxDecoration(
                              color: Color(0XFF6035D0), shape: BoxShape.circle),
                          outsideDecoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          holidayDecoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          rowDecoration: BoxDecoration(
                            color: Color(0XFF6035D0),
                          ),
                          selectedDecoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          selectedTextStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          todayTextStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          holidayTextStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          outsideTextStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          weekendTextStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          rangeEndTextStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          defaultTextStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      headerStyle: const HeaderStyle(
                        titleCentered: true,
                        rightChevronVisible: false,
                        leftChevronVisible: false,
                        formatButtonVisible: false,
                        decoration: BoxDecoration(
                          color: Color(0XFF6035D0),
                        ),
                        titleTextStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        decoration: const BoxDecoration(
                          color: Color(0XFF6035D0),
                        ),
                        weekdayStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[300],
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[300],
                        ),
                      ),
                      onDaySelected: _onDaySelected,
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _searchResult.isEmpty
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(38),
                            child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/Content.png?alt=media&token=77393fdb-29d3-4ffd-a74a-eba9d2608702"),
                          ),
                        )
                      : Expanded(
                          child: ListView(
                            children: [
                              for (var dailyTask in _searchResult.where(
                                  (element) =>
                                      element["date"]
                                          .toString()
                                          .split(" ")[0] ==
                                      _selectedDay.toString().split(" ")[0]))
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
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                      backgroundImage:
                                                          NetworkImage(dailyTask[
                                                              "publisherImage"]),
                                                    ),
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
                        ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  SizedBox(
                    height: 10,
                  ),
                  _searchResult.isEmpty
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(38),
                            child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/Content.png?alt=media&token=77393fdb-29d3-4ffd-a74a-eba9d2608702"),
                          ),
                        )
                      : Expanded(
                          child: ListView(
                            children: [
                              for (var dailyTask in _searchResult.where(
                                  (element) =>
                                      element["date"]
                                          .toString()
                                          .split(" ")[0] ==
                                      _selectedDay.toString().split(" ")[0]))
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
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                                      CircleAvatar(
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
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                        ),
                ],
              ),
            ]),
          ),
        ],
      )),
    );
  }
}
