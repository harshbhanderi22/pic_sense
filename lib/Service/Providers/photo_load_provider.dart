import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';
import 'package:pexel/Utils/urls.dart';

class PhotoLoadProvider with ChangeNotifier {
  bool _fetching = true;

  int perPage = 80;

  final List<dynamic> _imageList = [];
  final List<dynamic> _searchImageList = [];

  int _pages = 1;

  int _searchPages = 1;

  int get getPageCount => _pages;
  int get getSearchPageCount => _searchPages;

  void addPage() {
    _pages++;
    notifyListeners();
  }

  void addSearchPage() {
    _searchPages++;
    notifyListeners();
  }

  List<dynamic> get getImageList => _imageList;
  List<dynamic> get getSearchImageList => _searchImageList;

  bool get isFetching => _fetching;

  void setFetcing(bool value) {
    _fetching = value;
    notifyListeners();
  }

  void setImageList(List<dynamic> images) {
    _imageList.addAll(images);
    _imageList.toSet().toList();
    notifyListeners();
  }

  void setSearchedList(List<dynamic> images) {
    _searchImageList.addAll(images);
    _searchImageList.toSet().toList();
    notifyListeners();
  }

  Future<void> getImages() async {
    setFetcing(true);
    try {
      //print("In try block");
      Response response = await http.get(Uri.parse("${photoUrl}1"), headers: {
        "Authorization": apiKey
      }).timeout(const Duration(seconds: 10));
      var result = jsonDecode(response.body);
      setFetcing(false);
      setImageList(result["photos"]);
      setImageList(["+"]);
      //print(_imageList);
    } catch (e) {
      setFetcing(false);
    }
  }

  Future<void> getExtraImages() async {
    //setFetcing(true);
    Fluttertoast.showToast(msg: "Wait!! We Are Adding Images");
    try {
      //print("In try block");
      Response response = await http.get(Uri.parse("$photoUrl$_pages"),
          headers: {
            "Authorization": apiKey
          }).timeout(const Duration(seconds: 10));
      var result = jsonDecode(response.body);
      //setFetcing(false);
      _imageList.remove("+");
      setImageList(result["photos"]);
      setImageList(["+"]);
      //print(_imageList);
    } catch (e) {
      //setFetcing(false);
    }
  }

  Future<void> getSearchedImage(String word) async {
    //setFetcing(true);
    Fluttertoast.showToast(msg: "Wait!! We Are Searching Images");
    try {
      //print("In try block");
      Response response = await http.get(
          Uri.parse(
              "https://api.pexels.com/v1/search?query=$word&per_page=$perPage"),
          headers: {
            "Authorization": apiKey
          }).timeout(const Duration(seconds: 10));
      var result = jsonDecode(response.body);
      // setFetcing(false);
      _searchImageList.remove("+");
      setSearchedList(result["photos"]);
      setSearchedList(["+"]);
      //print("Search Images");

      //setImageList(["+"]);
      //print(_imageList);
    } catch (e) {
      //setFetcing(false);
    }
  }

  Future<void> getExtraSearchImages(String word) async {
    //setFetcing(true);
    Fluttertoast.showToast(msg: "Wait!! We Are Adding Images");
    try {
      //print("In try block");
      Response response = await http.get(
          Uri.parse(
              "https://api.pexels.com/v1/search?query=$word&per_page=$perPage&page=$_searchPages"),
          headers: {
            "Authorization": apiKey
          }).timeout(const Duration(seconds: 10));
      var result = jsonDecode(response.body);
      //setFetcing(false);
      _searchImageList.remove("+");
      setSearchedList(result["photos"]);
      setSearchedList(["+"]);
      //print(_imageList);
    } catch (e) {
      //setFetcing(false);
    }
  }
}
