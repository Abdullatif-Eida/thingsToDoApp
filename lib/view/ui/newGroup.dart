import 'package:flutter/material.dart';
import 'package:thingstodoapp/view/shared/textfield_container.dart';
import 'package:thingstodoapp/view/ui/notifications.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({Key? key}) : super(key: key);

  @override
  State<NewGroup> createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF6035D0),
        title: const Text("Groups"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Notifications()));
            },
            icon: const Icon(
              Icons.notifications_active_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextFieldContainer(
                    hintText: "Group name",
                    formkey: _formkey,
                    hintTextColor: Colors.grey[400],
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
                    hintText: "Group fescription",
                    formkey: _formkey,
                    hintTextColor: Colors.grey[400],
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
                  readOnly: true,
                  hintText: "Add members",
                  formkey: _formkey,
                  hintTextColor: Colors.grey[400],
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: IconButton(
                        onPressed: () async {}, icon: const Icon(Icons.add)),
                  ),
                  fillcolor: Colors.white,
                  border: true,
                  errorMsg: "",
                  keyboardType: TextInputType.name,
                ),
                TextFieldContainer(
                  readOnly: true,
                  hintText: "Add image",
                  formkey: _formkey,
                  hintTextColor: Colors.grey[400],
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: IconButton(
                        onPressed: () async {}, icon: const Icon(Icons.add)),
                  ),
                  fillcolor: Colors.white,
                  border: true,
                  errorMsg: "",
                  keyboardType: TextInputType.name,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
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
      )),
    );
  }
}
