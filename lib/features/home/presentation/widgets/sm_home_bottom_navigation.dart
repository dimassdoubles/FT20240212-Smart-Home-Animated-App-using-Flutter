import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SmHomeBottomNavigationBar extends StatelessWidget {
  const SmHomeBottomNavigationBar({
    super.key,
    required this.selectedRoomNotifier,
  });

  final ValueNotifier selectedRoomNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedRoomNotifier,
        builder: (_, selectedRoom, __) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: selectedRoom == -1 ? 1 : 0,
            child: AnimatedContainer(
              transform:
                  Matrix4.translationValues(0, selectedRoom == -1 ? 0 : -30, 0),
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 400),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(SHIcons.lock),
                      ),
                      label: 'UNLOCK',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(SHIcons.home),
                      ),
                      label: 'MAIN',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(SHIcons.settings),
                      ),
                      label: 'SETTINGS',
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
