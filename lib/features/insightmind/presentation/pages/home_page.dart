import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/score_provider.dart';
import '../providers/questionnaire_provider.dart'; // to get defaultQuestions length
import 'screening_pages.dart';
import 'result_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(answersProvider);
    final totalQuestions = ref.read(questionsProvider).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('InsightMind - Home'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Selamat datang di InsightMind'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScreeningPage()),
                ),
                child: const Text('Mulai Screening'),
              ),
            ),
            const Spacer(),
            Wrap(
              spacing: 8,
              children: [for (var a in answers) Chip(label: Text('$a'))],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: answers.isEmpty
                    ? null
                    : () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ResultPage()),
                      ),
                child: const Text('Lihat Hasil'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
        onPressed: () {
          // batasi sampai jumlah pertanyaan
          final current = List<int>.from(ref.read(answersProvider));
          if (current.length >= totalQuestions) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sudah mencapai jumlah pertanyaan.'),
              ),
            );
            return;
          }
          final newValue = (DateTime.now().millisecondsSinceEpoch % 4).toInt();
          current.add(newValue);
          ref.read(answersProvider.notifier).state = current;
        },
      ),
    );
  }
}
