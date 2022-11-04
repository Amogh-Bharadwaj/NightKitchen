import 'package:flutter/material.dart';
import 'package:night_kitchen/common/types.dart';

class RecipeCard extends StatelessWidget {
  final String recipeName;
  final List<RecipeTags> recipeTags;
  final Image recipeImage;

  const RecipeCard(
      {super.key,
      required this.recipeName,
      required this.recipeTags,
      required this.recipeImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(255, 15, 27, 47),
                      offset: Offset(2, 2))
                ],
                color: const Color.fromARGB(155, 25, 36, 55)),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(recipeName,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 48, 255, 214))),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: recipeTags
                                      .map((RecipeTags e) => Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 10, 0),
                                          child: Text(e.toShortString(),
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromARGB(
                                                      255, 150, 218, 255)))))
                                      .toList(),
                                )
                              ])),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: recipeImage,
                              ))),
                    ]))));
  }
}
