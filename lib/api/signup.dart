import 'package:data/data.dart';
import 'package:jaguar/jaguar.dart';

Future<Response> signup(Context context) async {
  final body = await context.bodyAsJson<SignupRequest, Map>(
      convert: SignupRequestSerializer.serializer.fromMap);

  // TODO validate body
  {
    final validationErrs = body.validate();
    if(validationErrs.isNotEmpty) {
      // TODO return errors
    }
  }


  // TODO
}
