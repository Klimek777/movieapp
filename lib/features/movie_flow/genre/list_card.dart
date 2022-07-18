import 'package:flutter/material.dart';
import 'package:movieapp/%20core/constants.dart';

import 'genre.dart';

class ListCaerd extends StatelessWidget {
  const ListCaerd({Key? key, required this.genre, required this.onTap})
      : super(key: key);
  final Genre genre;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Material(
        color: genre.isSelected
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: InkWell(
            borderRadius: BorderRadius.circular(kBorderRadius),
            onTap: onTap,
            child: Container(
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                genre.name,
                textAlign: TextAlign.center,
              ),
            )),
      ),
    );
  }
}
