import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/todo.dart';
import '../bloc/todo_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bloc = sl<TodoBloc>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Clean Architecture'),
      ),
      body: StreamBuilder<List<Todo>>(
          stream: bloc.list(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('Add a new todo'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final todo = snapshot.data![index];
                return ListTile(
                  onTap: () {},
                  title: Text(todo.text),
                  subtitle: Text(todo.description),
                  trailing: IconButton(
                    onPressed: () async {
                      await bloc.delete(todo);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.8,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: titleController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Title is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Title',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextFormField(
                            controller: descriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Description is required';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Description',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final newTodo = await bloc.add(Todo(
                                    id: nanoid(),
                                    description: descriptionController.text,
                                    text: titleController.text));

                                newTodo.fold(
                                  (failure) => failure,
                                  (todo) => todo,
                                );
                                descriptionController.clear();
                                titleController.clear();
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Add'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
