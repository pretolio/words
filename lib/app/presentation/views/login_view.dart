

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/user_controller.dart';
import '../widgets/custom_snackbar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  bool isSingIn = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(!isSingIn ? 'Cadastrar' : 'Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) => states.any((e) =>
                e == MaterialState.disabled || e == MaterialState.error)
                    ? null : Colors.indigo ,
              ),
              shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder?>(
                    (Set<MaterialState> states) => RoundedRectangleBorder(
                    side: BorderSide.none, //the outline color
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
            onPressed: _isLoading ? null : () async {
              if(isSingIn){
                await context.read<UserController>().signIn(_emailController.text, _passwordController.text)
                    .catchError((error) {
                  CustomSnackbar.error(text: 'Não foi possivel realizar login, verifique seu email e senha!', context: context);
                });
              }else{
                await context.read<UserController>().createUser(_emailController.text, _passwordController.text)
                    .catchError((error) {
                  CustomSnackbar.error(text: 'Não foi possivel se cadastrar, verifique seu email e senha!', context: context);
                });
              }
            },
            child: Center(
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text((!isSingIn ? 'Cadastrar' : 'Login').toUpperCase(),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              !isSingIn ? Container() :
              TextButton(onPressed: () async {
                await context.read<UserController>().sendPassword(_emailController.text).then((value) {
                  CustomSnackbar.sucess(text: 'Senha resetada com sucesso!', context: context);
                }).catchError((error) {
                  CustomSnackbar.error(text: 'Não foi possivel resetar sua senha, verifique seu email!', context: context);
                });
              }, child: Text('Esqueci minha senha')),

              TextButton(onPressed: (){
                setState(() {
                  isSingIn = !isSingIn;
                });
              }, child: Text(isSingIn ? 'Cadastrar' : 'Login')),
            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
