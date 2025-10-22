// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/question.dart';
import '../providers/questionnaire_provider.dart';
import '../providers/score_provider.dart';
import 'result_page.dart';

class ScreeningPage extends ConsumerWidget {
  const ScreeningPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(questionsProvider);
    final qState = ref.watch(questionnaireProvider);

    final filled = qState.answers.length;
    final total = questions.length;
    final progress = total == 0 ? 0.0 : (filled / total).clamp(0.0, 1.0);

    String summaryText;
    if (total == 0) {
      summaryText = 'Tidak ada pertanyaan.';
    } else if (filled == 0) {
      summaryText = 'Belum ada jawaban. Silakan jawab pertanyaan di bawah.';
    } else if (filled < total) {
      summaryText =
          'Terisi $filled dari $total. Lengkapi semua pertanyaan untuk melihat hasil.';
    } else {
      summaryText =
          'Semua pertanyaan terisi. Tekan "Lihat Hasil" untuk melanjutkan.';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Screening InsightMind'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // indikator progres: jumlah terisi / total + progress bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Progres',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  '$filled/$total',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress == 0 ? 0.05 : progress,
              color: Colors.indigo,
              backgroundColor: Colors.indigo.shade100,
              minHeight: 8,
            ),
            const SizedBox(height: 12),

            // daftar pertanyaan (ListView di Expanded)
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: questions.length,
                separatorBuilder: (context, index) => const Divider(height: 24),
                itemBuilder: (context, index) {
                  final q = questions[index];
                  final selected = qState.answers[q.id];
                  return _QuestionTile(
                    question: q,
                    selectedScore: selected,
                    onSelected: (score) {
                      ref
                          .read(questionnaireProvider.notifier)
                          .selectAnswer(questionId: q.id, score: score);
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Ringkasan singkat + tombol preview
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        summaryText,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Ringkasan Jawaban'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0; i < questions.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Q${i + 1}: ${questions[i].text}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            qState.answers[questions[i].id]
                                                    ?.toString() ??
                                                '-',
                                            style: const TextStyle(
                                              color: Colors.indigo,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Tutup'),
                              ),
                              FilledButton(
                                onPressed: filled == total
                                    ? () {
                                        Navigator.pop(ctx);
                                        // transfer jawaban ke answersProvider (pipeline ResultPage)
                                        final answersOrdered = <int>[];
                                        for (final q in questions) {
                                          answersOrdered.add(
                                            qState.answers[q.id]!,
                                          );
                                        }
                                        ref
                                                .read(answersProvider.notifier)
                                                .state =
                                            answersOrdered;
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => const ResultPage(),
                                          ),
                                        );
                                      }
                                    : null,
                                child: const Text('Lihat Hasil'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Preview'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: FilledButton(
          onPressed: () {
            if (!qState.isComplete) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Lengkapi semua pertanyaan dulu.'),
                ),
              );
              return;
            }

            // Alirkan jawaban ke "answersProvider"
            final answersOrdered = <int>[];
            for (final q in questions) {
              answersOrdered.add(qState.answers[q.id]!);
            }
            ref.read(answersProvider.notifier).state = answersOrdered;

            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ResultPage()));
          },
          child: const Text('Lihat Hasil'),
        ),
      ),
    );
  }
}

class _QuestionTile extends StatelessWidget {
  final Question question;
  final int? selectedScore;
  final ValueChanged<int> onSelected;

  const _QuestionTile({
    required this.question,
    required this.selectedScore,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question.text, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Column(
          children: [
            for (final opt in question.options)
              RadioListTile<int>(
                value: opt.score,
                groupValue: selectedScore,
                onChanged: (int? v) {
                  if (v != null) onSelected(v);
                },
                title: Text(opt.label),
                dense: true,
                controlAffinity: ListTileControlAffinity.leading,
              ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
