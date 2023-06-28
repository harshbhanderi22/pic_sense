import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pexel/View/developer.dart';
import 'package:pexel/View/user_guidance.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.teal.shade600,
        child: ListView(
          children: [
            const DrawerHeader(
                child: Center(
                    child: Text(
              "Welcome To\nPic Sense",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ))),
            const Divider(
              color: Colors.black38,
            ),
            DrawerEntry(
                CupertinoIcons.person, "User Guidance", const UserGuidance()),
            DrawerEntry(CupertinoIcons.device_laptop, "Developer",
                const DeveloperContact()),
            //DrawerEntry(Icons.share, "Share"),
          ],
        ),
      ),
    );
  }
}

class DrawerEntry extends StatelessWidget {
  DrawerEntry(this.tiltIcon, this.title, this.widget);

  final IconData tiltIcon;
  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
      },
      child: ListTile(
        leading: Icon(
          tiltIcon,
          color: Colors.white,
        ),
        title: Text(
          "$title",
          style: const TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );
  }
}
