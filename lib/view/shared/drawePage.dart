import 'dart:convert';
import 'package:flutter/material.dart';

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
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black54,
                  /*AppColours.appgradientfirstColour,
                    AppColours.appgradientsecondColour*/
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.3, 0.0),
                stops: [0.0, 8.0],
                tileMode: TileMode.clamp),
          ),
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://media-exp1.licdn.com/dms/image/C5603AQHgy5YaTKYuTQ/profile-displayphoto-shrink_200_200/0/1565907304640?e=2147483647&v=beta&t=w-OmUIeebFcA1fkUgFUy3iBvq-lIACGx6Omh2a4aBP0"),
                  ),
                ),
              ),
              const Text(
                "Admin",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(
                "Points:23432432423",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              const DividerWidget(),
              drawerItem(
                  wantedIcon: Icons.person_outline_outlined,
                  itemName: 'My Profile',
                  onTap: () {}),
              const DividerWidget(),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2.0, bottom: 2),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0, right: 14.0),
                        child: Icon(
                          Icons.brightness_7_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Points",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Text("0"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {},
              ),
              const DividerWidget(),
              drawerItem(
                wantedIcon: Icons.shopping_cart_rounded,
                itemName: 'Checkout',
                onTap: () {},
              ),
              const DividerWidget(),
              drawerItem(
                wantedIcon: Icons.settings,
                itemName: 'Request Part',
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => WillPopScope(
                      onWillPop: () async {
                        return false;
                      },
                      child: AlertDialog(
                        title: const Text(
                          'Alert',
                          style: TextStyle(fontSize: 15, height: 1.6),
                        ),
                        content: const Text("Soon"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Ok",
                                style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const DividerWidget(),
              drawerItem(
                  wantedIcon: Icons.copyright,
                  itemName: 'Our Brands',
                  onTap: () {}),
              const DividerWidget(),
              drawerItem(
                wantedIcon: Icons.brightness_7_rounded,
                itemName: 'Certificates',
                onTap: () {},
              ),
              const DividerWidget(),
              drawerItem(
                wantedIcon: Icons.mail,
                itemName: 'Contact Us',
                onTap: () {},
              ),
              const DividerWidget(),
              drawerItem(
                wantedIcon: Icons.notifications,
                itemName: 'Notifications',
                onTap: () {},
              ),
              const DividerWidget(),
              drawerItem(
                wantedIcon: Icons.logout,
                itemName: 'Sign Out',
              ),
              const DividerWidget(),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: const [
                    Text(
                      "Admin Panel",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const DividerWidget(),
              drawerItem(
                wantedIcon: Icons.send,
                itemName: 'Send Notification',
                onTap: () {},
              ),
              const DividerWidget(),
              drawerItem(
                wantedIcon: Icons.account_balance_wallet_rounded,
                itemName: 'Manage Bills',
                onTap: () {},
              ),
              const DividerWidget(),
              drawerItem(
                wantedIcon: Icons.settings,
                itemName: 'Manage Part Request',
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => WillPopScope(
                      onWillPop: () async {
                        return false;
                      },
                      child: AlertDialog(
                        title: const Text(
                          'Alert',
                          style: TextStyle(fontSize: 15, height: 1.6),
                        ),
                        content: const Text("Soon"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Ok",
                                style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const DividerWidget(),
              drawerItem(
                wantedIcon: Icons.groups,
                itemName: 'Manage Users',
                onTap: () {},
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
