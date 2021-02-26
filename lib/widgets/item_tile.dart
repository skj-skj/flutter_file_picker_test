import 'package:file_picker_test/Classes/FileFolderListWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({this.name, this.path, this.isFile, this.isFolder});

  final String name;
  final String path;
  final bool isFile;
  final bool isFolder;

  String getPath() {
    return this.path;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          print(this.path);
          Provider.of<FileFolderListWidget>(context, listen: false)
              .genList(this.path);
        },
        leading: isFile ? FlutterLogo() : Icon(Icons.folder_open),
        title: Text(this.name),
      ),
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
//       onTap: () {
//         print("Path");
//       },
//       child: Card(
//         child: ListTile(
//           // leading:  FlutterLogo(),
//           title: Text("Path"),
//         ),
//       ),
//     );
//   }
// }
