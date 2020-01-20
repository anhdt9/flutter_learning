import 'package:local_auth/local_auth.dart';

Future<bool> localAuth() async {
  final LocalAuthentication localAuthentication = LocalAuthentication();
  return await localAuthentication
      .authenticateWithBiometrics(
        localizedReason: 'Scan your fingerprint to authenticate',
      )
      .catchError((onError) => print(onError));
}
