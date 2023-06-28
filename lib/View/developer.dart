import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperContact extends StatelessWidget {
  const DeveloperContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Developer Info",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 75,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.person_4,
                size: 80,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Harsh Bhanderi",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Email: harshbhanderi228@gmail.com",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                launchUrl(Uri.parse(
                    'https://www.linkedin.com/in/harsh-bhanderi-hb22/'));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Linkdin: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                      "https://www.linkedin.com/in/harsh-bhanderi-hb22/",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
