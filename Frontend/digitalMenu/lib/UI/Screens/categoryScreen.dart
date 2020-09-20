import 'package:digitalMenu/Bloc/storeBloc.dart';
import 'package:digitalMenu/Bloc/storeEvent.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final StoreBloc storeBloc;
  CategoryScreen({@required this.storeBloc});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _categoryName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          widget.storeBloc.eventSink.add(SaveCategory());
        },
        label: Text("Save"),
        icon: Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Form(
                key: _formKey,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _categoryName,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter Category Name";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Add Category",
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          widget.storeBloc.eventSink
                              .add(AddCategory(category: _categoryName.text));
                          _categoryName.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
              StreamBuilder<List<String>>(
                stream: widget.storeBloc.categoryStream,
                initialData: widget.storeBloc.getCategory,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error"),
                      );
                    } else {
                      return snapshot.data.length == 0
                          ? Center(
                              child: Text("No Category Added"),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, i) {
                                return ListTile(
                                  title: Text(snapshot.data[i]),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.remove_circle_outline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      widget.storeBloc.eventSink
                                          .add(RemoveCategory(index: i));
                                    },
                                  ),
                                );
                              },
                            );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
