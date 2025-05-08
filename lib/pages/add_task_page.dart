import 'package:flutter/material.dart';
import 'package:login_sqflite_getx/models/task.dart';
import 'package:intl/intl.dart'; // Tambahkan package intl untuk format tanggal

class AddTaskPage extends StatefulWidget {
  final Task? task;

  const AddTaskPage({super.key, this.task});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late TextEditingController titleController;
  late TextEditingController descController;
  late TextEditingController dateController;

  // List kategori yang tersedia
  final List<String> categories = [
    'Belanja',
    'Jalan-jalan',
    'Pekerjaan',
    'Pendidikan',
    'Lainnya'
  ];
  late String selectedCategory;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan nilai task jika ada
    titleController = TextEditingController(text: widget.task?.title ?? '');
    descController =
        TextEditingController(text: widget.task?.description ?? '');
    dateController = TextEditingController(text: widget.task?.date ?? '');

    // Set kategori terpilih
    selectedCategory = widget.task?.category ?? categories.first;

    // Parse tanggal jika ada
    if (widget.task?.date != null && widget.task!.date.isNotEmpty) {
      try {
        selectedDate = DateFormat('yyyy-MM-dd').parse(widget.task!.date);
      } catch (e) {
        selectedDate = null;
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    dateController.dispose();
    super.dispose();
  }

  // Fungsi untuk menampilkan date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? "Tambah Todo" : "Edit Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Judul",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Field untuk tanggal dengan icon button
              TextField(
                controller: dateController,
                readOnly: true, // Membuat text field tidak bisa diedit langsung
                decoration: InputDecoration(
                  labelText: "Tanggal",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                onTap: () =>
                    _selectDate(context), // Buka date picker saat field di tap
              ),
              const SizedBox(height: 16),
              // Dropdown untuk kategori
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: "Kategori",
                  border: OutlineInputBorder(),
                ),
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  final title = titleController.text.trim();
                  final desc = descController.text.trim();
                  final date = dateController.text.trim();

                  if (title.isNotEmpty && desc.isNotEmpty && date.isNotEmpty) {
                    final newTask = Task(
                      id: widget.task?.id,
                      title: title,
                      description: desc,
                      date: date,
                      category: selectedCategory,
                    );
                    Navigator.pop(context,
                        newTask); // kirim kembali ke halaman sebelumnya
                  } else {
                    // Tampilkan snackbar jika ada field yang kosong
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Semua field harus diisi')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  widget.task == null ? "Tambah" : "Simpan",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
