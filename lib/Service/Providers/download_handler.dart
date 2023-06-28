import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
 
class DownloadHandler {

  Future<void> saveToGallery(String url) async {
    final tempDir = await getTemporaryDirectory();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyyMMdd_HHmmss').format(now);

    String fileName = 'IMAGE$formattedDate.jpg';
    String path = "${tempDir.path}/$fileName";
    await Dio().downloadUri(Uri.parse(url), path);

    await GallerySaver.saveImage(path);

    Fluttertoast.showToast(msg: "Image Downloaded Successfully");
  }
}
