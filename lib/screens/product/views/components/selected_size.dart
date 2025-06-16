import 'package:flutter/material.dart';

import '../../../../constants.dart';

class SelectedSize extends StatelessWidget {
  const SelectedSize({
    super.key,
    required this.sizes,
    required this.selectedIndex,
    required this.press, required this.title,
  });

  final List<String> sizes;
  final int selectedIndex;
  final ValueChanged<int> press;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Row(
          children: List.generate(
            sizes.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? defaultPadding : defaultPadding / 2),
              child: GestureDetector(
                onTap: () => press(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding /2),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: index == selectedIndex ?Colors.grey : Colors.black )
                  ),
                  alignment: const Alignment(0, 0),
                  child:  Text(
                    sizes[index].toUpperCase(),
                    style: TextStyle(
                        color: selectedIndex == index
                            ? primaryColor
                            : Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                ),
              ),

            ),
          ),
        )
      ],
    );
  }
}

class SizeButton extends StatelessWidget {
  const SizeButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.press,
  });

  final String text;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: OutlinedButton(
        onPressed: press,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          side: isActive ? const BorderSide(color: primaryColor) : null,
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
              color: isActive
                  ? primaryColor
                  : Theme.of(context).textTheme.bodyLarge!.color),
        ),
      ),
    );
  }
}
