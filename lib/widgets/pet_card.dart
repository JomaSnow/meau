import 'dart:developer';

import 'package:app/models/pet_model.dart';
import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class PetCard extends StatelessWidget {
  const PetCard({
    super.key,
    required this.pet,
    this.isOwner = false,
  });

  final PetModel pet;
  final bool isOwner;
  final TextStyle cardInfo = const TextStyle(
      color: Design.darkerGray, fontSize: 12, fontFamily: "Roboto");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Design.white,
        boxShadow: [
          BoxShadow(
              color: Design.lighterGray,
              blurRadius: 1,
              spreadRadius: 0,
              offset: Offset(-1, 3)),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(top: 16, left: 4, right: 4),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          decoration: BoxDecoration(
            color: isOwner ? Design.accentBlue : Design.lightYellow,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pet.nome,
                style: const TextStyle(
                    color: Design.darkerGray,
                    fontSize: 16,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500),
              ),
              isOwner
                  ? pet.hasInterest
                      ? IconButton(
                          onPressed: () {
                            log("toggle interest");
                          },
                          icon: const Icon(
                            Icons.error,
                            color: Design.darkerGray,
                            size: 24,
                          ),
                        )
                      : const SizedBox(
                          height: 42,
                        )
                  : IconButton(
                      onPressed: () {
                        log("toggle favorite");
                      },
                      icon: const Icon(
                        Icons.favorite_outline,
                        color: Design.darkerGray,
                        size: 24,
                      ),
                    ),
            ],
          ),
        ),
        SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.memory(pet.imgArr![0]!, fit: BoxFit.fill)),
        Container(
          height: 48,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: isOwner
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: isOwner
                    ? [
                        Text(
                          "0 NOVOS INTERESSADOS",
                          style: cardInfo,
                        )
                      ]
                    : [
                        Text(
                          pet.sexo.toUpperCase(),
                          style: cardInfo,
                        ),
                        Text(
                          pet.idade.toUpperCase(),
                          style: cardInfo,
                        ),
                        Text(
                          pet.porte.toUpperCase(),
                          style: cardInfo,
                        ),
                      ],
              ),
              isOwner
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        pet.isAdopt && !pet.isHelp
                            ? Text(
                                "ADOÇÃO",
                                style: cardInfo,
                              )
                            : pet.isFoster && !pet.isHelp
                                ? Text(
                                    "APADRINHAMENTO",
                                    style: cardInfo,
                                  )
                                : pet.isAdopt && pet.isHelp
                                    ? Text(
                                        "ADOÇÃO | AJUDA",
                                        style: cardInfo,
                                      )
                                    : pet.isFoster && pet.isHelp
                                        ? Text(
                                            "APADRINHAMENTO | AJUDA",
                                            style: cardInfo,
                                          )
                                        : Text(
                                            "AJUDA",
                                            style: cardInfo,
                                          )
                      ],
                    )
                  : Text(
                      pet.userAddress.toUpperCase(),
                      style: cardInfo,
                    ),
            ],
          ),
        ),
      ]),
    );
  }
}
