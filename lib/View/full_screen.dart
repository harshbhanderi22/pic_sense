import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pexel/Service/Providers/permission_handle.dart';

class FullViewPhoto extends StatefulWidget {
  final String photoUrl;

  const FullViewPhoto({super.key, required this.photoUrl});

  @override
  State<FullViewPhoto> createState() => _FullViewPhotoState();
}

class _FullViewPhotoState extends State<FullViewPhoto> {
  Future<void> setWallpaper(int loc) async {
    try {
      String url = widget.photoUrl;
      int location = loc; // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      Fluttertoast.showToast(msg: "Wallpaper Set Successfully");
    } on PlatformException {
      Fluttertoast.showToast(msg: "Unable To Set Wallpaper On This Device");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Full Screen View",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Image.network(
              widget.photoUrl,
              height: MediaQuery.of(context).size.height - 200,
              width: double.infinity,
            ),
            Positioned(
                bottom: 10,
                right: 30,
                child: InkWell(
                  onTap: () async {
                     DownloadHandler dh = DownloadHandler();
                    // if (await dh.checkPermission()) {
                    //   dh.saveNetworkImage(widget.photoUrl);
                    // } else {
                    //   print("{Permission Requested}");
                    //   dh.requestPermission();
                    // }
                    dh.saveToGallery(widget.photoUrl);
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.download,
                      size: 25,
                    ),
                  ),
                ))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SaveButtons(
              label: "Lock Screen",
              color: Colors.black,
              textColor: Colors.white,
              onTap: () {
                setWallpaper(WallpaperManager.LOCK_SCREEN);
              },
            ),
            SaveButtons(
              label: "Home Screen",
              color: Colors.white,
              textColor: Colors.black,
              onTap: () {
                setWallpaper(WallpaperManager.HOME_SCREEN);
              },
            ),
          ],
        )
      ]),
    );
  }
}

class SaveButtons extends StatelessWidget {
  final Function onTap;
  final String label;
  final Color color;
  final Color textColor;

  const SaveButtons(
      {super.key,
      required this.onTap,
      required this.label,
      required this.textColor,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
              child: Text(
            label,
            style: TextStyle(fontSize: 20, color: textColor),
          )),
        ),
      ),
    );
  }
}
