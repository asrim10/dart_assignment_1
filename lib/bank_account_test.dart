import 'package:dart_assignment_1/bank_account.dart';

void main() {
  Bank myBank = Bank();

  //Accounts
  SavingsAccount sa1 = SavingsAccount(101, "Ram", 2000);
  CheckingAccount ca1 = CheckingAccount(102, "Shyam", 600);
  PremiumAccount pa1 = PremiumAccount(103, "Asrim", 15000);
  StudentAccount st1 = StudentAccount(104, "Rohit", 2000);

  //Add to Bank
  myBank.addAccount(sa1);
  myBank.addAccount(ca1);
  myBank.addAccount(pa1);
  myBank.addAccount(st1);

  sa1.deposit(200);
  sa1.calculateInterest();
  ca1.withdraw(700);
  pa1.calculateInterest();
  st1.deposit(4000);
  st1.deposit(2000);

  // Transfer money
  myBank.transfer(101, 103, 1000);
  myBank.transfer(105, 103, 1000);

  // Generate report of all accounts
  myBank.applyMonthlyInterest();
  myBank.generateReport();
}
