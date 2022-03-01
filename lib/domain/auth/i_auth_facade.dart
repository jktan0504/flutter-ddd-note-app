import 'package:dartz/dartz.dart';
import 'package:domain_driven/domain/auth/auth_failure.dart';
import 'package:domain_driven/domain/auth/value_objects.dart';

// interface = i
abstract class IAuthFacade {
	Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
		required EmailAddress emailAddress,
		required Password password
	});

	Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
		required EmailAddress emailAddress,
		required Password password
	});

	Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
