class PaginationData {
  int? page;
  int? lastPage;
  PaginationData({
    this.page = 1,
    this.lastPage,
  });

  bool get isLastPage => lastPage == ((page??1) - 1);

  factory PaginationData.fromMap(Map<String, dynamic> map) {
    return PaginationData(
      page: map['current_page'],
      lastPage: map['last_page'],
    );
  }
}

