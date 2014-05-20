module ReferralCandyHelper
  def popup_widget_div(order_info)
    return "" if order_info.nil?
<<HTML
<div
  id="refcandy-popsicle"
  data-app-id="#{order_info["data-app-id"]}"
  data-fname="#{order_info["data-fname"]}"
  data-lname="#{order_info["data-lname"]}"
  data-email="#{order_info["data-email"]}"
  data-amount="#{order_info["data-amount"]}"
  data-currency="#{order_info["data-currency"]}"
  data-timestamp="#{order_info["data-timestamp"]}"
  data-signature="#{order_info["data-signature"]}"
></div>
HTML
  end

  def popup_widget_script
<<HTML
<script>(function(e){var t,n,r,i,s,o,u,a,f,l,c,h,p,d,v;f="script";l="refcandy-purchase-js";c="refcandy-popsicle";p="go.referralcandy.com/purchase/";t="data-app-id";r={email:"a",fname:"b",lname:"c",amount:"d",currency:"e","accepts-marketing":"f",timestamp:"g","referral-code":"h",locale:"i",signature:"ab"};i=e.getElementsByTagName(f)[0];s=function(e,t){if(t){return""+e+"="+encodeURIComponent(t)}else{return""}};d=function(e){return""+p+h.getAttribute(t)+".js?lightbox=1&aa=75&"};if(!e.getElementById(l)){h=e.getElementById(c);if(h){o=e.createElement(f);o.id=l;a=function(){var e;e=[];for(n in r){u=r[n];v=h.getAttribute("data-"+n);e.push(s(u,v))}return e}();o.src=""+e.location.protocol+"//"+d(h.getAttribute(t))+a.join("&");return i.parentNode.insertBefore(o,i)}}})(document);</script>
HTML
  end

  #THIS CAN BE USED INSTEAD OF THE POPUP WIDGET
  def tracking_code
<<HTML
  <script type='text/javascript'>
    !function(d,s) {
      var rc = d.location.protocol + "//go.referralcandy.com/purchase/<%= AppConfig.referralcandy_tracking_code %>.js";
    var js = d.createElement(s);
    js.src = rc;
    var fjs = d.getElementsByTagName(s)[0];
    fjs.parentNode.insertBefore(js,fjs);
  }(document,"script");
  </script>
  end
HTML
  end
end
