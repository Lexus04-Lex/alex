import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}
abstract class Person{}
class PersonProfile extends Person{
  final String personid;
  PersonProfile(this.personid);
}
class Persons {
  final String name;
  final String email;
  final String phone;
  final String status;
  final bool isloading;
  Persons({required this.name, required this.email, required this.phone, required this.status, this.isloading = false});
}
class PersonBloc extends Bloc<Person, Persons>{
  PersonBloc(): super(Persons(name: 'No one yet', email: 'Not filled in yet', phone: 'No number yet', status: 'Not known', isloading: false)){
    on<PersonProfile>((event, emit)async{
      emit(Persons(name: 'Loading.....', email: 'Loading.........', phone: 'Loading.........', status: 'Loading.........', isloading: true));
      await Future.delayed(Duration(seconds: 2));
      String name = _fetchName(event.personid);
      String email = _fetchEmail(event.personid);
      String phone = _fetchPhone(event.personid);
      String status = _fetchStatus(event.personid);
      emit(Persons(name: name, email: email, phone: phone, status: status));
    });
  }
}
String _fetchName(String personid) {
  switch(personid){
    case 'Person1' : return 'Albert';
    case 'Person3' : return 'Kizito';
    case 'Person2' : return 'Alex';
    case 'Person4' : return 'Vincent';
    case 'Person5' : return 'Felix';
    default : return 'No name';
  }
}
String _fetchEmail(String personid){
  switch(personid){

    case 'Person1' : return '1@gmail.com';
    case 'Person3' : return 'Married@gmail.com';
    case 'Person2' : return 'Retired@gmail.com';
    case 'Person4' : return 'Classified@gmail.com';
    case 'Person5' : return 'Confused@gmail.com';
    default : return 'No email';
  }
}
String _fetchPhone(String personid){
  switch(personid){
    case 'Person1' : return '0752687851';
    case 'Person3' : return '0764462273';
    case 'Person2' : return '0746399978';
    case 'Person4' : return '0780722084';
    case 'Person5' : return '0706669522';
    default : return 'No phone number';
  }
}

String _fetchStatus(String personid){
  switch(personid){

    case 'Person1' : return 'Married';
    case 'Person3' : return 'Divorced';
    case 'Person2' : return 'Single';
    case 'Person4' : return 'Confused';
    case 'Person5' : return 'Hajji';
    default : return 'No name';
  }
}
class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=>PersonBloc(),
    child: PersonPage(),
    );
  }
}

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PersonBloc, Persons>(builder: (context, state){
        return Center(child:
        state.isloading ? CircularProgressIndicator() :
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${state.name}'),
            Text('Email: ${state.email}'),
            Text('Phone: ${state.phone}'),
            Text('Status: ${state.status}'),
            SizedBox(height: 10),
            ElevatedButton(onPressed: ()=> context.read<PersonBloc>().add(PersonProfile('Person1')),
                child: Text('Load user 1')),
            SizedBox(height: 10),
            ElevatedButton(onPressed: ()=> context.read<PersonBloc>().add(PersonProfile('Person2')),
                child: Text('Load user 2')),
            SizedBox(height: 10),
            ElevatedButton(onPressed: ()=> context.read<PersonBloc>().add(PersonProfile('Person3')),
                child: Text('Load user 3')),
            SizedBox(height: 10),
            ElevatedButton(onPressed: ()=> context.read<PersonBloc>().add(PersonProfile('Person4')),
                child: Text('Load user 4')),
            SizedBox(height: 10),
            ElevatedButton(onPressed: ()=> context.read<PersonBloc>().add(PersonProfile('Person5')),
                child: Text('Load user 5')),
          ],
        ));
      }),
    );
  }
}



