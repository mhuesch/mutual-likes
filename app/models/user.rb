class User < ActiveRecord::Base
  has_many :authorizations

  def self.create_from_hash!(hash)
    create! do |user|
      user.name = hash['info']['name']
      user.uid = hash['uid']
      user.token = hash['credentials']['token']
    end
  end
end
