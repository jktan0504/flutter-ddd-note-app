import 'package:dartz/dartz.dart';
import 'package:domain_driven/domain/core/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class ValueObject<T> {

	const ValueObject();

	// Left - input, Right - correct
	Either<ValueFailure<T>, T> get value;

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