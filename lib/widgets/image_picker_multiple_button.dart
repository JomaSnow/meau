import 'package:app/util/design.dart';
import 'package:app/widgets/custom_paragraph.dart';
import 'package:app/widgets/link_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImagePickerMultipleButton extends StatelessWidget {
  const ImagePickerMultipleButton({
    super.key,
    this.error = "",
    this.maxImgs = 6,
    required this.imageBytes,
    required this.pickImage,
    required this.deleteImage,
  });

  final String error;
  final int maxImgs;
  final List<Uint8List?> imageBytes;
  final VoidCallback pickImage;
  final VoidCallback deleteImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        imageBytes.isNotEmpty
            ? Column(
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      for (var img in imageBytes)
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Design.primaryYellow)),
                          child: Image.memory(
                            img!,
                            fit: BoxFit.fill,
                            width: 100,
                            height: 100,
                          ),
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: LinkButton(
                            value: "Limpar seleção", onPressed: deleteImage),
                      ),
                      Expanded(
                        child: CustomParagraph(
                            value: "${imageBytes.length}/$maxImgs"),
                      ),
                    ],
                  ),
                ],
              )
            : Container(),
        imageBytes.length < maxImgs
            ? Container(
                decoration: error != ""
                    ? BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      )
                    : null,
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
                          "adicionar fotos",
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
            : Container(),
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
    );
  }
}
