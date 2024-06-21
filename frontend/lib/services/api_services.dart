import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class ApiServices
{
    Future<String?> fetchMessage() async {
      // Use the local network IP address of your computer
      var client = http.Client();
      final response = await client.get(Uri.parse('http://10.0.2.2:8000/api/message'));
      if (response.statusCode == 200) {
        // parse the response
        return jsonDecode(response.body)['message'];
      } else {
        print('Failed to load message: ${response.statusCode}');
        return null;
      }
    }
    Future<Map<String, dynamic>?> uploadImage(File? _selectedImage)async{
      final request = http.MultipartRequest("POST", Uri.parse('https://preservation-star-instrument-cafe.trycloudflare.com/api/upload_image'));
      final headers ={"Content-type": "multipart/form-data"};
      request.files.add(
        http.MultipartFile('image',_selectedImage!.readAsBytes().asStream(),
         _selectedImage.lengthSync(), filename: _selectedImage.path.split('/').last)
      );
      request.headers.addAll(headers);
      final response = await request.send();
      http.Response res = await http.Response.fromStream(response);
      final decodedResponse = jsonDecode(res.body);
      print(decodedResponse);
      
      // return jsonDecode(res.body)['message'];
        return {
          'message': decodedResponse['message'],
          'nutrients': decodedResponse['nutrients'],
        };
    }
}