// Dummy file to satisfy conditional imports on web
class File {
  File(String path);
  Future<List<int>> readAsBytes() async => [];
}
