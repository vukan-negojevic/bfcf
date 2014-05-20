class ReferralCandyOrder
  include ActionView::Helpers::NumberHelper

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.new_from_encoded_data(encoded_data)
    return new(nil) unless encoded_data.is_a? String
    decoded_string = Base64.decode64(encoded_data)

    begin
      data = JSON.parse(decoded_string)
    rescue JSON::ParserError
      data = nil
    end

    new(data)
  end

  # MD5(EMAIL,FIRST_NAME,INVOICE_AMOUNT,TIMESTAMP,ACCOUNT_SECRET)
  def md5
    account_secret = AppConfig.referralcandy_account_secret

    string = [email, first_name, invoice_amount, timestamp, account_secret].join(',')

    Digest::MD5.hexdigest(string)
  end

  def currency
    return nil if data.nil?
    data.fetch("currency", nil).try(:upcase)
  end

  # dollars, float
  def invoice_amount
    return nil if data.nil?
    t = data.fetch("total", nil)
    return nil if t.nil?
    t.to_i / 100.0
  end

  def timestamp
    return nil if data.nil?
    milliseconds = data.fetch("created", nil)
    seconds = milliseconds.nil? ? nil : milliseconds / 1000
    seconds
  end

  def email
    return nil if data.nil?
    buyer.nil? ? nil : buyer.fetch("email", nil)
  end

  def name
    return nil if data.nil?
    buyer.nil? ? nil : buyer.fetch("name", nil)
  end

  def first_name
    name.nil? ? nil : name.split.first
  end

  def last_name
    name.nil? ? nil : name.split.last
  end

  def as_json_for_widget
  {
    "data-fname" => first_name.to_s,
    "data-lname" => last_name.to_s,
    "data-email" => email.to_s,
    "data-amount" => invoice_amount.to_s,
    "data-currency" => currency.to_s,
    "data-timestamp" => timestamp.to_s,
    "data-signature" => md5.to_s
  }
  end

  private

  def buyer
    return nil if data.nil?
    data.fetch("buyer", nil)
  end
end
