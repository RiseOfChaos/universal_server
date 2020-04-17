import 'package:data/data.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:universal_server/config/config.dart';
import 'package:universal_server/db/user.dart';

Future<Response> login(Context context) async {
  final body = await context.bodyAsJson<LoginRequest, Map>(
      convert: LoginRequestSerializer.serializer.fromMap);

  // TODO validate body
  {
    final validationErrs = body.validate();
    if (validationErrs.isNotEmpty) {
      // TODO return errors
    }
  }

  final config = context.getVariable<Config>(id: 'config');
  final user =
      await userDB.fetchByEmailOrUsername(config.pool, body.usernameOrEmail);

  if (user == null) {
    // TODO
  }

  String hashedPassword = body.password; // TODO hash
  if (hashedPassword != user.password) {
    // TODO
  }

  final now = DateTime.now().toUtc();
  final claimSet = JwtClaim(
      issuer: 'roc_universal_server',
      subject: user.id.toString(),
      expiry: now.add(config.session.expiry), issuedAt: now);
  final token = issueJwtHS256(claimSet, config.session.jwtKey);

  return Response.json(user /* TODO toView */,
      serializeWith: null /* TODO */, headers: {'Authorization': token});
}
