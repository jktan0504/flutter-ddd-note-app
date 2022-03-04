import 'package:dartz/dartz.dart';
import 'package:domain_driven/domain/core/failures.dart';

class UnexpectedValueError extends Error {
	final ValueFailure valueFailure;

  	UnexpectedValueError(this.valueFailure);

	@override
	String toString() {
		const explanation = 'Encountered a ValueFailure at an unrecoverable point.';
		return Error.safeToString('$explanation Terminating. Failure as $valueFailure');
	}
	
}