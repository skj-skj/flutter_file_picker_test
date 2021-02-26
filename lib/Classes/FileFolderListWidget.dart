import 'package:flutter/material.dart';
import 'package:file_picker_test/widgets/item_tile.dart';
import 'package:file_picker_test/FileFolderItem.dart';
import 'package:file_picker_test/constants/constants.dart';
import 'dart:io';

class FileFolderListWidget extends ChangeNotifier {
  List<ItemTile> _ffList = [];

  String currentLocation;

  List<ItemTile> get getFfList => _ffList;

  String get getCurrentLocation => currentLocation;

  ItemTile genWidgetFromFileFolderData(FileFolderItem fileFolderItem) {
    return ItemTile(
        name: fileFolderItem.name,
        path: fileFolderItem.path,
        isFile: fileFolderItem.isFile,
        isFolder: fileFolderItem.isFolder);
  }

  void genList(String currLocation) {
    if (currLocation == "../") {
      int currLocationSplitLength = currentLocation.split("/").length;
      currentLocation = currentLocation
          .split("/")
          .sublist(0, currLocationSplitLength - 1)
          .join("/");
    } else {
      currentLocation = currLocation;
    }

    _ffList = [genWidgetFromFileFolderData(backItem)];
    var myDir = new Directory(currentLocation);
    List<FileSystemEntity> filesNfolders = myDir.listSync();
    List<ItemTile> tempFiles = [];
    List<ItemTile> tempFolders = [];

    for (FileSystemEntity item in filesNfolders) {
      String path = item.path;
      String name = path.split("/").last;
      bool isFile = (item is File) ? true : false;
      bool isFolder = !isFile;

      if (isFile) {
        tempFiles.add(genWidgetFromFileFolderData(FileFolderItem(
            name: name, path: path, isFile: isFile, isFolder: isFolder)));
      } else {
        tempFolders.add(genWidgetFromFileFolderData(FileFolderItem(
            name: name, path: path, isFile: isFile, isFolder: isFolder)));
      }
    }

    tempFolders.sort((a, b) => a.path.compareTo(b.path));
    tempFiles.sort((a, b) => a.path.compareTo(b.path));

    _ffList.addAll(tempFolders);
    _ffList.addAll(tempFiles);

    notifyListeners();
  }
}
