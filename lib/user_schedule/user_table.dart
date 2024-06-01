import 'package:flutter/material.dart';
import 'package:user_studify/custom_widgets.dart';
import 'package:user_studify/user_schedule/user_modal_bottom_sheet.dart';


class DayInTable extends StatelessWidget {
  final double width;
  final Map<String, dynamic> week;

  final BuildContext c;
  final double height;

  const DayInTable({
    Key? key,
    required this.week,
    required this.width,
    required this.c,
    required this.height,
  }) : super(key: key);
  static const List Days = [
    'saturday',
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(6, (index) {
          if (week.containsKey(Days[index])) {
            List<dynamic> day = week[Days[index]];
            return Container(
              margin: EdgeInsets.all(width / 10 * 0.25),
              height: width / 10 * 6,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: width / 10 * 0.75,
                    height: width / 10 * 6,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: FittedBox(
                        child: Text(Days[index]),
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(
                        6,
                            (index) => Container(
                          width: width / 10 * 0.75,
                          height: width / 10,
                          alignment: Alignment.center,
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(fontSize: 20),
                          ),
                        )),
                  ),
                  SizedBox(
                    width: width / 10 * 8,
                    height: width / 10 * 6,
                    child: Wrap(
                      children: List.generate(
                          day.length,
                              (elementIndex) => InkWell(
                              onTap: () {
                                userModalBottomSheet(
                                  elementIndex: elementIndex,
                                  day : Days[index],
                                  width: width,
                                  height: height,
                                  context: c,
                                  element: day[elementIndex],
                                );
                              },
                              child: Element_Container(
                                  element: day[elementIndex],
                                  screenWidth: width))),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        }),
      ],
    );
  }
}