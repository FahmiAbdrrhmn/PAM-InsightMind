import 'package:flutter_riverpod/flutter_riverpod.dart';

class MentalResultModel {
  final int score;
  final String riskLevel;
  MentalResultModel(this.score, this.riskLevel);
}

final answersProvider = StateProvider<List<int>>((ref) => []);

final resultProvider = Provider<MentalResultModel>((ref) {
  final answers = ref.watch(answersProvider);
  final score = answers.fold<int>(0, (p, n) => p + n);
  String level;
  if (score >= 12) {
    level = 'Tinggi';
  } else if (score >= 7) {
    level = 'Sedang';
  } else {
    level = 'Rendah';
  }
  return MentalResultModel(score, level);
});
