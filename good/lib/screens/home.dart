import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

abstract class CounterEvent{}
class IncrementEvent extends CounterEvent{}

class Counter{
  final int count;
  Counter(this.count);
}
class CounterBloc extends Bloc<CounterEvent, Counter>{
  CounterBloc():super(Counter(0)){
    on<IncrementEvent>((event, emit){
      emit(Counter(state.count +1));
    });
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(create: (_)=> CounterBloc(),
      child: CounterPage(),
      ),
    );
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
        return Center(child: Text('Count: ${state.count}'),
        );
      }),
      floatingActionButton: FloatingActionButton(onPressed: ()=> context.read<CounterBloc>().add(IncrementEvent()),
        child: Icon(Icons.add),
      ),
    );
  }
}
