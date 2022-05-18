import 'package:to_string_pretty/to_string_pretty.dart';

class Memoized<V> {
  final V Function() _computation;
  bool _expired = true;
  V? _memoized;

  Memoized(this._computation);

  V call({bool shouldUpdate = false}) {
    if (shouldUpdate || _expired) {
      _memoized = _computation();
      _expired = false;
    }
    return _memoized!;
  }

  void expire() => _expired = true;

  @override
  String toString() => toStringPretty(this, {
        'functionType': '$V Function()',
        'lastComputation': _memoized?.toString() ?? 'not computed yet',
        'expired': '$_expired',
      });
}

extension Memo0Ext<V> on V Function() {
  Memoized<V> get memo => Memoized(this);
}
