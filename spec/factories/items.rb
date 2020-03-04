FactoryBot.define do

  factory :item do
    title                 {"サッカーボール"}
    description           {"testtesttest"}
    condition_id          {1}
    postage_id            {1}
    prefecture_id         {1}
    schedule_id           {1}
    price                 {1000}
    user_id               {1}
    category_id           {1}
    image
  end

end