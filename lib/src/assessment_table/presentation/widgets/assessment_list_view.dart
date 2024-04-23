import 'package:data_table_2/data_table_2.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_teacher_app/core/common_widget/shimmer.dart';
import 'package:ease_studyante_teacher_app/core/config/app_constant.dart';
import 'package:ease_studyante_teacher_app/core/extensions/string_extension.dart';
import 'package:ease_studyante_teacher_app/gen/colors.gen.dart';
import 'package:ease_studyante_teacher_app/src/assessment_table/domain/entities/assessment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssessmentListView extends StatelessWidget {
  const AssessmentListView({
    super.key,
    required this.scrollController,
    required this.isPaginate,
    required this.assessments,
    required this.onTap,
    required this.onTapSort,
    this.isAscending,
  });

  final ScrollController scrollController;
  final bool isPaginate;
  final List<Assessment> assessments;
  final Function(Assessment assessment) onTap;
  final bool? isAscending;
  final VoidCallback onTapSort;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      clipBehavior: Clip.hardEdge,
      scrollController: scrollController,
      isVerticalScrollBarVisible: true,
      isHorizontalScrollBarVisible: true,
      sortColumnIndex: isAscending != null ? 1 : null,
      sortAscending: isAscending ?? true,
      sortArrowBuilder: isAscending != null
          ? (ascending, sorted) {
              return Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(
                  !ascending
                      ? CupertinoIcons.arrow_up
                      : CupertinoIcons.arrow_down,
                  size: 17,
                  color: Colors.white,
                ),
              );
            }
          : null,
      headingRowDecoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: ColorName.primary,
      ),
      headingTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      columns: [
        const DataColumn2(
          fixedWidth: 50,
          numeric: true,
          label: FittedBox(
            child: Text(
              '#',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn2(
          onSort: (columnIndex, ascending) {
            onTapSort();
          },
          label: const FittedBox(
            child: Text(
              'Activity Name',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        const DataColumn2(
          label: FittedBox(
            child: Text(
              'Task Type',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        const DataColumn2(
          label: FittedBox(
            child: Text(
              'Assessment Type',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        const DataColumn2(
          label: FittedBox(
            child: Text(
              'Grading Period',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        const DataColumn2(
          fixedWidth: 75,
          label: FittedBox(
            child: Text(
              'Action',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: dataRows(context),
    );
  }

  List<DataRow> dataRows(BuildContext context) {
    final widgets = assessments
        .map(
          (e) => DataRow(
            color: MaterialStateProperty.all(Colors.white),
            cells: [
              DataCell(Text('${assessments.indexOf(e) + 1}')),
              DataCell(
                Text(e.name),
              ),
              DataCell(Text(e.taskType.toEnumString())),
              DataCell(Text(e.assessmentType.toEnumString())),
              DataCell(Text(e.gradingPeriod.toEnumString())),
              DataCell(CustomBtn(
                label: 'View',
                btnStyle: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: ColorName.primary),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                style: const TextStyle(color: ColorName.placeHolder),
                height: 30,
                onTap: () {
                  onTap(e);
                },
              )),
            ],
          ),
        )
        .toList();

    if (isPaginate) {
      widgets.add(
        DataRow(
          color: MaterialStateProperty.all(Colors.white),
          cells: const [
            DataCell(
              Shimmer(
                linearGradient: AppConstant.shimmerGradient,
                child: ShimmerLoading(
                  isLoading: true,
                  child: Text(''),
                ),
              ),
            ),
            DataCell(
              Shimmer(
                linearGradient: AppConstant.shimmerGradient,
                child: ShimmerLoading(
                  isLoading: true,
                  child: Text(''),
                ),
              ),
            ),
            DataCell(
              Shimmer(
                linearGradient: AppConstant.shimmerGradient,
                child: ShimmerLoading(
                  isLoading: true,
                  child: Text(''),
                ),
              ),
            ),
            DataCell(
              Shimmer(
                linearGradient: AppConstant.shimmerGradient,
                child: ShimmerLoading(
                  isLoading: true,
                  child: Text(''),
                ),
              ),
            ),
            DataCell(
              Shimmer(
                linearGradient: AppConstant.shimmerGradient,
                child: ShimmerLoading(
                  isLoading: true,
                  child: Text(''),
                ),
              ),
            ),
            DataCell(
              Shimmer(
                linearGradient: AppConstant.shimmerGradient,
                child: ShimmerLoading(
                  isLoading: true,
                  child: Text(''),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return widgets;
  }
}
