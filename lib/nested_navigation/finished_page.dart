import 'package:flutter/material.dart';

class FinishedPage extends StatelessWidget {
  final VoidCallback onFinishPressed;
  const FinishedPage({
    Key? key,
    required this.onFinishPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF222222),
                ),
                child: const Center(
                  child: Icon(
                    Icons.lightbulb,
                    size: 175,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Bulb added!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((_) {
                    return const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    );
                  }),
                  backgroundColor: MaterialStateColor.resolveWith((_) {
                    return const Color(0xFF222222);
                  }),
                  shape: MaterialStateProperty.resolveWith((_) {
                    return StadiumBorder();
                  }),
                ),
                onPressed: onFinishPressed,
                child: const Text('Finish', style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
