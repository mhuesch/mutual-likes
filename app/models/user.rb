class User < ActiveRecord::Base
  has_many :authorizations

  def self.create_from_hash!(hash)
    create! do |user|
      user.name = hash['info']['name']
      user.uid = hash['uid']
      user.token = hash['credentials']['token']
    end
  end

  def self.likes_intersect(likes1, likes2)
    likes2_id_set = likes2.map { |e| e['id'] }.to_set
    likes1.select {|e| likes2_id_set.include? e['id'] }
  end
end
