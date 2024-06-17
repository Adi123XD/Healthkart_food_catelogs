import 'package:flutter/material.dart';
class BottomNavbar extends StatefulWidget {
  final VoidCallback pickImage;
  const BottomNavbar({
    super.key,
    required this.pickImage
    });

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  // bool isProcessClicked = false;
  // toggle buttons 
  // void _toggleButtons(){
  //   setState(() {
  //     isProcessClicked = !isProcessClicked;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Expanded(
            child: TextButton(onPressed: (){
              // _toggleButtons();
              },
            // this below code is to toggle button color on tap 
            // style:ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(isProcessClicked?Colors.cyan: Colors.transparent),
            // foregroundColor: WidgetStateProperty.all<Color>(isProcessClicked?Colors.white:Colors.cyan),
            // side: WidgetStateProperty.all<BorderSide>(const BorderSide(color: Colors.cyan)),
            // ),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.cyan),
              side: WidgetStateProperty.all<BorderSide>(const BorderSide(color: Colors.cyan))
            ),
            child: const Padding(
              padding:  EdgeInsets.all(8.0),
              child: Text("Process", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            ),
            ),
          ),
          const SizedBox(width: 15,),
          Expanded(
            child: TextButton(onPressed: widget.pickImage,
            // the below code is to toggle button color on click 
            // style:ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(isProcessClicked?Colors.transparent: Colors.cyan),
            //   foregroundColor: WidgetStateProperty.all<Color>(isProcessClicked? Colors.cyan:Colors.white),
            //   side: WidgetStateProperty.all<BorderSide>(const BorderSide(color: Colors.cyan)),
            // ),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.cyan),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              side: WidgetStateProperty.all<BorderSide>(const BorderSide(color: Colors.cyan)),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Retake", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            ),
            ),
          ),
        ],
      ),
    );
  }
}