import 'package:domain_driven/domain/auth/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
	const factory ValueFailure.invalidEmail({
		required String failedValue,
	}) = InvalidEmail<T>;

	const factory ValueFailure.shortPassword({
		required String failedValue,
	}) = ShortPassword<T>;
}


// Simple Use Case
void showiungTheEmailAddressOrFailureOnUI() {
	final emailAddress = EmailAddress('fafafa');

	// Inside UI - Method 1
	String emailText = emailAddress.value.fold(
		(l) => 'Failure happened, more precisely: $l', 
		(r) => r
	);

	// Inside UI - Method 2
	String emailText2 = emailAddress.value.getOrElse(() => 'Some failure happened');
}