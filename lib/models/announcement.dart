class Announcement {
  final String? title,description, meetingLink;

  Announcement({required this.title, required this.description, required this.meetingLink});


  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      title: map['title'],
      description: map['description'],
      meetingLink: map['meeting_link'],
    );
  }
}