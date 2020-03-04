FactoryBot.define do

  factory :user do
    nickname              {"test"}
    email                 {"test@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    firstname             {"手洲斗"}
    lastname              {"太郎"}
    firstname_kana        {"テスト"}
    lastname_kana         {"タロウ"}
    birthday              {20000101}
  end

end