import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_food_catelogs/components/bottom_navbar.dart';
import 'package:ocr_food_catelogs/components/edit_nutrient.dart';
import 'package:ocr_food_catelogs/components/image_container.dart';
import 'package:ocr_food_catelogs/services/api_services.dart';
// import 'package:permission_handler/permission_handler.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _selectedImage;
  final ImagePicker picker = ImagePicker();
  final ImageCropper cropper = ImageCropper();
  String? message="";
  List<dynamic>? nutrients;
  bool isLoading=false;

  // function to crop an image 
  Future<CroppedFile?> cropImage( String sourcePath) async
  {
    return await cropper.cropImage(
          sourcePath: sourcePath,
          uiSettings:[
          AndroidUiSettings(
            toolbarTitle: 'Edit Image',
            toolbarColor: Colors.cyan,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: Colors.cyan,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
          IOSUiSettings(
            title: 'Edit Image',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
        ],
      );
  }
  // function to pick an image 
  Future<void> _pickImage(ImageSource source )async
  {
    try {
      final returnedImage =await picker.pickImage(source: source);
      if (returnedImage !=null){
        final croppedFile =await cropImage(returnedImage.path);
        setState(() {
          _selectedImage = File(croppedFile!.path);
          message ="";
          nutrients =[];
        });
      }
      } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  // function to show the bottom sheet with options
  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  void _fetchMessage() async {
    setState(() {
      isLoading = true; // Set loading state
      message = "";
      nutrients =[];
    });
    try {
      var response = await ApiServices().uploadImage(_selectedImage);
      if (response != null) {
        setState(() {
          message = response['message'];
          nutrients = response['nutrients']; // Save nutrients data
        });
      } else {
        setState(() {
          message = "Failed to fetch message";
        });
        Fluttertoast.showToast(
            msg: "Failed to fetch message",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
    catch (e) {
      print('Error fetching message: $e');
      setState(() {
        message = "Failed to fetch message"; // Set error message
      });
      Fluttertoast.showToast(
          msg: "Error: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }
    void _showEditNutrientDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return EditNutrientDialog(
          nutrient: nutrients![index]['Nutrient'],
          initialValue: nutrients![index]['Value'],
          onValueChanged: (newValue) {
            setState(() {
              nutrients![index]['Value'] = newValue;
            });
          },
        );
      },
    );
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
                children: 
                [
                  Text(
                    "Upload image to extract nutrients",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.inversePrimary,fontSize: 16),
                  ),
                  const SizedBox(height: 10,),
                  ImageContainer(
                    selectedImage: _selectedImage, 
                    pickImage: _showImageSourceActionSheet
                    ),
                    if (isLoading)
                      Center(
                      child: CircularProgressIndicator(),
                    ),
                    // display the extracted text
                    if (message != "")...[
                      Text(message!)
                    ],
                    if (nutrients != null) ...
                    [
                    // Text(
                    //   "Nutrients:",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: Theme.of(context).colorScheme.inversePrimary,
                    //       fontSize: 16),
                    // ),
                    const SizedBox(height: 10,),
                    Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Nutrient',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Value',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    for (int i = 0; i < nutrients!.length; i++) 
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(nutrients![i]['Nutrient']),
                          ),
                          GestureDetector(
                            onTap: () => _showEditNutrientDialog(i),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(nutrients![i]['Value']),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                  ],
                ],
              ),
          ),
        ),
        bottomNavigationBar: _selectedImage!=null? BottomNavbar(
          pickImage: _showImageSourceActionSheet,
          process: _fetchMessage,
          ): null,
    );
  }
}