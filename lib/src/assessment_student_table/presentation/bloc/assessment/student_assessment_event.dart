part of 'student_assessment_bloc.dart';

abstract class StudentAssessmentEvent extends Equatable {
  const StudentAssessmentEvent();

  @override
  List<Object> get props => [];
}

class OnGetStudentAssessmentEvent extends StudentAssessmentEvent {
  final String assessmentId;
  final String sectionId;
  final String subjectId;
  final Assessment assessment;

  const OnGetStudentAssessmentEvent({
    required this.assessmentId,
    required this.sectionId,
    required this.subjectId,
    required this.assessment,
  });

  @override
  List<Object> get props => [
        assessmentId,
        subjectId,
        sectionId,
        assessment,
      ];
}

class OnPaginateStudentAssessmentEvent extends StudentAssessmentEvent {
  final String assessmentId;
  final String sectionId;
  final String subjectId;
  final Assessment assessment;

  const OnPaginateStudentAssessmentEvent({
    required this.assessmentId,
    required this.sectionId,
    required this.subjectId,
            required this.assessment,

  });

  @override
  List<Object> get props => [
        assessmentId,
        subjectId,
        sectionId,
        assessment,
      ];
}

class OnSearchStudent extends StudentAssessmentEvent {
  final String studentName;
  final String assessmentId;
  final String sectionId;
  final String subjectId;
  final Assessment assessment;

  const OnSearchStudent({
    required this.studentName,
    required this.assessmentId,
    required this.sectionId,
    required this.subjectId,
        required this.assessment,

  });

  @override
  List<Object> get props => [
        assessmentId,
        studentName,
        subjectId,
        sectionId,
        assessment,
      ];
}

class OnTypeAssessmentScore extends StudentAssessmentEvent {
  final String value;
  final int index;

  const OnTypeAssessmentScore({
    required this.value,
    required this.index,
  });

  @override
  List<Object> get props => [
        value,
        index,
      ];
}
