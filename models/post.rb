require 'json'
require 'sequel'

# Holds a Project's information
class Post < Sequel::Model
  plugin :timestamps, update_on_create: true
  set_allowed_columns :title, :content

  many_to_one :owner, class: :Account

  def before_destroy
    DB[:accounts_posts].where(post_id: id).delete
    super
  end

  def to_json(options = {})
    JSON({  type: 'post',
            id: id,
            owner: owner.username,
            title: title,
            content: content
          },
         options)
  end
end
