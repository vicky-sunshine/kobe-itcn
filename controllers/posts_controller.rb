# Sinatra Application Controllers
class KobeItcnAPI < Sinatra::Base
  # get all posts
  get '/api/v1/posts/?' do
    content_type 'application/json'

    begin
      posts = Post.all
      JSON.pretty_generate(data: posts)
    rescue => e
      logger.info "FAILED to find projects for user #{params[:username]}: #{e}"
      halt 404
    end
  end
end
