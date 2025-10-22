class AnswerOption {
  final String label; // contoh: "Tidak Pernah", "Beberapa Hari", ...
  final int score; // 0..3

  const AnswerOption({required this.label, required this.score});
}

class Question {
  final String id;
  final String text;
  final List<AnswerOption> options;

  const Question({required this.id, required this.text, required this.options});
}

const defaultQuestions = <Question>[
  Question(
    id: 'q1',
    text:
        'Dalam 2 minggu terakhir, seberapa sering Anda merasa sedih atau murung?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Beberapa Hari', score: 1),
      AnswerOption(label: 'Lebih dari Separuh Hari', score: 2),
      AnswerOption(label: 'Hampir Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q2',
    text: 'Kesulitan menikmati hal-hal yang biasanya menyenangkan?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Beberapa Hari', score: 1),
      AnswerOption(label: 'Lebih dari Separuh Hari', score: 2),
      AnswerOption(label: 'Hampir Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q3',
    text:
        'Apakah Anda mengalami kesulitan tidur (terlalu sedikit/terlalu banyak)?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Beberapa Hari', score: 1),
      AnswerOption(label: 'Lebih dari Separuh Hari', score: 2),
      AnswerOption(label: 'Hampir Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q4',
    text: 'Merasa mudah marah atau gelisah dibandingkan biasanya?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Beberapa Hari', score: 1),
      AnswerOption(label: 'Lebih dari Separuh Hari', score: 2),
      AnswerOption(label: 'Hampir Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q5',
    text: 'Sulit berkonsentrasi pada tugas sehari-hari?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Beberapa Hari', score: 1),
      AnswerOption(label: 'Lebih dari Separuh Hari', score: 2),
      AnswerOption(label: 'Hampir Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q6',
    text: 'Merasa cemas atau khawatir berlebihan?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Beberapa Hari', score: 1),
      AnswerOption(label: 'Lebih dari Separuh Hari', score: 2),
      AnswerOption(label: 'Hampir Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q7',
    text: 'Berhenti melakukan kegiatan yang biasanya Anda nikmati?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Beberapa Hari', score: 1),
      AnswerOption(label: 'Lebih dari Separuh Hari', score: 2),
      AnswerOption(label: 'Hampir Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q8',
    text: 'Perubahan nafsu makan (lebih/kurang dari biasanya)?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Beberapa Hari', score: 1),
      AnswerOption(label: 'Lebih dari Separuh Hari', score: 2),
      AnswerOption(label: 'Hampir Setiap Hari', score: 3),
    ],
  ),
  Question(
    id: 'q9',
    text: 'Merasa sangat lelah atau kurang energi dalam aktivitas sehari-hari?',
    options: [
      AnswerOption(label: 'Tidak Pernah', score: 0),
      AnswerOption(label: 'Beberapa Hari', score: 1),
      AnswerOption(label: 'Lebih dari Separuh Hari', score: 2),
      AnswerOption(label: 'Hampir Setiap Hari', score: 3),
    ],
  ),
];
