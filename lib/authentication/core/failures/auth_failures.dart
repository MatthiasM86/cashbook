abstract class AuthFailure {}
class ServerFailure extends AuthFailure {}
class WeakPasswordFailure extends AuthFailure {}
class EmailAlreadyInUserFailure extends AuthFailure {}
class InvalidEmailAndPasswordCombinationFailure extends AuthFailure {}
class SendEmailVerificationNoSignedInUserFailure extends AuthFailure {}