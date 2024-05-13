import 'package:ease_studyante_teacher_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_teacher_app/core/extensions/time_formatter.dart';
import 'package:ease_studyante_teacher_app/gen/assets.gen.dart';
import 'package:ease_studyante_teacher_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import 'package:ease_studyante_teacher_app/src/section/domain/entities/teacher_schedule.dart';
import 'package:gap/gap.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({
    Key? key,
    required this.schedule,
    required this.onTap,
  }) : super(key: key);

  final Schedule schedule;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      enableFeedback: true,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.30,
        width: MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.sectionCardBg.provider(),
            alignment: Alignment.centerRight,
            fit: BoxFit.contain,
            opacity: 0.35,
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: ColorName.primary,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomText(
              text: schedule.section.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 45,
              ),
            ),
            const Divider(
              color: ColorName.gray,
              thickness: 2,
            ),
            const Gap(10),
            CustomText(
              text: schedule.subject.name,
              style: const TextStyle(color: ColorName.placeHolder),
            ),
            const Gap(10),
            CustomText(
              text: 'Year Level ${schedule.section.yearLevel}',
              style: const TextStyle(color: ColorName.placeHolder),
            ),
            const Gap(10),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.schedule),
                  const Gap(5),
                  const Icon(
                    Icons.circle,
                    size: 5,
                    color: ColorName.placeHolder,
                  ),
                  const Gap(5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: schedule.day,
                        style: const TextStyle(color: ColorName.placeHolder),
                      ),
                      const Gap(5),
                      CustomText(
                        text:
                            '${schedule.timeStart.parseStrToTime()} - ${schedule.timeEnd.parseStrToTime()}',
                        style: const TextStyle(color: ColorName.placeHolder),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
