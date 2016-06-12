# is a container fo account's _wallet - represents a set of coins
class Wallet
  attr_accessor :coins
  ALLOWED_COINS = [1, 2, 5, 10, 25, 50].freeze
  STR_ALLOWED_COINS = ALLOWED_COINS.map(&:to_s).freeze

  def initialize(options = {})
    @coins = options.each_with_object({}) { |pair, o| o[pair[0].to_i] = pair[1] }
  end

  def total_sum
    @coins.inject(0) { |a, e| a + e[0] * e[1] }
  end

  def add(options)
    extract_number_options(options).each { |coin, value| @coins[coin.to_i] = (@coins[coin.to_i] || 0) + value.to_i }
  end

  def remove(options)
    extract_number_options(options).each { |coin, value| @coins[coin.to_i] = (@coins[coin.to_i] || 0) - value.to_i }
  end

  def change(sum)
    coin_type, coin_number = @coins.to_a.sort { |a, b| b[0] <=> a[0] }.transpose
    return {} unless find_change(coin_type, coin_number, sum)
    hash = Hash[coin_type.zip(coin_number).select { |pair| pair[1] > 0 }]
    remove(hash)
    hash
  end

  def as_json(_options = {})
    @coins.as_json
  end

  def serializable_hash(_options = {})
    as_json
  end

  private

  def extract_number_options(options)
    options.slice(*(STR_ALLOWED_COINS + ALLOWED_COINS))
  end

  def find_change(coin_type, coin_number, change, index = 0)
    total_coin = coin_type.each_with_index.map { |c, i| c * coin_number[i] }.inject(&:+)
    return false if change > total_coin
    return true if change == total_coin
    (index...coin_type.size).each do |i|
      temp = coin_number[i]
      while coin_number[i] > 0
        coin_number[i] -= 1
        return true if find_change(coin_type, coin_number, change, i)
      end
      coin_number[i] = temp
    end
    false
  end
end
