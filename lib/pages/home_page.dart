import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_sqflite_getx/controllers/todo_controller.dart';
import 'package:login_sqflite_getx/models/task.dart';
import 'package:login_sqflite_getx/pages/add_task_page.dart';
import 'package:login_sqflite_getx/pages/task_detail.dart';
import 'package:login_sqflite_getx/pages/onBoarding.dart';

class HomePage extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  // Controller untuk search bar
  final TextEditingController searchController = TextEditingController();
  // RxList untuk menyimpan hasil pencarian
  final RxList<Task> filteredTasks = <Task>[].obs;
  // RxBool untuk tracking mode pencarian
  final RxBool isSearching = false.obs;

  HomePage({super.key}) {
    // Inisialisasi filteredTasks dengan semua tasks
    filteredTasks.assignAll(todoController.tasks);
    
    // Tambahkan listener ke todoController.tasks untuk update filteredTasks
    ever(todoController.tasks, (_) {
      _filterTasks(searchController.text);
    });
  }

  // Fungsi untuk memfilter tasks berdasarkan keyword
  void _filterTasks(String keyword) {
    if (keyword.isEmpty) {
      filteredTasks.assignAll(todoController.tasks);
      isSearching.value = false;
    } else {
      isSearching.value = true;
      filteredTasks.assignAll(todoController.tasks.where((task) =>
        task.title.toLowerCase().contains(keyword.toLowerCase()) ||
        task.description.toLowerCase().contains(keyword.toLowerCase()) ||
        task.category.toLowerCase().contains(keyword.toLowerCase())
      ).toList());
    }
  }

  // Fungsi untuk membersihkan pencarian dan kembali ke tampilan semua task
  void _clearSearch() {
    searchController.clear();
    _filterTasks('');
    isSearching.value = false;
  }

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
            // Ganti icon hamburger dengan tombol logout
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Color.fromARGB(255, 180, 7, 7),
                size: 28,
              ),
              onPressed: () {
                // Konfirmasi logout dengan dialog
                Get.dialog(
                  AlertDialog(
                    title: const Text('Konfirmasi Logout'),
                    content: const Text('Anda yakin ingin keluar dari aplikasi?'),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Arahkan ke halaman onboarding setelah konfirmasi
                          Get.offAll(() => OnboardingPage());
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
              tooltip: 'Logout',
            ),
            Icon(
              Icons.check_circle_outline,
              color: Theme.of(context).colorScheme.primary,
              size: 35,
            ), 
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                // Search bar dengan fungsionalitas
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      _filterTasks(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 20,
                      ),
                      suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, size: 20),
                            onPressed: () {
                              searchController.clear();
                              _filterTasks('');
                            },
                          )
                        : null,
                      prefixIconConstraints:
                          BoxConstraints(maxHeight: 20, minWidth: 25),
                      border: InputBorder.none,
                      hintText: 'Search task, category...',
                      hintStyle: TextStyle(color: Color(0xFF717171))
                    ),
                  ),
                ),
                
                Expanded(
                  child: ListView(
                    children: [
                      // Judul dengan tombol back saat searching
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Row(
                          children: [
                            // Tombol back hanya muncul saat searching
                            Obx(() => isSearching.value
                              ? IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Color(0xFF3A3A3A),
                                    size: 28,
                                  ),
                                  onPressed: _clearSearch,
                                  tooltip: 'Kembali ke semua tugas',
                                )
                              : Container()
                            ),
                            Obx(() => Text(
                              isSearching.value ? "Search results" : "All todos",
                              style: TextStyle(
                                fontSize: 30, 
                                fontWeight: FontWeight.w500
                              ),
                            )),
                          ],
                        ),
                      ),
                      
                      // Task list dengan Obx untuk real-time update
                      Obx(() => filteredTasks.isEmpty
                        ? Center(
                            child: Text(
                              isSearching.value
                                ? 'Tidak ada task yang sesuai dengan pencarian'
                                : 'Belum ada task yang ditambahkan',
                              style: TextStyle(
                                color: Colors.grey, 
                                fontSize: 16
                              ),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(12),
                            itemCount: filteredTasks.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final task = filteredTasks[index];
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
                          )
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ],
      ),
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