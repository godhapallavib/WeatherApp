import 'package:flutter/material.dart';
import '../provider/weatherProvider.dart';
import '../widgets/components/my_textfield.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class RequestError extends StatelessWidget {
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //reference our box
  final userBox = Hive.box('userhive');

  RequestError({super.key});

  //write data to hive
  void writeData() {
    userBox.put(usernameController.text, passwordController.text);
    print(userBox.get(usernameController.text));
  }

  //read data from hive
  readData() {
    return userBox.get(
        usernameController.text); // This returns password. That's all we need.
  }

  //delete data from hive

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.face,
            color: Colors.blue,
            size: 100,
          ),
          const SizedBox(height: 7),
          const Text(
            'Sign in to continue',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 7),
          MyTextField(
            controller: usernameController,
            obscureText: false,
            hintText: 'username',
          ),
          const SizedBox(height: 7),
          MyTextField(
            controller: passwordController,
            obscureText: true,
            hintText: 'password',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 10),
            child: Text(
              'Sign In to continue',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              child: const Text('Login'),
              onPressed: () => <Set<dynamic>>{
                    if (passwordController.text == readData())
                      {
                        Provider.of<WeatherProvider>(context, listen: false)
                            .togglelogin(context, isRefresh: true),
                      }
                    else
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Incorrect username or password'),
                        )),
                      }
                  }),
          const SizedBox(height: 5),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              child: const Text('Sign Up'),
              onPressed: () => <Set<void>>{
                    if (usernameController.text == '' ||
                        passwordController == '')
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Please enter username and password'),
                        )),
                      }
                    else
                      <void>{
                        writeData(),
                        Provider.of<WeatherProvider>(context, listen: false)
                            .togglelogin(context, isRefresh: true),
                      }
                  }),
        ],
      ),
    );
  }
}
