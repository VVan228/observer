abstract class TestSearchView {
  void showMassage(String s) {}
  void showImportantMassage(String s) {}
  void addQuestion(String question, List<String> answers) {}
  Map<String, List<String>> getAnswers() {
    throw UnimplementedError();
  }

  void openStartPage() {}
}
