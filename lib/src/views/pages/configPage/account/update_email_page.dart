import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class UpdateEmailPage extends StatefulWidget {

  const UpdateEmailPage({Key? key,}) : super(key: key);

  @override
  _UpdateEmailPageState createState() => _UpdateEmailPageState();
}

class _UpdateEmailPageState extends State<UpdateEmailPage> {
  final TextEditingController _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        //title: Text('Actualizar Correo'),
        leading: InkWell(
          onTap: () {Navigator.of(context).pop();},
          child: Icon(
            Iconsax.arrow_left,
            
            ),
        ),
      ),
      body: updateEmailWidget(),
    );
  }

  Widget updateEmailWidget() {
    final authProvider = Provider.of<AuthProvider>(context);
    return Form(
      key: formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text(UPDATE_EMAIL_PAGE_TITLE,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        )),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                ),
                TextFormField(
                  controller: _emailController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  decoration: InputDecoration(
                    hintText: NEW_EMAIL_HINT,
                    hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.2)),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    authProvider.updateEmail(_emailController.text);
                    _emailController.clear();
                    Navigator.of(context).pop();
                  });
                }
              },
              child: Text(SAVE_BUTTON,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Theme.of(context).primaryColor)),
            ),
          ),
        ),
      ),
    );
  }
}