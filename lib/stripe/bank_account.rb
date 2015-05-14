module Stripe
  class BankAccount < APIResource
    def url
      if respond_to?(:customer)
        "#{Customer.url}/#{CGI.escape(customer)}/bank_accounts/#{CGI.escape(id)}/verify"
      end
    end

    def verify(amount_1, amount_2)
      values = self.class.serialize_params(self).merge({amounts: [amount_1, amount_2]})

      if values.length > 0
        values.delete(:id)

        response, opts = request(:post, url, values)
        refresh_from(response, opts)
      end
    end
  end
end
