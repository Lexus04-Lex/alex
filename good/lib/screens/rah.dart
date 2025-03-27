import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
abstract class People{}
class PeopleDetails extends People{
  final String peopleid;
  PeopleDetails(this.peopleid);
}
class Person{
  final String name;
  final String age;
  final String email;
  final String location;
  final bool isloading;
  Person({required this.name, required this.age, required this.email, required this.location, this.isloading = true});
}
class PeopleBloc extends Bloc<People, Person>{
  PeopleBloc(): super(Person(name: 'No person', age: 'Not known', email: 'Un available', location: 'No known yet', isloading: false)){
  on<PeopleDetails>((event, emit)async{
    emit(Person(name: '', age: '', email: '', location: '', isloading: true));
    await Future.delayed(Duration(seconds: 4));
    String name = _fetchname(event.peopleid);
    int age = _fetchage(event.peopleid);
    String email = _fetchemail(event.peopleid);
    String location = _fetchlocation(event.peopleid);
    emit(Person(name: name, age: age.toString(), email: email, location: location, isloading: false));
  }
  );
}}
String _fetchname(String personid){
  switch(personid){
    case '1':
      return 'Alex Rahim';
    case '2':
      return 'Jane';
    case '3':
      return 'Michael Johnson';
    default:
      return 'No person';
  }
}

int _fetchage(String personid){
  switch(personid){
    case '1':
      return 30;
    case '2':
      return 28;
    case '3':
      return 45;
    default:
      return 0;
  }
}

String _fetchemail(String personid){
  switch(personid){
    case '1':
      return 'alex@example.com';
    case '2':
      return 'jane@example.com';
    case '3':
      return'michael@example.com';
    default:
      return 'Un available';
  }
}

String _fetchlocation(String personid){
  switch(personid){
    case '1':
      return 'New York, USA';
    case '2':
      return 'Los Angeles, USA';
    case '3':
      return 'Chicago, USA';
    default:
      return 'No known yet';
  }
}

class Rahim extends StatefulWidget {
  const Rahim({super.key});

  @override
  State<Rahim> createState() => _RahimState();
}

class _RahimState extends State<Rahim> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=>PeopleBloc(),
    child: RahimPage(),
    );
  }
}
class RahimPage extends StatefulWidget {
  const RahimPage({super.key});

  @override
  State<RahimPage> createState() => _RahimPageState();
}

class _RahimPageState extends State<RahimPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PeopleBloc, Person>(builder: (context, state){
        return Center(
          child:
          state.isloading ? CircularProgressIndicator() :
          Column(
            children: [
              Text('Name: ${state.name}'),
              Text('Email: ${state.email}'),
              Text('Age: ${state.age}'),
              Text('Location: ${state.location}'),
              ElevatedButton(
                onPressed: ()=>context.read<PeopleBloc>().add(PeopleDetails('1')),
              child: Text('Load Person 1'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()=>context.read<PeopleBloc>().add(PeopleDetails('2')),
                child: Text('Load Person 2'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()=>context.read<PeopleBloc>().add(PeopleDetails('3')),
                child: Text('Load Person 3'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()=>context.read<PeopleBloc>().add(PeopleDetails('4')),
                child: Text('Load Person 4'),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}




