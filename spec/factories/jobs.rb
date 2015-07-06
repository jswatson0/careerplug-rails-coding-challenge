FactoryGirl.define do
  factory :job do |f|
    f.name "Dog Walker"
    f.description "Must be able to walk 20 dogs at the same time"
    f.status 1
    f.employment_type 1
  end
end