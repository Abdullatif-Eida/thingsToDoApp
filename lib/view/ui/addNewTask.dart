import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:thingstodoapp/models/tasks_model.dart';
import 'package:thingstodoapp/view/shared/textfield_container.dart';
import 'package:thingstodoapp/view/ui/homePage.dart';
import 'package:thingstodoapp/view/ui/notifications.dart';
import 'package:uuid/uuid.dart';

class AddNewTask extends StatefulWidget {
  final Map dailyTaskMap;
  final bool isEdit;
  const AddNewTask({Key? key, required this.dailyTaskMap, required this.isEdit})
      : super(key: key);

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _itemTypeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _notificationsController =
      TextEditingController();
  var uuid = Uuid();
  XFile? _path;
  String selectedPriority = "important";
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.isEdit == true) {
      _itemNameController.text = widget.dailyTaskMap["name"];
      _descriptionController.text = widget.dailyTaskMap["description"];
      _categoryController.text = widget.dailyTaskMap["category"];
      _itemTypeController.text = widget.dailyTaskMap["item_type"];
      _dateController.text = widget.dailyTaskMap["date"];
      _addressController.text = widget.dailyTaskMap["address"];
      _locationController.text = widget.dailyTaskMap["location"];
      _contactNameController.text = widget.dailyTaskMap["conatct_name"];
      _path = widget.dailyTaskMap["generalPath"];
      _notificationsController.text =
          widget.dailyTaskMap["notification"] ?? "10 Minutes Before";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF6035D0),
        title: const Text('New Item'),
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
        ],
      ),
      body: SafeArea(
          child: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldContainer(
                  controller: _itemNameController,
                  hintText: "Item name",
                  formkey: _formkey,
                  hintTextColor: _itemNameController.text == ""
                      ? Colors.grey[400]
                      : Colors.black,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 55),
                  ),
                  fillcolor: Colors.white,
                  border: true,
                  onChanged: (value) {
                    setState(() {});
                  },
                  errorMsg: "",
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return '';
                    }

                    return null;
                  }),
              TextFieldContainer(
                  controller: _descriptionController,
                  hintText: "Description",
                  formkey: _formkey,
                  hintTextColor: _descriptionController.text == ""
                      ? Colors.grey[400]
                      : Colors.black,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 55),
                  ),
                  fillcolor: Colors.white,
                  onChanged: (value) {
                    setState(() {});
                  },
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
                  controller: _categoryController,
                  hintText: "Category",
                  formkey: _formkey,
                  onChanged: (value) {
                    setState(() {});
                  },
                  hintTextColor: _categoryController.text == ""
                      ? Colors.grey[400]
                      : Colors.black,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 55),
                  ),
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
              TextFieldContainer(
                  controller: _itemTypeController,
                  hintText: "Item Type",
                  formkey: _formkey,
                  hintTextColor: _itemTypeController.text == ""
                      ? Colors.grey[400]
                      : Colors.black,
                  readOnly: true,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: IconButton(
                        onPressed: () {
                          SelectDialog.showModal<String>(context,
                              searchBoxDecoration: const InputDecoration(
                                  hintText: 'Choose item type...'),
                              label: "Choose item type",
                              selectedValue: _itemTypeController.text,
                              titleStyle: const TextStyle(fontFamily: "Roboto"),
                              items: [
                                "Occasion",
                                "Task",
                              ], onChange: (String selected) {
                            setState(() {
                              _itemTypeController.text = selected;
                            });
                          });
                        },
                        icon: const Icon(Icons.arrow_drop_down_sharp)),
                  ),
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
              TextFieldContainer(
                  controller: _dateController,
                  hintText: "Pick Date & Time",
                  formkey: _formkey,
                  readOnly: true,
                  hintTextColor: _dateController.text == ""
                      ? Colors.grey[400]
                      : Colors.black,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 55),
                  ),
                  fillcolor: Colors.white,
                  border: true,
                  onTap: () {
                    _selectDate();
                  },
                  errorMsg: "",
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return '';
                    }

                    return null;
                  }),
              Row(
                children: [
                  TextFieldContainer(
                      width: 0.5,
                      controller: _addressController,
                      hintText: "Address ",
                      formkey: _formkey,
                      onChanged: (value) {
                        setState(() {});
                      },
                      hintTextColor: _addressController.text == ""
                          ? Colors.grey[400]
                          : Colors.black,
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(top: 55),
                      ),
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
                  TextFieldContainer(
                      width: 0.5,
                      controller: _locationController,
                      hintText: "Location",
                      formkey: _formkey,
                      onChanged: (value) {
                        setState(() {});
                      },
                      hintTextColor: _locationController.text == ""
                          ? Colors.grey[400]
                          : Colors.black,
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(top: 55),
                      ),
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
                ],
              ),
              Row(
                children: [
                  TextFieldContainer(
                      width: 0.5,
                      controller: _contactNameController,
                      hintText: "Contact Name",
                      formkey: _formkey,
                      onChanged: (value) {
                        setState(() {});
                      },
                      hintTextColor: _contactNameController.text == ""
                          ? Colors.grey[400]
                          : Colors.black,
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(top: 55),
                      ),
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
                  TextFieldContainer(
                      width: 0.5,
                      readOnly: true,
                      hintText: "Add image",
                      formkey: _formkey,
                      hintTextColor: _categoryController.text == ""
                          ? Colors.grey[400]
                          : Colors.black,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: IconButton(
                            onPressed: () async {
                              _path = await ImagePicker().pickImage(
                                  imageQuality: 40,
                                  source: ImageSource.gallery);
                              setState(() {});
                            },
                            icon: const Icon(Icons.add)),
                      ),
                      fillcolor: Colors.white,
                      border: true,
                      errorMsg: "",
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (_path == null) {
                          return '';
                        }

                        return null;
                      }),
                ],
              ),
              const SizedBox(height: 10),
              if (_path != null)
                Center(
                  child: CircleAvatar(
                    radius: 53,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(
                        File(_path!.path.toString()),
                      ),
                    ),
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Priority",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 1,
                          color: Color(0x32171717),
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        GestureDetector(
                          child: selectedPriority != "important"
                              ? Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/red.png?alt=media&token=e1bc1428-cce3-4c50-8dc1-359f517e996e",
                                  height: 25,
                                  width: 25,
                                )
                              : CircleAvatar(
                                  radius: 12,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  backgroundImage: const NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/red.png?alt=media&token=e1bc1428-cce3-4c50-8dc1-359f517e996e",
                                  )),
                          onTap: () {
                            setState(() {
                              selectedPriority = "important";
                            });
                          },
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          child: selectedPriority != "orange"
                              ? Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/orange.png?alt=media&token=620f460f-ff2e-434c-936f-ee27e689df55",
                                  height: 25,
                                  width: 25,
                                )
                              : CircleAvatar(
                                  radius: 12,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  backgroundImage: const NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/orange.png?alt=media&token=620f460f-ff2e-434c-936f-ee27e689df55",
                                  )),
                          onTap: () {
                            setState(() {
                              selectedPriority = "orange";
                            });
                          },
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          child: selectedPriority != "blue"
                              ? Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/blue.png?alt=media&token=5ef89bae-a583-41d4-93cb-b84c25aeab9f",
                                  height: 25,
                                  width: 25,
                                )
                              : CircleAvatar(
                                  radius: 12,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  backgroundImage: const NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/blue.png?alt=media&token=5ef89bae-a583-41d4-93cb-b84c25aeab9f",
                                  )),
                          onTap: () {
                            setState(() {
                              selectedPriority = "blue";
                            });
                          },
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          child: selectedPriority != "green"
                              ? Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/green.png?alt=media&token=da123f8c-fc63-40e0-9436-3a4cc0e218c8",
                                  height: 25,
                                  width: 25,
                                )
                              : CircleAvatar(
                                  radius: 12,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  backgroundImage: const NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/green.png?alt=media&token=da123f8c-fc63-40e0-9436-3a4cc0e218c8",
                                  )),
                          onTap: () {
                            setState(() {
                              selectedPriority = "green";
                            });
                          },
                        ),
                      ]),
                    ),
                  ),
                  TextFieldContainer(
                      controller: _notificationsController,
                      readOnly: true,
                      hintText: "Notification",
                      formkey: _formkey,
                      hintTextColor: _notificationsController.text == ""
                          ? Colors.grey[400]
                          : Colors.black,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: IconButton(
                            onPressed: () {
                              SelectDialog.showModal<String>(context,
                                  searchBoxDecoration: const InputDecoration(
                                      hintText: 'Choose notification type...'),
                                  label: "Choose notification type",
                                  selectedValue: _notificationsController.text,
                                  titleStyle:
                                      const TextStyle(fontFamily: "Roboto"),
                                  items: [
                                    "10 Minutes Before",
                                    "1 Day Before",
                                    "2 Day Before",
                                    "1 Week Before",
                                  ], onChange: (String selected) {
                                setState(() {
                                  _notificationsController.text = selected;
                                });
                              });
                            },
                            icon: const Icon(Icons.arrow_drop_down_sharp)),
                      ),
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
                  TextButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          if (widget.isEdit == true) {
                            setState(() {
                              dailyTasks.removeWhere((element) =>
                                  element["guid"] ==
                                  widget.dailyTaskMap["guid"]);
                            });
                          }
                          dailyTasks.add(
                            {
                              "guid": uuid.v1(),
                              "name": _itemNameController.text,
                              "generalPath": _path,
                              "time": "3:35 AM",
                              "category": _categoryController.text,
                              "description": _descriptionController.text,
                              "item_type": _itemTypeController.text,
                              "address": _addressController.text,
                              "location": _locationController.text,
                              "conatct_name": _contactNameController.text,
                              "notification": _notificationsController.text,
                              "image": _path!.path.toString(),
                              "Priority": selectedPriority,
                              "isFavorite": false,
                              "publisherName": "Abdullatif Eida",
                              "publisherImage":
                                  "https://media-exp1.licdn.com/dms/image/C4D03AQG2XQsjB_juKA/profile-displayphoto-shrink_100_100/0/1644853536737?e=1665014400&v=beta&t=6OjQaqnspuF_7xJgT9N4OWrAvFeXrUPPDdPymnoEamE",
                              "publisherGender": "Male",
                              "phone1": "05050764732",
                              "country": "Turkey",
                              "date": DateTime.now().toString(),
                            },
                          );
                        });
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("New item has been created",
                              style: TextStyle(fontFamily: "Almarai")),
                        ));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("All fields are required",
                              style: TextStyle(fontFamily: "Almarai")),
                        ));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0XFF6035D0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Center(
                            child: Text(
                          "ADD",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 1850)),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().substring(0, 10);
      });
    }
  }
}
