import 'package:dcli/dcli.dart';

class Menu {
  final List<String> choices;
  final String title;
  final int defaultValue;

  Menu(this.choices, {this.title = '',this.defaultValue=0});

  Answer choose() {
    // final dialog = CLI_Dialog(listQuestions: [
    //   [
    //     {'question': title, 'options': choices},
    //     'result'
    //   ]
    // ]);

    // final answer = dialog.ask();
    // final result = answer['result'] as String;
    print("");
    final result =
        menu(prompt: title, options: choices);
    final index = choices.indexOf(result);

    return Answer(result: result, index: index);
  }
}

class Answer {
  final String result;
  final int index;

  const Answer({required this.result, required this.index});
}
