FactoryGirl.define do
  factory :bookmark do
    url "www.test.com/bookmark"
    name "Test Bookmark"
    user nil
    topic nil
  end

end
