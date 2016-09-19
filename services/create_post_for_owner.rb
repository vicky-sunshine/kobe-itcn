# Create new post for an owner
class CreatePostForOwner
  def self.call(account:, title:, content: nil)
    saved_post = account.add_owned_post(name: name)
    saved_post.repo_url = repo_url if repo_url
    saved_post.save
  end
end
