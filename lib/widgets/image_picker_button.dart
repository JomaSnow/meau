import 'dart:developer';

import 'package:app/util/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends StatefulWidget {
  const ImagePickerButton({super.key});

  @override
  State<ImagePickerButton> createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? imageBytes;

  void pickImage() async {
    try {
      XFile? img = await _picker.pickImage(source: ImageSource.gallery);
      Uint8List bytes = await img!.readAsBytes();

      setState(() {
        imageBytes = bytes;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void deleteImage() async {
    try {
      setState(() {
        imageBytes = null;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return imageBytes == null
        ? Container(
            width: 128,
            height: 128,
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(5.0),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Design.lightestGray),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2))),
              ),
              onPressed: pickImage,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.control_point,
                      color: Design.lightGray,
                      size: 24,
                    ),
                    Text(
                      "adicionar foto",
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14,
                          color: Design.lightGray),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            width: 180,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: pickImage,
                      icon: const Icon(
                        Icons.change_circle,
                        color: Design.lightBlue,
                        size: 24,
                      ),
                    ),
                    IconButton(
                      onPressed: deleteImage,
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Design.google,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Design.accentBlue,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  ),
                  width: 180,
                  height: 180,
                  child: Image.memory(
                    imageBytes!,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          );
  }
}

// Image.memory(
//                   imageBytes!,
//                   fit: BoxFit.fill,
//                 ),

// Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       onPressed: pickImage,
//                       icon: const Icon(
//                         Icons.change_circle,
//                         color: Design.lightBlue,
//                         size: 24,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.delete_forever,
//                         color: Design.google,
//                         size: 24,
//                       ),
//                     ),
//                   ],
//                 ),
