import 'package:observer/entities/result.dart';
import 'package:observer/models/Interfaces/database_model.dart';
import 'package:observer/models/database_impl.dart';
import 'package:observer/presenters/interfaces/statistics_presenter.dart';
import 'package:observer/views/interfaces/statistics_view.dart';
import 'package:flutter/services.dart';

class StatisticsImpl implements StatisticsPresenter {
  StatisticsView? _view;
  DatabaseModel _database = DatabaseImpl();

  @override
  void setView(StatisticsView view) {
    _view = view;
  }

  @override
  void onInit() async {
    List<Result?> result =
        await _database.getResultsFromTest(_view?.getTestLink().test ?? "");
    for (Result? res in result) {
      if (res != null) {
        _view?.addResult(res);
      }
    }
  }

  @override
  void shareClick() {
    Clipboard.setData(ClipboardData(text: _view?.getTestLink().test));
    _view?.showMassage("Ссылка скопирована в буфер обмена");
  }
}
