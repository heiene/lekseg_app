FactoryGirl.define do
  factory :user do
    name     "Snurre sprett"
    email    "snurre@sprett.com"
    password "foobar"
    password_confirmation "foobar"
  end
end