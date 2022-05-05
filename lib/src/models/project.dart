class Project {
  String? idx;
  String title;
  String notes;
  String imageUrl;

  Project(
      {required this.title,
      required this.notes,
      required this.imageUrl,
      this.idx});
}
