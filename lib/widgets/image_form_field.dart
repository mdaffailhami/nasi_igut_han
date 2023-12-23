import 'package:flutter/material.dart';

class MyImageFormField extends StatelessWidget {
  const MyImageFormField({
    super.key,
    required this.label,
    required this.image,
    required this.onGantiButtonPressed,
  });
  final String label;
  final ImageProvider image;
  final Function() onGantiButtonPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 300,
        height: 45,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.primary)),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image(image: image, fit: BoxFit.cover),
                      const SizedBox(child: ColoredBox(color: Colors.black45)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: FilledButton(
                    onPressed: onGantiButtonPressed,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(14),
                      ),
                    ),
                    child: const Text('Ganti'),
                  ),
                )
              ],
            ),
            Positioned.fill(
              left: 10,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
