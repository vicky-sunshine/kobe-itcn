require 'sinatra'
require 'json'

class KobeItcnAPI < Sinatra::Base
  enable :logging

  configure :production do
    use Rack::SslEnforcer
  end

  def authenticated_account(env)
    scheme, auth_token = env['HTTP_AUTHORIZATION'].split(' ')
    account_payload = JSON.load JWE.decrypt(auth_token)
    (scheme =~ /^Bearer$/i) ? account_payload : nil
  end

  def authorized_account?(env, username)
    account = authenticated_account(env)

    account['username'] == username
  rescue
    false
  end

  before do
    host_url = "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    @request_url = URI.join(host_url, request.path.to_s)
  end

  get '/?' do
    'Kobe ITCN web service is up and running at /api/v1'
  end
end
