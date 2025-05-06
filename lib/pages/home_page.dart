import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_sqflite_getx/controllers/todo_controller.dart';
import 'package:login_sqflite_getx/models/task.dart';
import 'package:login_sqflite_getx/pages/add_task_page.dart';
import 'package:login_sqflite_getx/pages/task_detail.dart';

class HomePage extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());

  HomePage({super.key});

  // Fungsi untuk mendapatkan warna berdasarkan kategori (untuk badge kategori)
  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'belanja':
        return Colors.green.shade100;
      case 'jalan-jalan':
        return Colors.blue.shade100;
      case 'pekerjaan':
        return Colors.red.shade100;
      case 'pendidikan':
        return Colors.purple.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEFF5),
      appBar: AppBar(
        backgroundColor: Color(0xFFEEEFF5),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: Color(0xFF3A3A3A),
              size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRect(
                child: Image.asset('images/photoprofile.png'),
              ),
            )
          ],
        ),
      ),
      body: Obx(() => Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 20,
                            ),
                            prefixIconConstraints:
                                BoxConstraints(maxHeight: 20, minWidth: 25),
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Color(0xFF717171))),
                      ),
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 20),
                          child: Text(
                            "All todos",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        todoController.tasks.isEmpty
                            ? const Center(
                                child: Text(
                                  'Belum ada task yang ditambahkan',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(12),
                                itemCount: todoController.tasks.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 8),
                                itemBuilder: (context, index) {
                                  final task = todoController.tasks[index];
                                  return Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      child: Row(
                                        children: [
                                          // Kolom kiri - judul dan tanggal
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Judul task dan badge kategori
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        task.title,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    // Badge kategori
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            _getCategoryColor(
                                                                task.category),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      child: Text(
                                                        task.category,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade800,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 8),
                                                // Tanggal
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.calendar_today,
                                                      size: 14,
                                                      color: Colors.grey,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      task.date,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .grey.shade700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Kolom kanan - tombol aksi
                                          Row(
                                            children: [
                                              // Tombol lihat (view)
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.visibility,
                                                  color: Colors.blue,
                                                ),
                                                onPressed: () {
                                                  Get.to(() => TaskDetailPage(
                                                      task: task));
                                                },
                                                tooltip: 'Lihat Detail',
                                              ),
                                              // Tombol edit
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: Colors.orange,
                                                ),
                                                onPressed: () async {
                                                  final updatedTask =
                                                      await Get.to(
                                                    () =>
                                                        AddTaskPage(task: task),
                                                  );
                                                  if (updatedTask != null &&
                                                      updatedTask is Task) {
                                                    todoController.updateTask(
                                                        updatedTask);
                                                  }
                                                },
                                                tooltip: 'Edit',
                                              ),
                                              // Tombol hapus
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  // Konfirmasi hapus
                                                  Get.dialog(
                                                    AlertDialog(
                                                      title: const Text(
                                                          'Konfirmasi'),
                                                      content: const Text(
                                                          'Apakah anda yakin ingin menghapus task ini?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Get.back(),
                                                          child: const Text(
                                                              'Batal'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            todoController
                                                                .deleteTask(
                                                                    task.id!);
                                                            Get.back();
                                                            Get.snackbar(
                                                              'Sukses',
                                                              'Task berhasil dihapus',
                                                              snackPosition:
                                                                  SnackPosition
                                                                      .BOTTOM,
                                                              backgroundColor:
                                                                  Colors.green,
                                                              colorText:
                                                                  Colors.white,
                                                            );
                                                          },
                                                          child: const Text(
                                                              'Hapus'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                tooltip: 'Hapus',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Get.to(() => AddTaskPage());
          if (newTask != null && newTask is Task) {
            todoController.addTask(newTask);
            Get.snackbar(
              'Sukses',
              'Task berhasil ditambahkan',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
