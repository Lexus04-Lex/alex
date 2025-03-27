import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=>CounterBloc(),
    child: CounterPage(),
    );
  }
}

abstract class CounterEvent{}

class IncrementCounter extends CounterEvent{}

class CounterStatus {
  final int count;
  CounterStatus(this.count);
}
class CounterBloc extends Bloc<CounterEvent, CounterStatus>{
  CounterBloc(): super(CounterStatus(0)){
    on<IncrementCounter>((event, emit){
      emit(CounterStatus(state.count +1));
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
      body: BlocBuilder<CounterBloc, CounterStatus>(builder: (context, state){
        return Center(child: 
          Text('Count: ${state.count}')
          ,);
      }),
      floatingActionButton: FloatingActionButton(onPressed: ()=> context.read<CounterBloc>().add(IncrementCounter()),
      child: Icon(Icons.add),
      ),
    );
  }
}


