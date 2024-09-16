class FileModelData {
  final String filePath, fileName;
  final int id;
  final bool downloadable;

  FileModelData({required this.filePath, required this.id, required this.fileName, required this.downloadable});


  factory FileModelData.fromMap(Map<String, dynamic> map) {
    return FileModelData(
      filePath: map['file_path'],
      fileName: map['file_name'],
      id: map['id'],
      downloadable: map['downloadable'].toString() == '1',
    );
  }
}