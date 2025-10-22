import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/question.dart';

class QuestionnaireState {
  final Map<String, int> answers;
  const QuestionnaireState({this.answers = const {}});
  QuestionnaireState copyWith({Map<String, int>? answers}) =>
      QuestionnaireState(answers: answers ?? this.answers);
  bool get isComplete => answers.length >= defaultQuestions.length;
}

class QuestionnaireNotifier extends StateNotifier<QuestionnaireState> {
  QuestionnaireNotifier() : super(const QuestionnaireState());

  void selectAnswer({required String questionId, required int score}) {
    final newMap = Map<String, int>.from(state.answers);
    newMap[questionId] = score;
    state = state.copyWith(answers: newMap);
  }

  void reset() => state = const QuestionnaireState();
}

final questionsProvider = Provider<List<Question>>((ref) => defaultQuestions);

final questionnaireProvider =
    StateNotifierProvider<QuestionnaireNotifier, QuestionnaireState>(
      (ref) => QuestionnaireNotifier(),
    );
