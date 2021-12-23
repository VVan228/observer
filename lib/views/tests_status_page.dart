import 'package:flutter/material.dart';
import 'package:observer/entities/test_status.dart';
import 'package:observer/presenters/interfaces/tests_status_presenter.dart';
import 'package:observer/presenters/tests_status_impl.dart';
import 'package:observer/views/interfaces/tests_status_view.dart';

class TestsStatusPage extends StatefulWidget {
  TestsStatusPage({Key? key}) : super(key: key);

  final String title = "ТЕСТЫ";

  TestsStatusPresenter presenter = TestsStatusImpl();

  @override
  State<TestsStatusPage> createState() => _TestsStatusPageState();
}

class _TestsStatusPageState extends State<TestsStatusPage>
    implements TestsStatusView {
  List<TestStatus> _data = [];

  void addItem(TestStatus status) {
    setState(() {
      _data.add(status);
    });
  }

  void removeItem(TestStatus status) {
    setState(() {
      _data.remove(status);
    });
  }

  @override
  void initState() {
    super.initState();
    widget.presenter.setView(this);
    widget.presenter.initialized();

    //addItem(TestStatus(name: "test name1", test: "test", status: 1));
    //addItem(TestStatus(name: "test name2", test: "test", status: 2));
    //addItem(TestStatus(name: "test name3", test: "test", status: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  widget.presenter.logoutClick();
                },
              ))
        ],
      ),
      body: Center(
        child: _data.isEmpty
            ? Text(
                'список тестов пуст',
                style: Theme.of(context).textTheme.headline4,
              )
            : Center(
                child: SizedBox(
                  width: 500,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      String L =
                          _data[index].status == 1 ? "отправлено" : "черновик";
                      Color C =
                          _data[index].status == 1 ? Colors.green : Colors.red;
                      return GestureDetector(
                          onTap: () {
                            widget.presenter.testStatusClick(_data[index]);
                          },
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_data[index].name),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(L),
                                      ),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                            color: C, shape: BoxShape.circle),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: IconButton(
                                          color: Colors.grey,
                                          onPressed: () {
                                            widget.presenter
                                                .removeTestStatusClick(
                                                    _data[index]);
                                          },
                                          icon: const Icon(Icons.delete),
                                          iconSize: 24,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String name = await getTestStatusName();
          widget.presenter.addTestClick(name);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void showMassage(String s) {
    debugPrint(s);
  }

  @override
  void addTestStatus(TestStatus status) {
    addItem(status);
  }

  @override
  void removeTestStatus(TestStatus status) {
    removeItem(status);
  }

  Future<String> getTestStatusName() async {
    final _nameController = TextEditingController();
    String res = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'submit password'),
            ),
          ),
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
              child: const Text('Approve'),
              onPressed: () {
                // debugPrint(_nameController.text + " alert");
                Navigator.pop(context, _nameController.text);
              },
            ),
          ],
        );
      },
    );
    return res;
  }

  Future _asyncInputDialog(BuildContext context) async {
    String teamName = '';
    return showDialog(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter current team'),
          content: new Row(
            children: [
              new Expanded(
                  child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Team Name', hintText: 'eg. Juventus F.C.'),
                onChanged: (value) {
                  teamName = value;
                },
              ))
            ],
          ),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(teamName);
              },
            ),
          ],
        );
      },
    );
  }
}

/*class ListAdapter extends StatefulWidget {
  TestsStatusPresenter presenter;
  ListAdapter(this.presenter);

  @override
  _ListAdapterState createState() => _ListAdapterState();
}

class _ListAdapterState extends State<ListAdapter> {
  List<TestStatus> _data = [
    TestStatus(test: "test", status: 1),
    TestStatus(test: "test", status: 2),
    TestStatus(test: "test", status: 1)
  ];

  @override
  Widget build(BuildContext context) {
    return _data.isEmpty
        ? Text(
            'список тестов пуст',
            style: Theme.of(context).textTheme.headline4,
          )
        : Center(
            child: SizedBox(
              width: 500,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  String L =
                      _data[index].status == 1 ? "отправлено" : "черновик";
                  Color C =
                      _data[index].status == 1 ? Colors.green : Colors.red;
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_data[index].test),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(L),
                              ),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: C, shape: BoxShape.circle),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}*/
