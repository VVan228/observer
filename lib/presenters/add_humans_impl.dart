import 'package:observer/models/Interfaces/database_model.dart';
import 'package:observer/models/database_impl.dart';
import 'package:observer/presenters/interfaces/add_humans_presenter.dart';
import 'package:observer/views/interfaces/add_humans_view.dart';

class AddHumansImpl implements AddHumansPresenter {
  AddHumansView? _view;

  @override
  void submitClick() {
    List<String>? humans = _view?.getHumans();
    if (humans != null) {
      bool flag = false;
      for (int i = 0; i < humans.length; i++) {
        if (humans[i] == "" ||
            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(humans[i])) {
          _view?.showMassage("почта " +
              (i + 1).toString() +
              " введена некорректно, повторите");
          return;
        }
      }
      _view?.goBack(humans);
    }
  }

  @override
  void setView(AddHumansView view) {
    _view = view;
  }
}
