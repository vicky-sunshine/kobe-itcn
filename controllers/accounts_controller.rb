# Sinatra Application Controllers
class KobeItcnAPI < Sinatra::Base
  # post a new account
  post '/api/v1/accounts/?' do
    begin
      data = JSON.parse(request.body.read)

      new_account = CreateAccount.call(
        username: data['username'],
        password: data['password'])
    rescue => e
      logger.info "FAILED to create new account: #{e.inspect}"
      halt 400
    end

    status 201
    JSON.pretty_generate(data: new_account)
  end

  # post a new post of this user
  post '/api/v1/accounts/:username/owned_posts/?' do
    begin
      username = params[:username]
      halt 401 unless authorized_account?(env, username)

      new_post_data = JSON.parse(request.body.read)
      account = Account.where(username: username).first
      saved_post = account.add_owned_post(new_post_data)
    rescue => e
      logger.info "FAILED to create new post: #{e.inspect}"
      halt 400
    end

    status 201
    JSON.pretty_generate(data: saved_post)
  end

  # get all posts of this user
  get '/api/v1/accounts/:username/owned_posts/?' do
    content_type 'application/json'

    begin
      account = Account.where(username: params[:username]).first
      owned_posts = account.owned_posts
      JSON.pretty_generate(data: owned_posts)
    rescue => e
      logger.info "FAILED to find posts for user #{params[:username]}: #{e}"
      halt 404
    end
  end
end
