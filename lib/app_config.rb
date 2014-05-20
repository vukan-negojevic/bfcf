class AppConfig
  def self.celery_product_code
    result = ENV['CELERY_PRODUCT_CODE']
    Rails.logger.error("CELERY_PRODUCT_CODE not configured") if result.nil?
    result
  end

  #TODO rename this to REFERRALCANDY_APP_ID
  def self.referralcandy_tracking_code
    result = ENV['REFERRALCANDY_TRACKING_CODE']
    Rails.logger.error("REFERRALCANDY_TRACKING_CODE not configured") if result.nil?
    result
  end

  def self.referralcandy_account_secret
    result = ENV['REFERRALCANDY_ACCOUNT_SECRET']
    Rails.logger.error("REFERRALCANDY_ACCOUNT_SECRET not configured") if result.nil?
    result
  end

  def self.basic_auth_enabled
    ENV['BASIC_AUTH_ENABLED'] == "true"
  end

  def self.basic_auth_user
    ENV['BASIC_AUTH_USER']
  end

  def self.basic_auth_password
    ENV['BASIC_AUTH_PASSWORD']
  end

  def self.asset_host
    result = ENV['ASSET_HOST']
    Rails.logger.error("ASSET_HOST not configured") if result.nil?
    result
  end
end
