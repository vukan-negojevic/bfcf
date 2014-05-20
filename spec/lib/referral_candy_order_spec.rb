require 'spec_helper'

describe ReferralCandyOrder do
  before do
    allow(AppConfig).to receive(:referralcandy_account_secret) { "secret" }
  end

  let(:order) { ReferralCandyOrder.new_from_encoded_data(encoded_data) }

  context 'when initialized with nil data' do
    let(:encoded_data) { nil }

    it 'sets its data to nil' do
      expect(order.data).to be_nil
    end

    it 'returns nil for all fields' do
      expect(order.currency).to be_nil
      expect(order.invoice_amount).to be_nil
      expect(order.timestamp).to be_nil
      expect(order.email).to be_nil
      expect(order.first_name).to be_nil
      expect(order.last_name).to be_nil
      expect(order.md5).to eq Digest::MD5.hexdigest(",,,,secret")
    end

    it 'returns the right hash' do
      expect(order.as_json_for_widget).to eq({
        "data-fname" => "",
        "data-lname" => "",
        "data-email" => "",
        "data-amount" => "",
        "data-currency" => "",
        "data-timestamp" => "",
        "data-signature" => Digest::MD5.hexdigest(",,,,secret")
      })
    end
  end

  context 'when initialized with non-string data' do
    let(:encoded_data) { 123 }

    it 'sets its data to nil' do
      expect(order.data).to be_nil
    end

    it 'returns nil for all fields' do
      expect(order.currency).to be_nil
      expect(order.invoice_amount).to be_nil
      expect(order.timestamp).to be_nil
      expect(order.email).to be_nil
      expect(order.first_name).to be_nil
      expect(order.last_name).to be_nil
      expect(order.md5).to eq Digest::MD5.hexdigest(",,,,secret")
    end

    it 'returns the right hash' do
      expect(order.as_json_for_widget).to eq({
        "data-fname" => "",
        "data-lname" => "",
        "data-email" => "",
        "data-amount" => "",
        "data-currency" => "",
        "data-timestamp" => "",
        "data-signature" => Digest::MD5.hexdigest(",,,,secret")
      })
    end
  end

  context 'when initialized with bogus data' do
    let(:encoded_data) { "anVuaw==\n" }

    it 'sets its data to nil' do
      expect(order.data).to be_nil
    end

    it 'returns nil for all fields' do
      expect(order.currency).to be_nil
      expect(order.invoice_amount).to be_nil
      expect(order.timestamp).to be_nil
      expect(order.email).to be_nil
      expect(order.first_name).to be_nil
      expect(order.last_name).to be_nil
      expect(order.md5).to eq Digest::MD5.hexdigest(",,,,secret")
    end

    it 'returns the right hash' do
      expect(order.as_json_for_widget).to eq({
        "data-fname" => "",
        "data-lname" => "",
        "data-email" => "",
        "data-amount" => "",
        "data-currency" => "",
        "data-timestamp" => "",
        "data-signature" => Digest::MD5.hexdigest(",,,,secret")
      })
    end
  end

  context 'when initialized with valid json data that does not have the required fields' do
    let(:encoded_data) { "eyJhIiA6IDF9\n" }

    it 'sets its data to a hash' do
      expect(order.data).to eq({"a"=>1})
    end

    it 'returns nil for all fields' do
      expect(order.currency).to be_nil
      expect(order.invoice_amount).to be_nil
      expect(order.timestamp).to be_nil
      expect(order.email).to be_nil
      expect(order.first_name).to be_nil
      expect(order.last_name).to be_nil
      expect(order.md5).to eq Digest::MD5.hexdigest(",,,,secret")
    end

    it 'returns the right hash' do
      expect(order.as_json_for_widget).to eq({
        "data-fname" => "",
        "data-lname" => "",
        "data-email" => "",
        "data-amount" => "",
        "data-currency" => "",
        "data-timestamp" => "",
        "data-signature" => Digest::MD5.hexdigest(",,,,secret")
      })
    end
  end

  context 'when initialized with valid data' do
    let(:encoded_data) { "eyJpZCI6IjEwMTQ1NjE3OSIsInN0YXR1cyI6InBhaWRfYmFsYW5jZSIsIm5h\nbWUiOiJmcmVlcHJvZHVjdCIsImltYWdlIjoiaHR0cHM6Ly9kcGFvNm1hOGVx\na3gwLmNsb3VkZnJvbnQubmV0L2Fzc2V0cy9pbWcvY2VsZXJ5LWxvZ28tc21h\nbGwucG5nIiwic2x1ZyI6IjFvZWVpZiIsImF1dG9fY2hhcmdlIjoibm8iLCJz\nZWxsZXIiOnsiX2lkIjoiNTM2NTdhOTUyNjNjMjUwNTAwYzZjMmU0IiwiZW1h\naWwiOiJpbmZvQGJ1dHRlcmZsZXllLmNvIiwibmFtZSI6IkJ1dHRlcmZsZXll\nIiwicGF5cGFsX2VtYWlsIjoiIn0sImJ1eWVyIjp7ImVtYWlsIjoic3R1cGFr\nb3YrYmY5QGdtYWlsLmNvbSIsIm5hbWUiOiJBbGV4IEcgVGhpc0lzTXlMYXN0\nTmFtZSIsImFkZHJlc3MiOnsiY29tcGFueV9uYW1lIjoiIiwic3RyZWV0Ijoi\nIiwic3RyZWV0MiI6IiIsImNpdHkiOiIiLCJzdGF0ZSI6IiIsInppcCI6IiIs\nImNvdW50cnkiOiIiLCJwaG9uZSI6IiJ9LCJiaWxsaW5nIjp7InN0cmVldCI6\nIiIsImNpdHkiOiIiLCJzdGF0ZSI6IiIsInppcCI6IiIsImNvdW50cnkiOiIi\nfX0sInBheW1lbnQiOnt9LCJwcm9kdWN0cyI6W3siX2lkIjoiNTM2ODY2MjRi\nN2I2NTAwNDAwNjdiZmUxIiwidXNlcl9pZCI6IjUzNjU3YTk1MjYzYzI1MDUw\nMGM2YzJlNCIsInNsdWciOiIxb2VlaWYiLCJuYW1lIjoiZnJlZXByb2R1Y3Qi\nLCJpbWFnZSI6IiIsInByaWNlIjowLCJkZXBvc2l0IjowLCJzaGlwcGluZyI6\nMCwicXVhbnRpdHkiOjEsImNhbXBhaWduIjp7ImVuYWJsZWQiOmZhbHNlLCJy\nZXZlbnVlX2dvYWwiOjAsInNvbGRfZ29hbCI6MH0sIm9wdGlvbnMiOlt7Im5h\nbWUiOiJTaGlwcGluZyIsInZhbHVlIjoiVVNBIiwicHJpY2UiOjB9XSwiZXh0\ncmFzIjpbXX1dLCJjb3Vwb24iOnt9LCJzdWJ0b3RhbCI6MCwidG90YWwiOjAs\nImRlcG9zaXQiOjAsImJhbGFuY2UiOjAsImRpc2NvdW50IjowLCJzaGlwcGlu\nZyI6MCwidGF4ZXMiOjAsImN1cnJlbmN5IjoidXNkIiwiY2VsZXJ5X3BheW1l\nbnRfdG9rZW4iOm51bGwsImNhcmQiOnsibGFzdDQiOm51bGwsInR5cGUiOm51\nbGwsImV4cF9tb250aCI6bnVsbCwiZXhwX3llYXIiOm51bGx9LCJ0cmFja2lu\nZyI6eyJ0eXBlIjoib3ZlcmxheSIsImluZGV4IjoiMSIsImRvbWFpbiI6InBy\nZW9yZGVyLWRlbW8uZ2V0YnV0dGVyZmxleWUuY29tIn0sImZ1bGZpbGxtZW50\nIjp7InNoaXBwZWQiOmZhbHNlfSwibm90ZXMiOiIiLCJjb25maXJtYXRpb25f\ndXJsIjoiaHR0cDovL2J1dHRlcmZsZXllLWRlbW8uaGVyb2t1YXBwLmNvbS9v\ncmRlcl9jb25maXJtYXRpb25zL25ldyIsInVwZGF0ZWQiOjE0MDAyOTkyMzQ0\nNTgsInVwZGF0ZWRfZGF0ZSI6IjIwMTQtMDUtMTdUMDQ6MDA6MzQuNDU4WiIs\nImNyZWF0ZWQiOjE0MDAyOTkyMzQ0NTgsImNyZWF0ZWRfZGF0ZSI6IjIwMTQt\nMDUtMTdUMDQ6MDA6MzQuNDU4WiIsIl9pZCI6IjUzNzZkZWUyNzY3ZGY2MDUw\nMDkwN2RiNyJ9\n" }

    it 'sets its data to a hash' do
      expect(order.data).to be_a(Hash)
    end

    it 'returns correct values for all fields' do
      expect(order.currency).to eq("USD")
      expect(order.invoice_amount).to eq 0
      expect(order.timestamp).to eq 1400299234
      expect(order.email).to eq "stupakov+bf9@gmail.com"
      expect(order.first_name).to eq "Alex"
      expect(order.last_name).to eq "ThisIsMyLastName"
      expect(order.md5).to eq Digest::MD5.hexdigest("stupakov+bf9@gmail.com,Alex,0.0,1400299234,secret")
    end

    it 'returns the right hash' do
      expect(order.as_json_for_widget).to eq({
        "data-fname" => "Alex",
        "data-lname" => "ThisIsMyLastName",
        "data-email" => "stupakov+bf9@gmail.com",
        "data-amount" => "0.0",
        "data-currency" => "USD",
        "data-timestamp" => "1400299234",
        "data-signature" =>  Digest::MD5.hexdigest("stupakov+bf9@gmail.com,Alex,0.0,1400299234,secret")
      })
    end
  end
end
