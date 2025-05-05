import 'package:flutter/material.dart';
import 'package:todo_app/widget/todo_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    TodoItem(),
                    TodoItem(),
                    TodoItem(),
                    TodoItem()
                  ],
                ))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Add new todo item',
                        border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(60, 60),
                        elevation: 10,
                        backgroundColor: Color(0xFF5F52EE)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
