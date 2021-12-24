import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:observer/entities/result.dart';
import 'package:observer/entities/test_status.dart';
import 'package:observer/presenters/interfaces/statistics_presenter.dart';
import 'package:observer/presenters/statistics_impl.dart';
import 'package:observer/views/interfaces/statistics_view.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key? key, required this.test}) : super(key: key);

  StatisticsPresenter presenter = StatisticsImpl();
  TestStatus test;

  TestStatus getTest() {
    return test;
  }

  @override
  State<StatefulWidget> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("СТАТИСТИКА"),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
                  onPressed: () {
                    widget.presenter.shareClick();
                  },
                  icon: const Icon(Icons.ios_share)),
            )
          ],
        ),
        body: Center(
          child: SizedBox(
              width: 500,
              child: Container(
                alignment: Alignment.topCenter,
                child: Adapter(
                  test: widget.test,
                  presenter: widget.presenter,
                ),
              )),
        ));
  }
}

class Adapter extends StatefulWidget {
  Adapter({key, required this.test, required this.presenter}) : super(key: key);

  StatisticsPresenter presenter;
  TestStatus test;

  List<Result> results = [];

  @override
  State<Adapter> createState() => _AdapterState();
}

class _AdapterState extends State<Adapter> implements StatisticsView {
  @override
  void showMassage(String s) {
    Fluttertoast.showToast(
        msg: s, timeInSecForIosWeb: 2, webBgColor: "#ff9216");
  }

  @override
  void addResult(Result res) {
    setState(() {
      widget.results.add(res);
    });
  }

  @override
  void initState() {
    super.initState();
    widget.presenter.setView(this);
    widget.presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return widget.results.length == 0
        ? Center(
            child: Text(
              "Статистики нет",
              style: Theme.of(context).textTheme.headline4,
            ),
          )
        : ListView.builder(
            // shrinkWrap: true,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.results.length,
            itemBuilder: (context, index) {
              double mainPersent = 1.0 *
                  widget.results[index].sumRating /
                  widget.results[index].sumMaxRating;
              Color? mainColor = null;
              if (mainPersent < 0.5) {
                mainColor = Colors.red;
              } else if (mainPersent < 0.8) {
                mainColor = Colors.yellow[800];
              } else {
                mainColor = Colors.green;
              }
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: 500,
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Card(
                                color: Colors.white,
                                child: Padding(
                                  child: Container(
                                    child: Text(widget.results[index].email),
                                    width: 400,
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 18, right: 18, top: 9, bottom: 9),
                                )),
                          ),
                          Text(
                            widget.results[index].sumRating.toString() +
                                "/" +
                                widget.results[index].sumMaxRating.toString(),
                            style: TextStyle(color: mainColor),
                          )
                        ],
                      )),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.results[index].rating.length,
                    itemBuilder: (context2, index2) {
                      String key =
                          widget.results[index].rating.keys.elementAt(index2);
                      double percent = 1.0 *
                          widget.results[index].rating[key]! /
                          widget.results[index].maxRating[key]!;
                      Color? color = null;
                      if (percent < 0.5) {
                        color = Colors.red;
                      } else if (percent < 0.8) {
                        color = Colors.yellow[800];
                      } else {
                        color = Colors.green;
                      }
                      return Container(
                          padding: const EdgeInsets.only(left: 20, right: 200),
                          width: 300,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      child: Card(
                                        color: Colors.grey[100],
                                        child: Padding(
                                          child: Text(key),
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 5,
                                              bottom: 5),
                                        ),
                                      ),
                                      width: 200,
                                    ),
                                  ),
                                  Text(
                                    widget.results[index].rating[key]!
                                            .toString() +
                                        "/" +
                                        widget.results[index].maxRating[key]!
                                            .toString(),
                                    style: TextStyle(color: color),
                                  )
                                ],
                              )));
                    },
                  ),
                ],
              );
            },
          );
  }

  @override
  TestStatus getTestLink() {
    return widget.test;
  }
}
