import 'package:collection/collection.dart';
import 'package:ease_studyante_teacher_app/core/enum/assessment_type.dart';
import 'package:ease_studyante_teacher_app/core/enum/grading_period.dart';
import 'package:ease_studyante_teacher_app/core/enum/task_type.dart';
import 'package:ease_studyante_teacher_app/core/extensions/string_extension.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/presentation/bloc/assessment/assessment_bloc.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/presentation/bloc/assessment_filter/assessment_filter_cubit.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/presentation/widgets/assessment_filter_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AssessmentFilter extends StatelessWidget {
  const AssessmentFilter({
    super.key,
    required this.search,
    required this.subjectId,
  });

  final String search;
  final String subjectId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentFilterCubit, AssessmentFilterState>(
      builder: (context, state) {
        return Row(
          children: [
            if (state.gradingPeriods.isNotEmpty) ...[
              AssessmentFilterField(
                title: 'Grading Period',
                items: [
                  "ALL",
                  ...state.gradingPeriods
                      .map((e) => e.name.toEnumString())
                      .toList()
                ],
                onChanged: (value) {
                  GradingPeriod? gradingPeriodValue;
                  if (value != null) {
                    gradingPeriodValue = GradingPeriod.values
                        .firstWhereOrNull((e) => e.name == toEnumValue(value));
                  }
                  context
                      .read<AssessmentFilterCubit>()
                      .onChangedGradingPeriod(gradingPeriodValue);
                  context.read<AssessmentBloc>().add(
                        OnFilterAssessmentEvent(
                          subjectId: subjectId,
                          activityName: search,
                          assessmentType: state.selectedAssessmentType,
                          gradingPeriod: gradingPeriodValue,
                          taskType: state.selectedTaskType,
                        ),
                      );
                },
                selectedValue: state.selectedGradingPeriod?.name.toEnumString(),
              ),
              const Gap(5),
            ],
            if (state.taskTypes.isNotEmpty) ...[
              AssessmentFilterField(
                title: 'Task Types',
                items: [
                  "ALL",
                  ...state.taskTypes.map((e) => e.name.toEnumString()).toList()
                ],
                onChanged: (value) {
                  TaskType? taskValue;

                  if (value != null) {
                    taskValue = TaskType.values
                        .firstWhereOrNull((e) => e.name == toEnumValue(value));
                  }
                  context
                      .read<AssessmentFilterCubit>()
                      .onChangedTaskType(taskValue);

                  context.read<AssessmentBloc>().add(
                        OnFilterAssessmentEvent(
                          subjectId: subjectId,
                          activityName: search,
                          assessmentType: state.selectedAssessmentType,
                          gradingPeriod: state.selectedGradingPeriod,
                          taskType: taskValue,
                          isAsceding:
                              context.read<AssessmentBloc>().state.isAscending,
                        ),
                      );
                },
                selectedValue: state.selectedTaskType?.name.toEnumString(),
              ),
              const Gap(5),
            ],
            if (state.assessmentTypes.isNotEmpty) ...[
              AssessmentFilterField(
                title: 'Assessment Types',
                items: [
                  "ALL",
                  ...state.assessmentTypes
                      .map((e) => e.name.toEnumString())
                      .toList()
                ],
                onChanged: (value) {
                  AssessmentType? assessmentTypeValue;
                  if (value != null) {
                    assessmentTypeValue = AssessmentType.values
                        .firstWhereOrNull((e) => e.name == toEnumValue(value));
                  }
                  context
                      .read<AssessmentFilterCubit>()
                      .onChangedAssessmentType(assessmentTypeValue);

                  context.read<AssessmentBloc>().add(
                        OnFilterAssessmentEvent(
                          subjectId: subjectId,
                          activityName: search,
                          assessmentType: assessmentTypeValue,
                          gradingPeriod: state.selectedGradingPeriod,
                          taskType: state.selectedTaskType,
                        ),
                      );
                },
                selectedValue:
                    state.selectedAssessmentType?.name.toEnumString(),
              )
            ]
          ],
        );
      },
    );
  }

  String toEnumValue(String value) {
    return value.split(' ').join('_').toUpperCase();
  }
}
