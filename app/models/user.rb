class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end

  def can_add_stock?(ticker_symbol)
    under_stock_limit? and !stock_already_added?(ticker_symbol)
  end

  def under_stock_limit?
    (user_stocks.count < 10)
  end

  def self.search(param)
    return User.none if param.blank?
    param.strip!
    param.downcase
    ( match_firstname(param) + match_lastname(param) + match_email(param) ).uniq
  end


  def self.match_firstname(name)
    match('first_name', name)
  end
  def self.match_lastname(name)
    match('last_name', name)
  end
  def self.match_email(email)
    match('email', email)
  end
  def self.match(column, param)
    User.where("lower(#{column}) like ?", "%#{param}%")
  end



  def stock_already_added?(ticker_symbol)
    stock = Stock.find_by_ticker(ticker_symbol)
    return false unless stock
    user_stocks.where(stock_id: stock.id).exists? #WOW!
  end

  def not_friends_with?(user_id)
    friendships.where(friend_id: user_id).count < 1
  end

end
