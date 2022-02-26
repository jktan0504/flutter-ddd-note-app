import 'package:dartz/dartz.dart';
import 'package:domain_driven/domain/core/failures.dart';
import 'package:domain_driven/domain/core/value_objects.dart';
import 'package:domain_driven/domain/core/value_validators.dart';

class EmailAddress extends ValueObject<String> {
	// Left - input, Right - correct
	final Either<ValueFailure<String>, String> value;

	factory EmailAddress(String input) {
		// ignore: unnecessary_null_comparison
		assert(input != null);
		return EmailAddress._(
			validateEmailAddress(input)
		);
	}

	const EmailAddress._(this.value); // null safety
}

class Password extends ValueObject<String> {
	// Left - input, Right - correct
	final Either<ValueFailure<String>, String> value;

	factory Password(String input) {
		// ignore: unnecessary_null_comparison
		assert(input != null);
		return Password._(
			validatePassword(input)
		);
	}

	const Password._(this.value); // null safety
}


