class Task {
  int? id;
  String title;
  String description;
  String date; // Tambahkan field tanggal
  String category; // Tambahkan field kategori

  Task({
    this.id, 
    required this.title, 
    required this.description, 
    required this.date, // Parameter wajib untuk tanggal
    required this.category, // Parameter wajib untuk kategori
  });

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        date: json['date'] ?? '', // Mengambil nilai tanggal dari database
        category: json['category'] ?? '', // Mengambil nilai kategori dari database
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date, // Menyimpan tanggal ke database
      'category': category, // Menyimpan kategori ke database
    };
  }
}