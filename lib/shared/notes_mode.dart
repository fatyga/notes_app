enum NotesListPageMode { list, selection, search, filter }

extension NotesModeX on NotesListPageMode {
  bool get isList => this == NotesListPageMode.list;
  bool get isSelection => this == NotesListPageMode.selection;
  bool get isSearch => this == NotesListPageMode.search;
  bool get isFilter => this == NotesListPageMode.filter;
}
