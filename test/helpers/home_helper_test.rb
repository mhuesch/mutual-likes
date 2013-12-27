require 'test_helper'

class HomeHelperTest < ActionView::TestCase
  test "should find likes intersection" do
    likes1 = [{"category"=>"Games/toys", "name"=>"Tiny Tower", "created_time"=>"2012-01-19T16:56:40+0000", "id" => "129299050489723"}, {"category"=>"Movie", "name"=>"Batman Begins", "created_time"=>"2012-01-07T13:37:49+0000", "id"=>"246344278767961"}, {"category"=>"Movie", "name"=>"Captain America", "created_time"=>"2012-01-04T20:09:03+0000", "id"=>"122352024462380"}]
    likes2 = [{"category"=>"Tv show", "name"=>"Malcolm in the Middle", "created_time"=>"2011-10-26T17:13:09+0000", "id"=>"107716979257871"}, {"category"=>"Movie", "name"=>"Captain America", "created_time"=>"2012-01-04T20:09:03+0000", "id"=>"122352024462380"}]
    result = [{"category"=>"Movie", "name"=>"Captain America", "created_time"=>"2012-01-04T20:09:03+0000", "id"=>"122352024462380"}]
    assert_equal likes_intersect(likes1, likes2), result
    assert_equal likes_intersect(likes2, likes1), result
  end

  test "should intersect empty lists" do
    assert_equal likes_intersect([],[]), []
  end

  test "should intersect with empty to get empty" do
    likes1 = [{"category"=>"Games/toys", "name"=>"Tiny Tower", "created_time"=>"2012-01-19T16:56:40+0000", "id" => "129299050489723"}, {"category"=>"Movie", "name"=>"Batman Begins", "created_time"=>"2012-01-07T13:37:49+0000", "id"=>"246344278767961"}, {"category"=>"Movie", "name"=>"Captain America", "created_time"=>"2012-01-04T20:09:03+0000", "id"=>"122352024462380"}]
    assert_equal likes_intersect(likes1, []), []
    assert_equal likes_intersect([], likes1), []
  end
end
