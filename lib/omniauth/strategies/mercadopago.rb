require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Mercadopago < OmniAuth::Strategies::OAuth2
      API_ROOT_URL  = "https://api.mercadopago.com"
      AUTH_URL      = "https://auth.mercadopago.com/authorization"
      OAUTH_URL     = "/oauth/token"

      option :name, "mercadopago"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        site: API_ROOT_URL,
        authorize_url: AUTH_URL,
        token_url: OAUTH_URL
      }

      def request_phase
        super
      end

      def callback_url
        # As ariginally was in the omniauth-oauth2 gem
        # https://github.com/intridea/omniauth-oauth2/pull/70/files
        full_host + script_name + callback_path
      end

      def authorize_params
        logger.info " === callback_url: #{callback_url} === "
        super.tap do |params|
          params[:response_type ] = "code"
          params[:client_id]      = client.id
          params[:redirect_uri]   = callback_url.to_s.downcase
        end
      end

      def build_access_token
        logger.info " === build_access_token callback_url= #{callback_url} === "
        logger.info " === build_access_token options= #{options} === "
        token_params = {
          code:           request.params['code'],
          redirect_uri:   callback_url.to_s.downcase,
          client_id:      client.id,
          client_secret:  client.secret,
          grant_type:     'authorization_code'
        }
        client.get_token(token_params)
      end

      # data response of api
      uid { raw_info['id'].to_s }

      info do
        prune!({
          username:   raw_info['nickname'],
          email:      raw_info['email'],
          first_name: raw_info['first_name'],
          last_name:  raw_info['last_name'],
          image:      raw_info['logo'],
          url:        raw_info['permalink']
        })
      end

      extra do
        hash = {}
        hash[:access_token] = access_token.to_hash
        hash[:raw_info] = raw_info unless skip_info?
        prune! hash
      end

      def raw_info
        @raw_info ||= access_token.get("users/me", params_token).parsed
      end

      def params_token
        { params: access_token.to_hash }
      end

      private

      def logger
        OmniAuth.logger
      end

      def raw_info
        @raw_info ||= access_token.get("users/me", params_token).parsed
      end

      def params_token
        { params: access_token.to_hash }
      end

      def prune!(hash)
        hash.delete_if do |_, v|
          prune!(v) if v.is_a?(Hash)
          v.nil? || (v.respond_to?(:empty?) && v.empty?)
        end
      end
    end
  end
end
