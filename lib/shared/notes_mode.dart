enum NotesMode { list, selection, search }

extension NotesModeX on NotesMode {
  bool get isList => this == NotesMode.list;
  bool get isSelection => this == NotesMode.selection;
  bool get isSearch => this == NotesMode.search;
}
