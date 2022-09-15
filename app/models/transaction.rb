class Transaction < ApplicationRecord
  belongs_to :account

  after_save :do_transaction_on_balance

  def do_transaction_on_balance
    transaction_kind = self.transaction_kind
    transaction_value = self.transaction_value
    account_id = self.account_id

    if transaction_kind == "depositar"
      account = Account.find(account_id)
      new_balance = account.balance + transaction_value
      account.update(balance: new_balance)
    elsif transaction_kind == "sacar"
      account = Account.find(account_id)
      new_balance = account.balance - transaction_value
      account.update(balance: new_balance)
    end
  end
end
