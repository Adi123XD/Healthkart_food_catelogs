import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ocr_food_catelogs/components/full_screen_image.dart';
// import 'package:image_picker/image_picker.dart';
class ImageContainer extends StatefulWidget {
  final File? selectedImage;
  final VoidCallback pickImage;
  const ImageContainer({
    super.key,
    required this.selectedImage,
    required this.pickImage});

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
        margin: const EdgeInsets.only(bottom: 10),
        child: widget.selectedImage!=null ? 
        GestureDetector(
          onTap: (){
            Navigator.push(
              context, MaterialPageRoute(
                builder: (context)=> 
                FullScreenImage(
                  selectedImage: widget.selectedImage
                  ),
                ),
              );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(widget.selectedImage!,
            width: double.infinity,
            height: 400,
            fit: BoxFit.cover,
            ),
          ),
        ):Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: widget.pickImage,
                icon: Icon(Icons.add, 
                color: Theme.of(context).colorScheme.inversePrimary,size: 60,)
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text("Click to add an image",
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 18,fontWeight: FontWeight.bold),),
                )
            ],
          ),
        ),
    );
  }
}