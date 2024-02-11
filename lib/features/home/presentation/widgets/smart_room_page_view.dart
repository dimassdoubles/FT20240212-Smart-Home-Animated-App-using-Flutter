import 'package:flutter/material.dart';

import '../../../../core/shared/domain/entities/smart_room.dart';
import '../../../../core/shared/presentation/widgets/room_card.dart';
import '../../../smart_room/screens/room_details_screen.dart';

class SmartRoomsPageView extends StatelessWidget {
  const SmartRoomsPageView({
    super.key,
    required this.controller,
    required this.pageNotifier,
    required this.roomSelectorNotifier,
  });

  final PageController controller;
  final ValueNotifier pageNotifier;
  final ValueNotifier roomSelectorNotifier;

  double _getOffsetX(double percent) => percent.isNegative ? 30 : -30;
  Matrix4 _getOutTranslate({
    required double percent,
    required int selectedRoom,
    required int index,
  }) {
    // menyingkirkan card yang tidak ditengah
    // ketika card ditengah di expand (diswipe ke atas)
    final double x =
        selectedRoom != index && selectedRoom != -1 ? _getOffsetX(percent) : 0;

    return Matrix4.translationValues(x, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageNotifier,
        builder: (_, page, __) {
          return ValueListenableBuilder(
              valueListenable: roomSelectorNotifier,
              builder: (_, selectedRoom, __) {
                return PageView.builder(
                  controller: controller,
                  clipBehavior: Clip.none,
                  itemCount: SmartRoom.fakeValues.length,
                  itemBuilder: (_, index) {
                    final room = SmartRoom.fakeValues[index];
                    double percent = page - index;
                    debugPrint('${room.name} Hello percent pageView: $percent');
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      transform: _getOutTranslate(
                        percent: percent,
                        selectedRoom: selectedRoom,
                        index: index,
                      ),
                      child: RoomCard(
                        percent: percent,
                        // If -1 then no item is selected
                        expand: selectedRoom == index,
                        room: room,
                        onSwipeUp: () => roomSelectorNotifier.value = index,
                        onSwipeDown: () => roomSelectorNotifier.value = -1,
                        onTap: () {
                          if (selectedRoom == index || true) {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 800),
                                reverseTransitionDuration:
                                    const Duration(milliseconds: 800),
                                pageBuilder: (_, animation, __) =>
                                    FadeTransition(
                                  opacity: animation,
                                  child: RoomDetailScreen(room: room),
                                ),
                              ),
                            );

                            roomSelectorNotifier.value = -1;
                          }
                        },
                      ),
                    );
                  },
                );
              });
        });
  }
}
