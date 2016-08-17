require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Mercadopago < OmniAuth::Strategies::OAuth2
      option :name, "mercadopago"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        authorize_url: "https://auth.mercadopago.com.ar/authorization",
        token_url: "https://api.mercadopago.com/oauth/token"
      }

      def setup_phase
        binding.pry
        super
        binding.pry
      end

      def request_phase
        binding.pry
        super
      end

      def callback_phase
        binding.pry
        super
      end

      def callback_url
        options[:callback_url] || super
      end
    end
  end
end
