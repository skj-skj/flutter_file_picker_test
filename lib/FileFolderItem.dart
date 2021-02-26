// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

class FileFolderItem {
  final String name;
  final String path;
  final bool isFile;
  final bool isFolder;

  FileFolderItem({this.name, this.path, this.isFile, this.isFolder});


  void printItem(){
    print(this.name+" "+this.path);
  }
}
