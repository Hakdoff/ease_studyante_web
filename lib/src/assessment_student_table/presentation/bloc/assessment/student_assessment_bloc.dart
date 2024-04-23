import 'package:ease_studyante_teacher_app/core/enum/view_status.dart';
import 'package:ease_studyante_teacher_app/src/assessment_student_table/data/models/student_assessment_model.dart';
import 'package:ease_studyante_teacher_app/src/assessment_student_table/domain/repositories/assessment_student_repository.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/data/models/student_list_response_model.dart';
import 'package:ease_studyante_teacher_app/src/section_student_table/domain/repositories/student_list_reopsitory.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'student_assessment_event.dart';
part 'student_assessment_state.dart';

class StudentAssessmentBloc
    extends Bloc<StudentAssessmentEvent, StudentAssessmentState> {
  final StudentAssessmentRepository studentAssessmentRepository;
  final StudentListRepository studentListRepository;

  StudentAssessmentBloc(
      {required this.studentAssessmentRepository,
      required this.studentListRepository})
      : super(AssessmentInitial(
          studentAssessmentModel: StudentAssessmentModel.empty(),
          studentListResponseModel: StudentListResponseModel.empty(),
        )) {
    on<OnGetStudentAssessmentEvent>(_onGetStudentAssessmentEvent);
    on<OnSearchStudent>(_onSearchStudent);
    on<OnPaginateStudentAssessmentEvent>(_onPaginateStudentAssessmentEvent);
    on<OnTypeAssessmentScore>(_onTypeAssessmentScore);
  }

  Future<void> _onTypeAssessmentScore(
      OnTypeAssessmentScore event, Emitter<StudentAssessmentState> emit) async {
    if (state.studentAssessmentModel.assessments.isNotEmpty &&
        !state.isOnSaveScore) {
      final maxMarks = double.parse(
              state.studentAssessmentModel.assessments.first.assessment.maxMark)
          .toInt();

      final assessments = [...state.studentAssessmentModel.assessments];
      final assessment = assessments[event.index];

      if (int.parse(event.value) <= maxMarks) {
        emit(state.copyWith(isOnSaveScore: true));

        // CREATE STUDENT ASSESSMENT when id is -1
        final response = await studentAssessmentRepository.saveStudentScore(
          id: assessment.id,
          assessmentId: assessment.assessment.id,
          studentId: assessment.student.id,
          obtainMarks: event.value,
        );

        assessments[event.index] = response;
        emit(
          state.copyWith(
            studentAssessmentModel:
                state.studentAssessmentModel.copyWith(assessments: assessments),
            isOnSaveScore: false,
          ),
        );
      } else {
        assessments[event.index] =
            assessment.copyWith(obtainedMarks: event.value);
        emit(
          state.copyWith(
            studentAssessmentModel:
                state.studentAssessmentModel.copyWith(assessments: assessments),
          ),
        );
      }
    }
  }

  Future<void> _onSearchStudent(
      OnSearchStudent event, Emitter<StudentAssessmentState> emit) async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));

    final studentAssessments =
        await studentAssessmentRepository.getStudentAssessment(
      sectionId: event.sectionId,
      subjectId: event.subjectId,
      assessmentId: event.assessmentId,
      studentName: event.studentName,
    );

    final students = await studentListRepository.getStudentList(
      section: event.sectionId,
      search: event.studentName,
    );

    final modifiedAssessmentList =
        studentAssessmentRepository.initStudentAssessments(
      studentAssessments: studentAssessments,
      students: students.students,
    );

    emit(
      state.copyWith(
        studentAssessmentModel: modifiedAssessmentList,
        studentListResponseModel: students,
        viewStatus: ViewStatus.successful,
      ),
    );

    final foundStudent = students.students.any((student) {
      final lowerStudentFirstName = student.user.firstName.toLowerCase();
      final lowerStudentLastName = student.user.lastName.toLowerCase();
      final lowerEventStudentName = event.studentName.toLowerCase();
      return lowerStudentFirstName == lowerEventStudentName ||
          lowerStudentLastName == lowerEventStudentName;
    });

    if (foundStudent) {
      emit(
        state.copyWith(
          studentAssessmentModel: modifiedAssessmentList,
          studentListResponseModel: students,
          viewStatus: ViewStatus.successful,
        ),
      );
    } else {
      emit(
        state.copyWith(
          studentAssessmentModel: modifiedAssessmentList,
          studentListResponseModel: students,
          viewStatus: ViewStatus.failed,
          errorMessage: 'Student not found.',
        ),
      );
    }
  }

  Future<void> _onGetStudentAssessmentEvent(OnGetStudentAssessmentEvent event,
      Emitter<StudentAssessmentState> emit) async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));

    final studentAssessments =
        await studentAssessmentRepository.getStudentAssessment(
      sectionId: event.sectionId,
      subjectId: event.subjectId,
      assessmentId: event.assessmentId,
    );

    final students =
        await studentListRepository.getStudentList(section: event.sectionId);

    final modifiedAssessmentList =
        studentAssessmentRepository.initStudentAssessments(
            studentAssessments: studentAssessments,
            students: students.students);

    emit(
      state.copyWith(
        studentAssessmentModel: modifiedAssessmentList,
        viewStatus: ViewStatus.successful,
      ),
    );
  }

  Future<void> _onPaginateStudentAssessmentEvent(
      OnPaginateStudentAssessmentEvent event,
      Emitter<StudentAssessmentState> emit) async {
    if (state.viewStatus == ViewStatus.successful &&
        state.studentAssessmentModel.nextPage != null) {
      emit(state.copyWith(viewStatus: ViewStatus.isPaginated));
      final studentAssessments =
          await studentAssessmentRepository.getStudentAssessment(
              sectionId: event.sectionId,
              subjectId: event.subjectId,
              assessmentId: event.assessmentId,
              nextPage: state.studentAssessmentModel.nextPage);

      final students = state.studentListResponseModel.students.isNotEmpty
          ? state.studentListResponseModel
          : await studentListRepository.getStudentList(
              section: event.sectionId);

      final modifiedAssessmentList =
          studentAssessmentRepository.initStudentAssessments(
              studentAssessments: studentAssessments,
              students: students.students);

      emit(
        state.copyWith(
          studentAssessmentModel: modifiedAssessmentList,
          viewStatus: ViewStatus.successful,
        ),
      );
    }
  }
}
