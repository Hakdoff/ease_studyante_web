import 'dart:convert';

import 'package:equatable/equatable.dart';

class GradingPeriods extends Equatable {
  final DateTime gradingDeadline;
  final bool isOverrideEncoding;
  final String period;

  const GradingPeriods({
    required this.gradingDeadline,
    required this.isOverrideEncoding,
    required this.period,
  });

  GradingPeriods copyWith({
    DateTime? gradingDeadline,
    bool? isOverrideEncoding,
    String? period,
  }) {
    return GradingPeriods(
      gradingDeadline: gradingDeadline ?? this.gradingDeadline,
      isOverrideEncoding: isOverrideEncoding ?? this.isOverrideEncoding,
      period: period ?? this.period,
    );
  }

  factory GradingPeriods.fromMap(Map<String, dynamic> map) {
    return GradingPeriods(
      gradingDeadline: DateTime.parse(map['grading_deadline']),
      isOverrideEncoding: map['is_override_encoding'] ?? false,
      period: map['grading_period'] ?? '',
    );
  }

  factory GradingPeriods.fromJson(String source) =>
      GradingPeriods.fromMap(json.decode(source));

  @override
  List<Object> get props => [
        gradingDeadline,
        isOverrideEncoding,
        period,
      ];
}
