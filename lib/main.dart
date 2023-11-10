import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class User {
  late String name;
  late String phoneNumber;
  late String address;
  late String city;
  late String state;
  late String zipCode;
  late String emailAddress;

  User({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.emailAddress,
  });

  // Convert user data to a map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'emailAddress': emailAddress,
    };
  }
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Page(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Page extends StatefulWidget {
  const Page({Key? key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  final _formfield = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();

  bool passToggle = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _formfield,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Center(
                       child: Text('Sign in',style: TextStyle(fontFamily: 'Karla',fontWeight: FontWeight.bold,fontSize: 35,color: Color(0xFF8B48DF)),),
                     )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Karla',
                        fontWeight: FontWeight.w100,
                        color: Color(0xFF8B48DF)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      bool emailvalid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);

                      if (value.isEmpty) {
                        return "Enter Email";
                      } else if (!emailvalid) {
                        return "Enter Valid Email";
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Date Saved Successfully',style: TextStyle(fontFamily: 'Karla',),),
                          duration: Duration(milliseconds: 900),
                          backgroundColor: Colors.black,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    obscureText: passToggle,
                    keyboardType: TextInputType.emailAddress,
                    controller: passcontroller,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Karla',
                        fontWeight: FontWeight.w100,
                        color: Color(0xFF8B48DF)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                      ),
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                        child: Icon(passToggle
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      } else if (passcontroller.text.length < 6) {
                        return "Password Should be more than 6 characters";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formfield.currentState!.validate()) {
                        print('Success');



                        emailcontroller.clear();
                        passcontroller.clear();



                        if (emailcontroller != null) {
                         Navigator.push(context, MaterialPageRoute(builder:(context)=>Page2()));

                        } else {
                          // User not found, show an error message or take appropriate action
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Invalid email or password'),
                            duration: Duration(milliseconds: 900),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF8B48DF), // Adjust the color as needed
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: SizedBox(
                      height: 50,
                      width: 600,
                      child: const Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Karla',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Page1()));
                          },
                          child:SizedBox(
                            height: 50,
                            width: 285,
                            child: const Center(
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Karla',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF8B48DF), // Adjust the color as needed
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Save data using Shared Preferences
  void _saveRegistrationData(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('name', user.name);
    prefs.setString('phoneNumber', user.phoneNumber);
    prefs.setString('address', user.address);
    prefs.setString('city', user.city);
    prefs.setString('state', user.state);
    prefs.setString('zipCode', user.zipCode);
    prefs.setString('emailAddress', user.emailAddress);
  }
}

class Page1 extends StatefulWidget {
  const Page1({Key? key});

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Name';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Phone Number';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Address';
    }
    return null;
  }

  String? _validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter City';
    }
    return null;
  }

  String? _validateState(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter State';
    }
    return null;
  }

  String? _validateZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Zip Code';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value ?? '');

    if (value == null || value.isEmpty) {
      return 'Enter Email';
    } else if (!emailValid) {
      return 'Enter Valid Email';
    }
    return null;
  }

  void _createAccount() async {
    if (_formKey.currentState!.validate()) {
      User user = User(
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
        address: addressController.text,
        city: cityController.text,
        state: stateController.text,
        zipCode: zipCodeController.text,
        emailAddress: emailController.text,
      );

      // Save data using Shared Preferences
      _saveRegistrationData(user);

      // Clear the text controllers
      nameController.clear();
      phoneNumberController.clear();
      addressController.clear();
      cityController.clear();
      stateController.clear();
      zipCodeController.clear();
      emailController.clear();

      Navigator.push(context, MaterialPageRoute(builder: (context) => Page()));
    }
  }

  void _saveRegistrationData(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('name', user.name);
    prefs.setString('phoneNumber', user.phoneNumber);
    prefs.setString('address', user.address);
    prefs.setString('city', user.city);
    prefs.setString('state', user.state);
    prefs.setString('zipCode', user.zipCode);
    prefs.setString('emailAddress', user.emailAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8B48DF),
        centerTitle: true,
        title: const Text('Register New Account',style: TextStyle(fontFamily: 'Karla',),),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontFamily: 'Karla',color: Color(0xFF8B48DF)),
                    suffixIcon: Icon(Icons.people),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: _validateName,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 320,
                      height: 50,
                      child: TextFormField(
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(fontFamily: 'Karla',color: Color(0xFF8B48DF)),
                          suffixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: _validatePhoneNumber,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    labelStyle: TextStyle(fontFamily: 'Karla',color: Color(0xFF8B48DF)),
                    suffixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: _validateAddress,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 320,
                      child: TextFormField(
                        controller: cityController,
                        decoration: const InputDecoration(
                          labelText: 'City',
                          suffixIcon: Icon(Icons.arrow_drop_down),labelStyle: TextStyle(fontFamily: 'Karla',color: Color(0xFF8B48DF)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: _validateCity,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 320,
                child: TextFormField(
                  controller: stateController,
                  decoration: const InputDecoration(
                    labelText: 'State',
                    labelStyle: TextStyle(fontFamily: 'Karla',color: Color(0xFF8B48DF)),
                    suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: _validateState,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 320,
                child: TextFormField(
                  controller: zipCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                    suffixIcon: Icon(Icons.numbers),
                    labelStyle: TextStyle(fontFamily: 'Karla',color: Color(0xFF8B48DF)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: _validateZipCode,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 320,
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    suffixIcon: Icon(Icons.email_outlined),
                    labelStyle: const TextStyle(fontFamily: 'Karla',color:Color(0xFF8B48DF)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                  validator: _validateEmail,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 149,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.purpleAccent],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: _createAccount,
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF8B48DF),
                        onPrimary: Color(0xFF8B48DF),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          fontFamily: 'Karla',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: 50,
                    width: 149,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.white, Colors.white],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF8B48DF),
                        onPrimary: Color(0xFF8B48DF),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Karla',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: const Center(
        child: Text('Welcome to Page 2!'),
      ),
    );
  }
}

