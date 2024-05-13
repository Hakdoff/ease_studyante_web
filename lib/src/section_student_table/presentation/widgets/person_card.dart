import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:ease_studyante_teacher_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_teacher_app/gen/colors.gen.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
    required this.gender,
    required this.age,
    this.yearLevel,
    this.lrn,
    this.profilePhoto,
    this.section,
    this.extraButtons,
  }) : super(key: key);

  final List<Widget>? extraButtons;
  final String firstName;
  final String lastName;

  final String contactNumber;
  final String gender;
  final String? lrn;
  final String age;
  final String? yearLevel;
  final String? profilePhoto;
  final String? section;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorName.gray,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: ColorName.primary,
                  backgroundImage: Image.network(profilePhoto != null
                          ? profilePhoto!
                          : 'https://th.bing.com/th/id/R.9a4c3cc6e8928e372c32915e37318c67?rik=bxsyV7oCWBYugA&riu=http%3a%2f%2fgazettereview.com%2fwp-content%2fuploads%2f2016%2f03%2ffacebook-avatar.jpg&ehk=yU5RmL%2fwcnpEsVQKx6wsiphi9t%2fUnNSgM3IO9ddXrzU%3d&risl=&pid=ImgRaw&r=0')
                      .image,
                  radius: 55,
                ),
                const Gap(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      text: '$firstName $lastName',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                    const Gap(10),
                    if (section != null && yearLevel != null) ...[
                      CustomText(
                        text: '$yearLevel - $section',
                        style: const TextStyle(
                          fontSize: 15,
                          color: ColorName.placeHolder,
                        ),
                      ),
                      const Gap(8),
                    ],
                    CustomText(
                      text: 'Contact Number: $contactNumber',
                      style: const TextStyle(
                        fontSize: 15,
                        color: ColorName.placeHolder,
                      ),
                    ),
                    const Gap(8),
                    CustomText(
                      text: 'Gender: ${gender == 'M' ? "Male" : "Female"}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: ColorName.placeHolder,
                      ),
                    ),
                    const Gap(8),
                    CustomText(
                      text: 'Learner Reference Number: $lrn',
                      style: const TextStyle(
                        fontSize: 15,
                        color: ColorName.placeHolder,
                      ),
                    ),
                    const Gap(8),
                    CustomText(
                      text: 'Age: $age years old',
                      style: const TextStyle(
                        fontSize: 15,
                        color: ColorName.placeHolder,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (extraButtons != null) ...[
            Column(
              children: [...extraButtons!],
            )
          ]
        ],
      ),
    );
  }
}
