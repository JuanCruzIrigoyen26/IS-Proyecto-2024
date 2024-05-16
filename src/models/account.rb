class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :nickname, presence: true
  validates :progress, presence: true

  def correct_format_of_fields?
    email_regex = /^[a-zA-Z0-9_.+-]+@(gmail|outlook|hotmail|live)\.[a-z.]+$/
    password_regex = /(?=(?:.*[A-Z].*)+)(?=(?:.*[a-z].*)+)(?=(?:.*\d.*)+)(?!(?:.*\s.*)+)^(?=.{8,}$).*/
    name_regex = /(?=(?:^\D*$)+)/
    nickname_regex = /(?=(?:^\S*$)+)/

    email.match(email_regex) && password.match(password_regex) && name.match(name_regex) && nickname.match(nickname_regex)
  end
end
