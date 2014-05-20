class OrderConfirmationsController < ApplicationController
  before_filter :set_skip_header_flag

  def new
    encoded_order_info = params[:order]

    if encoded_order_info.nil?
      logger.debug "Order confirmation without order param"
    else
      order = ReferralCandyOrder.new_from_encoded_data(encoded_order_info)
      if order.data.nil?
        logger.debug "Failed to decode order param for order confirmation"
      else
        @order_hash = order.as_json_for_widget.merge({
          "data-app-id" => AppConfig.referralcandy_tracking_code
        })
      end
    end
  end

  private

  def set_skip_header_flag
    @skip_header = true
  end
end
