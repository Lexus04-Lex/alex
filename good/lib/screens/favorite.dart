import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Favorite extends StatefulWidget {
  const Favorite({super.key});
  @override
  State<Favorite> createState() => _FavoriteState();
}
class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: BlocProvider(create:
      (_)=> CounterBloc(),
        child: CounterPage(),
      ),
    );
  }
}
abstract class CounterEvent{}
class Increment extends CounterEvent{}

class Counter{
  final int count;
  Counter(this.count);
}
class CounterBloc extends Bloc<CounterEvent, Counter>{
  CounterBloc(): super(Counter(100)){
    on<Increment>((event, emit){
      emit(Counter(state.count -1));
    });
  }
}
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});
  @override
  State<CounterPage> createState() => _CounterPageState();
}
class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CounterBloc, Counter>(builder: (context, state){
        return Center(child: Text('Count: ${state.count}'));
      }),
      floatingActionButton: FloatingActionButton(onPressed:
          ()=> context.read<CounterBloc>().add(Increment()),
          child: Icon(Icons.add),
      ),
    );
  }
}

