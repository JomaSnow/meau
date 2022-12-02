import 'package:app/util/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImagePickerButton extends StatelessWidget {
  const ImagePickerButton({
    super.key,
    this.error = "",
    required this.imageBytes,
    required this.pickImage,
    required this.deleteImage,
  });

  final String error;
  final Uint8List? imageBytes;
  final VoidCallback pickImage;
  final VoidCallback deleteImage;

  @override
  Widget build(BuildContext context) {
    return imageBytes == null
        ? Column(
            children: [
              Container(
                decoration: error != ""
                    ? BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      )
                    : null,
                width: 128,
                height: 128,
                margin: error != ""
                    ? const EdgeInsets.only(top: 30, bottom: 10)
                    : const EdgeInsets.symmetric(vertical: 30),
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
              ),
              error != ""
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Text(
                        error,
                        style: const TextStyle(fontSize: 12, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Container(),
            ],
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
