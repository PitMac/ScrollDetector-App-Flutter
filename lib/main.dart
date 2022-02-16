import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app/scroll_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ScrollProvider>(
          create: (_) => ScrollProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          scrollProvider.change
              ? Icons.arrow_circle_up_outlined
              : Icons.arrow_circle_down_outlined,
        ),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Column(
        children: const [
          Text('data', style: TextStyle(fontSize: 20)),
          Expanded(
            child: ListApp(),
          )
        ],
      ),
    );
  }
}

class ListApp extends StatelessWidget {
  const ListApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();
    final scrollProvider = Provider.of<ScrollProvider>(context);

    void change() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          scrollProvider.change) {
        print('abajo');
        scrollProvider.cchange();
      } else if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          !scrollProvider.change) {
        print('arriba');
        scrollProvider.cchange();
      }
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (d) {
        change();
        return true;
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount: 60,
        itemBuilder: (_, __) {
          return const Card(
            child: Text('hello'),
          );
        },
      ),
    );
  }
}
