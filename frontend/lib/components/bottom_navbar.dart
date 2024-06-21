import 'package:flutter/material.dart';
class BottomNavbar extends StatefulWidget {
  final VoidCallback pickImage;
  final VoidCallback process;
  const BottomNavbar({
    super.key,
    required this.pickImage,
    required this.process,
    });

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Expanded(
            child: TextButton(onPressed: widget.process,
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
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.cyan),
              foregroundColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.tertiary),
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