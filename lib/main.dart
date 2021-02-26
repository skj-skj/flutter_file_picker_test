import 'package:file_picker_test/Classes/FileFolderListWidget.dart';
// import 'package:file_picker_test/FileFolderItem.dart';
// import 'package:file_picker_test/widgets/item_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
// import 'dart:io';
// import 'package:file_picker_test/constants/constants.dart';
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

// List<FileFolderItem> fileFolderList = [];
String currLocation = '/storage/emulated/0';

// var myDir = new Directory(currLocation);

// Widget genWidgetFromFileFolderData(FileFolderItem fileFolderItem){
//   return ItemTile(name: fileFolderItem.name,path: fileFolderItem.path,isFile: fileFolderItem.isFile,isFolder: fileFolderItem.isFolder);
// }

// List<Widget> tiles = [];
// List<FileSystemEntity> filesNfolders = myDir.list().toList();
// for(var item in myDir.listSync()){}

// Future<void> genTiles() async{
//   List<FileSystemEntity> filesNfolders = myDir.listSync();
//   List<ItemTile> tempFiles = [];
//   List<ItemTile> tempFolders = [];
//   for(FileSystemEntity item in filesNfolders){

//     String path = item.path;
//     String name = path.split("/").last;
//     bool isFile = (item is File)?true:false;
//     bool isFolder = !isFile;

//     if(isFile){
//       tempFiles.add(genWidgetFromFileFolderData(FileFolderItem(name:name,path:path,isFile: isFile,isFolder: isFolder)));
//     }else{
//       tempFolders.add(genWidgetFromFileFolderData(FileFolderItem(name:name,path:path,isFile: isFile,isFolder: isFolder)));
//     }

//   }

//   tempFolders.sort((a, b) => a.path.compareTo(b.path));
//   tempFiles.sort((a, b) => a.path.compareTo(b.path));

//   tiles.addAll(tempFolders);
//   tiles.addAll(tempFiles);
//   // filesNfolders.forEach((item)=>{

//   //   // tiles.add(
//   //   //   FileFolderItem(name: item.)
//   //   // );
//   // });
// }

// List<Tile> tiles = [];
// List<FileSystemEntity> allDirList = [];

// Future<void> generateDirList({@required String locationDir}) async {
//   currLocation = locationDir;
//   tiles = [Tile(type: 'Back', loc: '...')];
//   List<Tile> dirTemp = [], fileTemp = [];
//   var myDir = new Directory(locationDir);
//   allDirList = myDir.listSync();
//   allDirList.forEach((element) {
//     if (element is Directory) {
//       dirTemp.add(Tile(type: 'Dir', loc: element.path));
//       print("Dir");
//     } else if (element is File) {
//       fileTemp.add(Tile(type: 'File', loc: element.path));
//       print("File");
//       // element.path.split('/').last
//     }
//   });
//   dirTemp.sort((a, b) => a.loc.compareTo(b.loc));
//   fileTemp.sort((a, b) => a.loc.compareTo(b.loc));
//   tiles.addAll(dirTemp);
//   tiles.addAll(fileTemp);
//   print('Tile List Generated');
//   // setState(() {});
//   // allDirList.forEach((element) {
//   //   if (element is File) {
//   //     print(element.path);
//   //     label += '\nFile: ${element.path}';
//   //   }
//   // });
// //    print(allDirList[0].runtimeType );

// //    label = allDirList.toString();
// //    allDirList.forEach((element) {
// //
// //    });
// }

class _MyHomeState extends State<MyHome> {
  // String tempLocation = '';
  // bool selected = false;

  /*Future<void> getDirList({@required String locationDir}) async {
    var myDir = new Directory(locationDir);
    allDirList = myDir.listSync();
    allDirList.forEach((element) {
      if (element is Directory) {
        print(element.path);
        label += '\nDirectory: ${element.path}';
      }
    });
    allDirList.forEach((element) {
      if (element is File) {
        print(element.path);
        label += '\nFile: ${element.path}';
      }
    });
//    print(allDirList[0].runtimeType );

//    label = allDirList.toString();
//    allDirList.forEach((element) {
//
//    });
  }*/

  /*Future<void> generateDirList({@required String locationDir}) async {
    List<Tile> dirTemp = [], fileTemp = [];
    var myDir = new Directory(locationDir);
    allDirList = myDir.listSync();
    allDirList.forEach((element) {
      if (element is Directory) {
        dirTemp.add(Tile(type: 'Dir', loc: element.path));
        print("Dir");
      } else if (element is File) {
        fileTemp.add(Tile(type: 'File', loc: element.path));
        print("File");
        // element.path.split('/').last
      }
    });
    dirTemp.sort((a, b) => a.loc.compareTo(b.loc));
    fileTemp.sort((a, b) => a.loc.compareTo(b.loc));
    tiles.addAll(dirTemp);
    tiles.addAll(fileTemp);
    setState(() {});
    // allDirList.forEach((element) {
    //   if (element is File) {
    //     print(element.path);
    //     label += '\nFile: ${element.path}';
    //   }
    // });
//    print(allDirList[0].runtimeType );

//    label = allDirList.toString();
//    allDirList.forEach((element) {
//
//    });
  }*/

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
    // tiles.add(genWidgetFromFileFolderData(backItem));
    requestStoragePermission();
    // genTiles();

    // filesNfolders.forEach();
    // requestStoragePermission();
    // generateDirList(locationDir: currLocation);
    // setState(() {});
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
        // child: ListView(
        //   children: tiles,
        // ),
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: tiles,
      // ),)
    );
  }
}

// class NewWidget extends StatelessWidget {
//   const NewWidget({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){
//     print("Path");
//       },
//       child: Card(
//     child: ListTile(
//       leading:  FlutterLogo(),
//       title: Text("Path"),
//     ),
//       ),
//     );
//   }
// }

// class Tile extends StatefulWidget {
//   Tile({this.selected = false, @required this.type, @required this.loc});
//   bool selected;
//   String type, loc;
//   @override
//   _TileState createState() => _TileState();
// }

// class _TileState extends State<Tile> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         if (widget.type == 'Dir') {
//           print('Inside Dir OnTap');
//           await generateDirList(locationDir: widget.loc);
//           print(widget.loc);
//         } else if (widget.type == 'File') {
//           widget.selected = !widget.selected;
//         } else {
//           List<String> tempLoc = currLocation.split('/');
//           tempLoc = tempLoc.sublist(0, tempLoc.length - 1);
//           await generateDirList(locationDir: tempLoc.join('/'));
//         }
//         setState(() {
//           print('Called SetState');
//         });
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           color: widget.selected ? Colors.blue : Color(0),
//           // borderRadius: BorderRadius.all(Radius.circular(10.0)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   widget.loc.split('/').last,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     color: widget.selected ? Colors.white : Colors.black,
//                   ),
//                   overflow: TextOverflow.fade,
//                 ),
//                 Icon(
//                   widget.type == "Dir"
//                       ? Icons.folder
//                       : (widget.type == "File")
//                           ? Icons.insert_drive_file_rounded
//                           : null,
//                   color: widget.selected ? Colors.white : Colors.black,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
