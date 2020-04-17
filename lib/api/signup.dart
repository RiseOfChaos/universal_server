import 'package:data/data.dart';
import 'package:jaguar/jaguar.dart';

import 'package:universal_server/config/config.dart';
import 'package:universal_server/db/user.dart';

Future<Response> signup(Context context) async {
  final body = await context.bodyAsJson<SignupRequest, Map>(
      convert: SignupRequestSerializer.serializer.fromMap);

  // TODO validate body
  {
    final validationErrs = body.validate();
    if (validationErrs.isNotEmpty) {
      // TODO return errors
    }
  }

  // TODO check that username does not exist
  // TODO check that password does not exist

  final config = context.getVariable<Config>(id: 'config');
  String hashedPassword = body.password; // TODO hash
  final user = await userDB.insert(
      config.pool, body.username, body.email, hashedPassword);

  // TODO send email with verification code

  return Response('', statusCode: 204);
}
