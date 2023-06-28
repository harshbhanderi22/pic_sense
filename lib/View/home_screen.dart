import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pexel/Service/Providers/photo_load_provider.dart';
import 'package:pexel/Utils/Component/drawer.dart';
import 'package:pexel/View/full_screen.dart';
import 'package:pexel/View/user_guidance.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription? connection;
  bool isoffline = true;

  void checkInternet() {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //print("None");
        Fluttertoast.showToast(
            msg: "Check Your Internet Connection And Try Again");
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        //print("Mobile");
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        //print("Wifi");
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection
        //print("Wired");

        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening
        //print("Blue");
        setState(() {
          isoffline = false;
        });
      }
    });
  }

  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    checkInternet();
    Future.microtask(() {
      Provider.of<PhotoLoadProvider>(context, listen: false).getImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              "Pic Sense",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.teal,
          ),
          body: isoffline
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Looks like, You don't have active Internet "
                      "Connection.\nPlease turn it on and try again",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        checkInternet();
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.5)),
                        child: const Center(
                          child: Text(
                            "Try Again!!!",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
              : Consumer<PhotoLoadProvider>(
                  builder: (context, provider, _) {
                    return Column(
                      children: [
                        Container(
                          //width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                      hintText: "Search Category",
                                      //suffix: Icon(Icons.search),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                  onTap: () {
                                    provider.getSearchImageList.clear();
                                    provider.getSearchedImage(
                                        _searchController.text);
                                  },
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      child: const Icon(Icons.search)))
                            ],
                          ),
                        ),
                        if (provider.isFetching)
                          Center(
                              child: Column(
                            children: const [
                              SizedBox(
                                height: 100,
                              ),
                              CircularProgressIndicator(),
                            ],
                          ))
                        else
                          Expanded(
                            child: Column(
                              children: [
                                provider.getSearchImageList.isNotEmpty
                                    ? Expanded(
                                        child: GridView.builder(
                                          itemCount: provider
                                              .getSearchImageList.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 5.0,
                                            crossAxisSpacing: 5.0,
                                          ),
                                          itemBuilder: (context, index) {
                                            if (provider.getSearchImageList[
                                                    index] ==
                                                '+') {
                                              return InkWell(
                                                onTap: () {
                                                  provider.addSearchPage();
                                                  provider.getExtraSearchImages(
                                                      _searchController.text);
                                                },
                                                child: const Center(
                                                    child: Text(
                                                  "+\n\nLoad More",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                )),
                                              );
                                            } else {
                                              String url = provider
                                                      .getSearchImageList[index]
                                                  ["src"]["large2x"];
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              FullViewPhoto(
                                                                  photoUrl:
                                                                      url)));
                                                },
                                                child: Image.network(
                                                  provider.getSearchImageList[
                                                      index]["src"]["large"],
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      )
                                    : Expanded(
                                        child: GridView.builder(
                                          itemCount:
                                              provider.getImageList.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 5.0,
                                            crossAxisSpacing: 5.0,
                                          ),
                                          itemBuilder: (context, index) {
                                            if (provider.getImageList[index] ==
                                                '+') {
                                              return InkWell(
                                                onTap: () {
                                                  provider.addPage();
                                                  provider.getExtraImages();
                                                },
                                                child: const Center(
                                                    child: Text(
                                                  "+\n\nLoad More",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                )),
                                              );
                                            } else {
                                              String url =
                                                  provider.getImageList[index]
                                                      ["src"]["large2x"];
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              FullViewPhoto(
                                                                  photoUrl:
                                                                      url)));
                                                },
                                                child: Image.network(
                                                  provider.getImageList[index]
                                                      ["src"]["large"],
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          )
                      ],
                    );
                  },
                ),
          drawer: MyDrawer()),
    );
  }
}
