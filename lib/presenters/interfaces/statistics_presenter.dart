import 'package:observer/views/interfaces/statistics_view.dart';

abstract class StatisticsPresenter {
  void setView(StatisticsView view) {}
  void onInit() {}
  void shareClick() {}
}
