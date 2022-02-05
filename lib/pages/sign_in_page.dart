import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_google/blocs/internet_bloc.dart';
import 'package:login_google/blocs/sign_in_bloc.dart';
import 'package:login_google/pages/home_page.dart';
import 'package:login_google/utils/next_screen.dart';
import 'package:login_google/utils/snacbar.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage> {
  bool googleSignInStarted = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  handleGoogleSignIn() async {
    final sb = context.read<SignInBloc>();
    final ib = context.read<InternetBloc>();
    setState(() => googleSignInStarted = true);
    await ib.checkInternet();
    if (ib.checkInternet() == false) {
      openSnacbar(scaffoldKey, 'check your internet connection!');
    } else {
      sb.signInWithGoogle().then((_) {
        if (sb.hasError == true) {
          openSnacbar(scaffoldKey, 'something is wrong. please try again.');
          setState(() => googleSignInStarted = false);
        } else {
          sb.saveDataToSP().then((value) => sb.setSignIn().then((value) {
                setState(() => googleSignInStarted = false);
                nextScreenReplace(context, const HomePage());
              }));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image(
                image: AssetImage('assets/logo.png'),
                fit: BoxFit.fitWidth,
                height: 250,
                width: 250,
              ),
            ),
          ),
          SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width * 0.80,
            child: TextButton(
                onPressed: () => handleGoogleSignIn(),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: googleSignInStarted == false
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'login google',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.white),
                      )),
          ),
        ],
      ),
    );
  }
}
