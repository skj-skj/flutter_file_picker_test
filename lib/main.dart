import 'package:file_picker_test/Classes/FileFolderListWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => FileFolderListWidget(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String currLocation = '/storage/emulated/0';

  Future<void> requestStoragePermission() async {
    var storageStatus = await Permission.storage.status;
    if (storageStatus.isUndetermined) {
      final status = await Permission.storage.request();
      print(status);
    } else {
      print('Already Granted');
    }
  }

  @override
  void initState() {
    super.initState();
    print("Hello");
    requestStoragePermission();
    Provider.of<FileFolderListWidget>(context, listen: false)
        .genList(currLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("File Picker Test"),
      ),
      body: Consumer<FileFolderListWidget>(
        builder: (context, list, child) {
          return ListView(
            children: list.getFfList,
          );
        },
      ),
    );
  }
}
