import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/http_exception.dart';
import '../shared/dialog_utils.dart';

import 'auth_manager.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    super.key,
  });

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    try {
      if (_authMode == AuthMode.login) {
        // Log user in
        await context.read<AuthManager>().login(
              _authData['email']!,
              _authData['password']!,
            );
      } else {
        // Sign user up
        await context.read<AuthManager>().signup(
              _authData['email']!,
              _authData['password']!,
            );
      }
    } catch (error) {
      if (context.mounted) {
        showErrorDialog(
            context,
            (error is HttpException)
                ? error.toString()
                : 'Authentication failed');
      }
    }

    _isSubmitting.value = false;
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return Container(

      child: Container(

        height: _authMode == AuthMode.signup ? 410 : 300,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.signup ? 420 : 300),
        width: deviceSize.width * 0.75,

      child: Column(
        children: [
          Text('${_authMode == AuthMode.login ? 'Đăng nhập' : 'Đăng ký'}',style: TextStyle(color: Colors.black,fontSize: 30),),
          const SizedBox(
            height: 10,
          ),
          Form(

          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildEmailField(),
                const SizedBox(
                  height: 5,
                ),
                _buildPasswordField(),
                const SizedBox(
                  height: 5,
                ),
                if (_authMode == AuthMode.signup) _buildPasswordConfirmField(),
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _isSubmitting,
                  builder: (context, isSubmitting, child) {
                    if (isSubmitting) {
                      return const CircularProgressIndicator();
                    }

                    return _buildSubmitButton();
                  },
                ),
                _buildAuthModeSwitchButton(),
              ],
            ),
          ),
        ),
        ],
    ),
      ),
    );
  }

  Widget _buildAuthModeSwitchButton() {
    return Container(

      child: TextButton(
      onPressed: _switchAuthMode,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),

        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.center,
      ),

      child:Row(
          children:[
            Text('${_authMode == AuthMode.login ? 'Bạn chưa có tài khoản? ' : 'Bạn đã có tài khoản? '}',style: TextStyle(color: Colors.black),),
          Text('${_authMode == AuthMode.login ? 'Đăng ký ngay' : 'Đăng nhập'}',style: TextStyle(fontSize: 17, color: Colors.blue), textAlign: TextAlign.center,),
        ],
      ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        backgroundColor: Colors.redAccent,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 106.0, vertical: 8.0),
      ),
      child: Text(_authMode == AuthMode.login ? 'Đăng nhập' : 'Đăng ký',style: TextStyle(fontSize: 20), ),
      ),
    );
  }

  Widget _buildPasswordConfirmField() {
    return TextFormField(
      enabled: _authMode == AuthMode.signup,
      decoration: const InputDecoration(labelText: 'Nhập lại mật khẩu',border: OutlineInputBorder(),),
      obscureText: true,
      validator: _authMode == AuthMode.signup
          ? (value) {
              if (value != _passwordController.text) {
                return 'Mật khẩu không trùng khớp!';
              }
              return null;
            }
          : null,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Mật khẩu',border: OutlineInputBorder(),),

      obscureText: true,
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.length < 5) {
          return 'Mật khẩu quá ngắn!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'E-Mail',border: OutlineInputBorder(),),

      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Email không đúng!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['email'] = value!;
      },
    );
  }
}
