import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:observer/presenters/add_humans_impl.dart';
import 'package:observer/presenters/interfaces/add_humans_presenter.dart';
import 'package:observer/views/interfaces/add_humans_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddHumansPage extends StatefulWidget {
  AddHumansPage({Key? key}) : super(key: key);

  final String title = "ЛЮДИ";
  Adapter adapter = Adapter();
  AddHumansPresenter presenter = AddHumansImpl();

  @override
  State<AddHumansPage> createState() => _AddHumansPageState();
}

class _AddHumansPageState extends State<AddHumansPage>
    implements AddHumansView {
  @override
  void initState() {
    super.initState();
    widget.presenter.setView(this);
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
                  icon: const Icon(Icons.done),
                  onPressed: () {
                    widget.presenter.submitClick();
                  },
                )),
          ],
        ),
        body: Align(
          child: SizedBox(
            width: 500,
            child: widget.adapter,
          ),
          alignment: Alignment.topCenter,
        ));
  }

  @override
  List<String> getHumans() {
    List<String> humans_copy = List.from(widget.adapter.humans);
    humans_copy.removeAt(humans_copy.length - 1);
    return humans_copy;
  }

  @override
  void goBack(List<String> humans) {
    Navigator.pop(context, humans);
  }

  @override
  void showMassage(String s) {
    Fluttertoast.showToast(
        msg: s, timeInSecForIosWeb: 2, webBgColor: "#ff9216");
  }
}

class Adapter extends StatefulWidget {
  Adapter({Key? key}) : super(key: key);

  final String title = "ЛЮДИ";

  List<String> humans = [];
  List<TextEditingController> _controllers = [];

  @override
  State<Adapter> createState() => _AdapterState();
}

class _AdapterState extends State<Adapter> {
  void addHuman(String human) {
    setState(() {
      widget.humans.add(human);
      widget._controllers.add(TextEditingController());
    });
  }

  @override
  void initState() {
    super.initState();
    addHuman("");
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget.humans.length,
      itemBuilder: (context, index) {
        if (index == widget.humans.length - 1) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: DottedBorder(
                  child: const Center(child: Icon(Icons.add)),
                  strokeWidth: 1,
                  color: Colors.grey),
            ),
            onTap: () {
              addHuman("");
            },
          );
        }
        final _controller = widget._controllers[index];
        return Card(
            color: Colors.white,
            child: Padding(
              child: TextFormField(
                onChanged: (value) {
                  widget.humans[index] = value;
                },
                controller: _controller,
                decoration:
                    const InputDecoration(hintText: 'введите email человека'),
              ),
              padding:
                  const EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
            ));
      },
    );
  }
}
