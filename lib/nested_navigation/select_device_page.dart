import 'package:flutter/material.dart';

class SelectDevicePage extends StatelessWidget {
  final void Function(String id) onDeviceSelected;
  const SelectDevicePage({
    Key? key,
    required this.onDeviceSelected,
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
              Text(
                'Select a nearby device:',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: _buildBulbButton,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildBulbButton {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((_) {
          return const Color(0xFF222222);
        }),
      ),
      onPressed: () => onDeviceSelected('22n483nk5834'),
      child: const Text(
        'Bulb 22n483nk5834',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
