module HomeHelper
  def likes_intersect(likes1, likes2)
    likes2_id_set = likes2.map { |e| e['id'] }.to_set
    likes1.select {|e| likes2_id_set.include? e['id'] }
  end
end
