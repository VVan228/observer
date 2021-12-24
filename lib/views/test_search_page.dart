import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:observer/presenters/interfaces/test_search_presenter.dart';
import 'package:observer/presenters/test_search_impl.dart';
import 'package:observer/views/interfaces/test_search_view.dart';
import 'package:observer/views/sign_up_page.dart';

class TestSearchPage extends StatefulWidget {
  TestSearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestSearchPageState();
}

class _TestSearchPageState extends State<TestSearchPage> {
  final _searchController = TextEditingController();
  Adapter adapter = Adapter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              adapter.presenter.logoutClick();
            },
            icon: const Icon(Icons.logout),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: 400,
                    height: 35,
                    child: TextField(
                      controller: _searchController,
                      cursorHeight: 16,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  padding: EdgeInsets.only(left: 18, right: 18, bottom: 8),
                ),
              ),
              SizedBox(
                width: 43,
                height: 43,
                child: TextButton(
                  onPressed: () {
                    adapter.presenter.searchClick(_searchController.text);
                  },
                  child: const Icon(Icons.search),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                      return Colors.white;
                    }),
                  ),
                ),
              )
            ],
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: const Icon(Icons.done),
                  onPressed: () {
                    adapter.presenter.applyClick();
                  },
                ))
          ],
        ),
        body: Center(
          child: SizedBox(
            width: 500,
            child: adapter,
          ),
        ));
  }
}

class Adapter extends StatefulWidget {
  Adapter({Key? key}) : super(key: key);

  TestSearchPresenter presenter = TestSearchImpl();

  List<String> questions = [];
  List<List<String>> answers = [];
  List<List<bool>> selected = [];

  @override
  State<Adapter> createState() => _AdapterState();
}

class _AdapterState extends State<Adapter> implements TestSearchView {
  @override
  void addQuestion(String question, List<String> answers) {
    setState(() {
      widget.selected.add(List.filled(answers.length, false));
      widget.questions.add(question);
      widget.answers.add(answers);
    });
  }

  @override
  void initState() {
    super.initState();
    widget.presenter.setView(this);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget.questions.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Card(
                  color: Colors.white,
                  child: Padding(
                    child: Container(
                      child: Text(widget.questions[index]),
                      width: 500,
                    ),
                    padding: const EdgeInsets.only(
                        left: 18, right: 18, top: 9, bottom: 9),
                  )),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.answers[index].length,
              itemBuilder: (context2, index2) {
                Color? color = widget.selected[index][index2]
                    ? Colors.orange[50]
                    : Colors.white;
                return Container(
                  padding: const EdgeInsets.only(left: 20),
                  width: 400,
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> states) {
                          return color;
                        }),
                      ),
                      onPressed: () {
                        setState(() {
                          for (int i = 0;
                              i < widget.selected[index].length;
                              i++) {
                            widget.selected[index][i] = false;
                          }
                          widget.selected[index][index2] = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(widget.answers[index][index2])),
                      )),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Map<String, List<String>> getAnswers() {
    Map<String, List<String>> res = {};
    for (int i = 0; i < widget.questions.length; i++) {
      List<String> answ = [];
      for (int j = 0; j < widget.answers[i].length; j++) {
        if (widget.selected[i][j]) {
          answ.add(widget.answers[i][j]);
        }
      }
      res[widget.questions[i]] = answ;
    }
    return res;
  }

  @override
  void showMassage(String s) {
    Fluttertoast.showToast(
        msg: s, timeInSecForIosWeb: 2, webBgColor: "#ff9216");
  }

  @override
  void openStartPage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  @override
  void showImportantMassage(String s) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ваши результаты'),
          content: Text(s),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Colors.white;
                }),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Theme.of(context).colorScheme.secondary;
                }),
              ),
              child: const Text('ок'),
              onPressed: () {
                // debugPrint(_nameController.text + " alert");
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void clearQuestions() {
    setState(() {
      widget.questions.clear();
      widget.answers.clear();
      widget.selected.clear();
    });
  }
}
