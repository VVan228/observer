import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:observer/entities/question.dart';
import 'package:observer/entities/test_status.dart';
import 'package:observer/presenters/create_test_impl.dart';
import 'package:observer/presenters/interfaces/create_test_presenter.dart';
import 'package:observer/views/add_humans_page.dart';
import 'package:observer/views/interfaces/create_test_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateTestPage extends StatefulWidget {
  CreateTestPage({Key? key, required this.test}) : super(key: key);

  TestStatus test;
  List<String> humans = [];
  final String title = "ВОПРОСЫ";

  @override
  State<CreateTestPage> createState() => _CreateTestPageState();
}

class _CreateTestPageState extends State<CreateTestPage>
    implements CreateTestView {
  Adapter adapter = Adapter();
  CreateTestPresenter presenter = CreateTestImpl();

  @override
  void initState() {
    super.initState();
    presenter.setView(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: const Icon(Icons.people),
                  onPressed: () {
                    presenter.addPeopleClick();
                  },
                )),
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    presenter.saveClick();
                  },
                )),
          ],
        ),
        body: Align(
          child: SizedBox(
            width: 500,
            child: adapter,
          ),
          alignment: Alignment.topCenter,
        ));
  }

  @override
  List<Question> getQuestions() {
    return adapter.getQuestions();
  }

  @override
  TestStatus getTestStatus() {
    return widget.test;
  }

  @override
  void goBack() {
    Navigator.pop(context, true);
  }

  @override
  void showMassage(String s) {
    Fluttertoast.showToast(
        msg: s, timeInSecForIosWeb: 2, webBgColor: "#ff9216");
  }

  @override
  List<String> getHumans() {
    return widget.humans;
  }

  @override
  void openAddHumansPage() {
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddHumansPage()))
        .then((value) {
      if (value != null) {
        widget.humans = value;
      }
    });
  }
}

class Adapter extends StatefulWidget {
  Adapter({Key? key}) : super(key: key);

  final String title = "ТЕСТЫ";

  List<List<TextEditingController>> _answer_controllers = [];
  List<TextEditingController> _questions_controllers = [];
  List<List<bool>> _correct_answers = [];
  List<Question> _data = [];

  List<Question> getQuestions() {
    for (int i = 0; i < _data.length - 1; i++) {
      List<String> r = [];
      List<String> w = [];
      for (int j = 0; j < _data[i].wrong.length - 1; j++) {
        if (_correct_answers[i][j]) {
          r.add(_data[i].wrong[j]);
        } else {
          w.add(_data[i].wrong[j]);
        }
      }
      _data[i].wrong = w;
      _data[i].right = r;
    }
    _data.removeAt(_data.length - 1);
    return _data;
  }

  @override
  State<Adapter> createState() => _AdapterState();
}

class _AdapterState extends State<Adapter> {
  void addQuestion(Question q) {
    widget._answer_controllers.add([]);
    widget._correct_answers.add([]);
    widget._questions_controllers.add(TextEditingController());
    setState(() {
      q.wrong.add("");
      widget._data.add(q);
    });
  }

  void addWronAnswer(int i, String answer) {
    widget._correct_answers[i].add(false);
    widget._answer_controllers[i].add(TextEditingController());
    setState(() {
      widget._data[i].wrong.add(answer);
    });
  }

  @override
  void initState() {
    super.initState();
    addQuestion(
        Question(question: "", type: 1, factor: 1, right: [], wrong: []));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget._data.length,
      itemBuilder: (context, index) {
        if (index == widget._data.length - 1) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: DottedBorder(
                  child: const Center(child: Icon(Icons.add)),
                  strokeWidth: 1,
                  color: Colors.grey),
            ),
            onTap: () {
              addQuestion(Question(
                  question: "", type: 1, factor: 1, right: [], wrong: []));
            },
          );
        }
        final _questionController = widget._questions_controllers[index];
        return Column(
          children: [
            Card(
                color: Colors.orange[100],
                child: Padding(
                  child: TextFormField(
                    onChanged: (value) {
                      widget._data[index].question = value;
                    },
                    controller: _questionController,
                    decoration:
                        const InputDecoration(hintText: 'введите вопрос'),
                  ),
                  padding: const EdgeInsets.only(
                      left: 18, right: 18, top: 9, bottom: 9),
                )),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context2, index2) {
                if (index2 == widget._data[index].wrong.length - 1) {
                  return GestureDetector(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 50, right: 50, bottom: 9),
                      child: DottedBorder(
                          child: const Center(child: Icon(Icons.add)),
                          strokeWidth: 1,
                          color: Colors.grey),
                    ),
                    onTap: () {
                      addWronAnswer(index, "");
                    },
                  );
                }
                final _answerController =
                    widget._answer_controllers[index][index2];
                return SizedBox(
                    width: 80,
                    height: 80,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            color: Colors.white,
                            child: Padding(
                              child: Container(
                                width: 350,
                                child: TextFormField(
                                  onChanged: (value) {
                                    widget._data[index].wrong[index2] = value;
                                  },
                                  controller: _answerController,
                                  decoration: const InputDecoration(
                                      hintText: 'введите ответ'),
                                ),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 9, bottom: 9),
                            ),
                          ),
                          Checkbox(
                              value: widget._correct_answers[index][index2],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    widget._correct_answers[index][index2] =
                                        value;
                                  });
                                }
                              })
                        ],
                      ),
                    ));
              },
              itemCount: widget._data[index].wrong.length,
            ),
          ],
        );
      },
    );
  }
}
