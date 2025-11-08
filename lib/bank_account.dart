//1. Base class
// ignore_for_file: unnecessary_getters_setters, unnecessary_brace_in_string_interps, prefer_final_fields

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
    print("Transaction History:");
    if (_transactions.isEmpty) {
      print(" - No transactions yet.");
    } else {
      for (var t in _transactions) {
        print(" - $t");
      }
    }
  }

  //For transaction history
  List<String> _transactions = [];

  List<String> get transactions {
    return _transactions;
  }

  void addTransaction(String message) {
    _transactions.add(message);
  }
}

// Create InterestBearing interface
abstract class InterestBearing {
  void calculateInterest();
}

//2. Implement three types of accounts that inherit from BankAccount
class SavingsAccount extends BankAccount implements InterestBearing {
  final double _minBalance = 500;
  final double _interestRate = 0.02;
  double _withdrawCount = 0;
  final double _withdrawLimit = 3;
  SavingsAccount(super._accNumber, super._accHolderName, super._balance);

  @override
  double deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      addTransaction("Deposited \$${amount}");
      print("Deposited \$${amount}. New Balance: \$${_balance}");
    } else {
      print("Invalid deposit amount!");
    }
    return _balance;
  }

  @override
  double withdraw(double amount) {
    if (_withdrawCount >= _withdrawLimit) {
      print("Withdrawal limit reached.");
    } else if (balance - amount < _minBalance) {
      print("Cannot withdraw below minimum balance.");
    } else {
      balance -= amount;
      _withdrawCount++;
      addTransaction("Withdrew \$${amount}");
      print("Withdrew \$${amount}. New Balance: \$${balance}");
    }
    return balance;
  }

  @override
  void calculateInterest() {
    double interest = balance * _interestRate;
    balance += interest;
    addTransaction("Interest added: \$${interest}");
    print("Interest \$${interest} added. New Balance: \$${balance}");
  }
}

class CheckingAccount extends BankAccount {
  final double _overdraftFee = 500;
  CheckingAccount(super._accNumber, super._accHolderName, super._balance);

  @override
  double deposit(double amount) {
    if (amount > 0) {
      balance += amount;
      addTransaction("Deposited \$${amount}");
      print("Deposited \$${amount}. New Balance: \$${balance}");
    } else {
      print("Invalid deposit amount.");
    }
    return balance;
  }

  @override
  double withdraw(double amount) {
    if (amount <= 0) {
      print("Invalid withdrawal amount.");
    } else if (balance - amount < 0) {
      balance -= (amount + _overdraftFee);
      addTransaction(
        "Overdraft withdrawal: \$${amount} + fee \$${_overdraftFee}",
      );
      print("Overdraft! Fee charged. New Balance: \$${balance}");
    } else {
      balance -= amount;
      addTransaction("Withdrew \$${amount}");
      print("Withdrew \$${amount}. New Balance: \$${balance}");
    }
    return balance;
  }
}

class PremiumAccount extends BankAccount implements InterestBearing {
  final double _minBalance = 10000;
  final double _interestRate = 0.05;

  PremiumAccount(super._accountNumber, super._accountHolder, super._balance);

  @override
  double deposit(double amount) {
    if (amount > 0) {
      _balance = _balance + amount;
      addTransaction("Deposited \$${amount}");
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
      addTransaction("Withdrew \$${amount}");
      print("Withdrawn \$${amount}. Current Balance: \$${_balance}");
    }
    return _balance;
  }

  @override
  void calculateInterest() {
    double interest = balance * _interestRate;
    balance += interest;
    addTransaction("Interest added: \$${interest}");
    print("Interest \$${interest} added. New Balance: \$${balance}");
  }
}

class Bank {
  List<BankAccount> _accounts = [];

  // Add a new account
  void addAccount(BankAccount account) {
    _accounts.add(account);
    print("Account Number ${account.accountNumber} added successfully.");
  }

  // Find account by account number
  BankAccount? findAccount(int accountNumber) {
    for (int i = 0; i < _accounts.length; i++) {
      if (_accounts[i].accountNumber == accountNumber) {
        return _accounts[i];
      }
    }
    print("Account Number $accountNumber not found.");
    return null;
  }

  // Transfer money between accounts
  void transfer(int fromAccNo, int toAccNo, double amount) {
    BankAccount? fromAccount = findAccount(fromAccNo);
    BankAccount? toAccount = findAccount(toAccNo);

    if (fromAccount != null && toAccount != null) {
      double beforeBalance = fromAccount.balance;
      fromAccount.withdraw(amount);
      if (fromAccount.balance != beforeBalance) {
        toAccount.deposit(amount);
        print(
          "Transferred \$${amount} from Account $fromAccNo to Account $toAccNo.",
        );
      } else {
        print("Transfer failed due to insufficient balance or limits.");
      }
    } else {
      print("Transfer failed. One or both accounts not found.");
    }
  }

  // Generate report of all accounts
  void generateReport() {
    print("\n===== BANK ACCOUNTS REPORT =====");
    for (int i = 0; i < _accounts.length; i++) {
      _accounts[i].displayAccInfo();
      print("-------------------------------");
    }
  }

  void applyMonthlyInterest() {
    print("\nApplying monthly interest to all eligible accounts...");
    for (int i = 0; i < _accounts.length; i++) {
      if (_accounts[i] is InterestBearing) {
        (_accounts[i] as InterestBearing).calculateInterest();
      }
    }
  }
}

class StudentAccount extends BankAccount {
  final double _maxBalance = 5000;
  StudentAccount(super._accountNumber, super._accountHolder, super._balance);

  @override
  @override
  double deposit(double amount) {
    if (balance + amount > _maxBalance) {
      print("Cannot deposit. Maximum balance of \$$_maxBalance exceeded.");
    } else if (amount > 0) {
      balance += amount;
      addTransaction("Deposited \$${amount}");
      print("Deposited \$${amount}. New Balance: \$${balance}");
    } else {
      print("Invalid deposit amount!");
    }
    return balance;
  }

  @override
  double withdraw(double amount) {
    if (amount <= 0) {
      print("Invalid withdrawal amount.");
    } else if (amount > balance) {
      print("Insufficient balance.");
    } else {
      balance -= amount;
      addTransaction("Withdrew \$${amount}");
      print("Withdrew \$${amount}. New Balance: \$${balance}");
    }
    return balance;
  }
}
