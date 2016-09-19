# Service object to create new accounts using all columns
class CreateAccount
  def self.call(username:, password:)
    account = Account.new(username: username)
    account.password = password
    account.save
  end
end
