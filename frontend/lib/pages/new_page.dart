import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_food_catelogs/components/bottom_navbar.dart';
import 'package:ocr_food_catelogs/components/image_container.dart';
class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  File? _selectedImage;
  // function to pick a image 
  Future<void> _pickImage()async
  {
    try {
    final ImagePicker picker = ImagePicker();
    final returnedImage =await picker.pickImage(source: ImageSource.gallery);
    if (returnedImage !=null){
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: Text("HEALTH KART",style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0,right: 25.0,top: 25),
          child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload image to extract nutrients",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.inversePrimary,fontSize: 16),
                  ),
                  const SizedBox(height: 10,),
                  ImageContainer(
                    selectedImage: _selectedImage, 
                    pickImage: _pickImage),
                ],
              ),
          ),
        ),
        bottomNavigationBar: BottomNavbar(pickImage: _pickImage)
    );
  }
}