//1. Base class
abstract class BankAccount {
  final int _accountNumber;
  String _accountHolder;
  double _balance;

  BankAccount(this._accountNumber, this._accountHolder, this._balance);

  // Getter
  int get accountNumber {
    return _accountNumber;
  }

  String get accountHolder {
    return _accountHolder;
  }

  double get balance {
    return _balance;
  }

  //Setter
  set accountHolder(String holder) {
    _accountHolder = holder;
  }

  set balance(double newBalance) {
    _balance = newBalance;
  }

  double deposit(double amount);
  double withdraw(double amount);

  void displayAccInfo() {
    print("Account Number : $_accountNumber");
    print("Account Holder : $_accountHolder");
    print("Balance        : $_balance");
  }
}

// Create InterestBearing interface
abstract class InterestBearing {
  void calculateInterest();
}

//2. Implement three types of accounts that inherit from BankAccount
class SavingsAccount extends BankAccount implements InterestBearing {
  double _minBalance = 500;
  double _interestRate = 0.02;
  double _withdrawCount = 0;
  double _withdrawLimit = 3;
  SavingsAccount(super._accNumber, super._accHolderName, super._balance);

  @override
  double deposit(double amount) {
    if (amount > 0) {
      _balance = _balance + amount;
      print("Deposited \$${amount}. New Balance: \$${_balance}");
    } else {
      print("Invalid deposit amount!");
    }
    return _balance;
  }

  @override
  double withdraw(double amount) {
    if (_withdrawCount >= _withdrawLimit) {
      print("Withdrawal limit reached (3 per month).");
    } else if (_balance - amount < _minBalance) {
      print(
        "Cannot withdraw. Minimum balance of \$$_minBalance must be maintained.",
      );
    } else {
      _balance = _balance - amount;
      _withdrawCount++;
      print("Withdrawn \$${amount}. New Balance: \$${_balance}");
    }
    return _balance;
  }

  @override
  void calculateInterest() {
    double interest = _balance * _interestRate;
    _balance = _balance + interest;
    print("Interest of \$${interest} added. New Balance: \$${_balance}");
  }
}

class CheckingAccount extends BankAccount {
  double _overdraftFee = 500;
  CheckingAccount(super._accNumber, super._accHolderName, super._balance);

  @override
  double deposit(double amount) {
    if (amount > 0) {
      _balance = _balance + amount;
      print("Deposited \$${amount}. New Balance: \$${_balance}");
    } else {
      print("Invalid deposit amount!");
    }
    return _balance;
  }

  @override
  double withdraw(double amount) {
    if (amount <= 0) {
      print("Invalid withdrawal amount.");
    } else {
      _balance = _balance - amount;

      if (_balance < 0) {
        _balance = _balance - _overdraftFee;
        print("Overdraft occurred! Fee of \$$_overdraftFee applied.");
      }

      print("Withdrawn \$${amount}. Current Balance: \$${_balance}");
    }
    return _balance;
  }
}

class PremiumAccount extends BankAccount implements InterestBearing {
  double _minBalance = 10000;
  double _interestRate = 0.05;

  PremiumAccount(super._accountNumber, super._accountHolder, super._balance);

  @override
  double deposit(double amount) {
    if (amount > 0) {
      _balance = _balance + amount;
      print("Deposited \$${amount}. New Balance: \$${_balance}");
    } else {
      print("Invalid deposit amount!");
    }
    return _balance;
  }

  @override
  double withdraw(double amount) {
    if (amount <= 0) {
      print("Invalid withdrawal amount.");
    } else if (_balance - amount < _minBalance) {
      print(
        "Cannot withdraw. Minimum balance of \$$_minBalance must be maintained.",
      );
    } else {
      _balance = _balance - amount;
      print("Withdrawn \$${amount}. Current Balance: \$${_balance}");
    }
    return _balance;
  }

  @override
  void calculateInterest() {
    double interest = _balance * _interestRate;
    _balance = _balance + interest;
    print("Interest of \$${interest} added. New Balance: \$${_balance}");
  }
}
