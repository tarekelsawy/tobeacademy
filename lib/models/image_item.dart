
class ImageItem {
  final String src,path;
  String? localPath, name;


   ImageItem({
    required this.src,
    required this.path,
     this.name,
     this.localPath
  });


  @override
  String toString() {
    return 'ImageItem{src: $src, path: $path, localPath: $localPath}';
  }


  factory ImageItem.fromMap(Map<String, dynamic> map) {
    return ImageItem(
      src: map['src'] as String,
      path: map['path'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'src': src,
      'path': path,
    };
  }

}