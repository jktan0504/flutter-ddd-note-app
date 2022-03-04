import 'package:dartz/dartz.dart';
import 'package:domain_driven/domain/core/errors.dart';
import 'package:domain_driven/domain/core/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class ValueObject<T> {

	const ValueObject();

	// Left - input, Right - correct
	Either<ValueFailure<T>, T> get value;

	/// Helper Class
	/// Throw [UnexpectedValueError] containing the [ValueFailure]
	T getOrCrash() {
		// return value.fold((l) => throw UnexpectedValueError(l), (r) => r);
		// id = identity - same as writing (right) => right
		return value.fold((l) => throw UnexpectedValueError(l), id);
	}

	bool isValid() => value.isRight();

	@override
	bool operator ==(Object other) {
		if (identical(this, other)) return true;
	
		return other is ValueObject<T> &&
		other.value == value;
	}

	@override
	int get hashCode => value.hashCode;

	@override
	String toString() => 'ValueObject($value)';
}