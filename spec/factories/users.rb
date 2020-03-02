FactoryBot.define do

  factory :user do
    nickname                  {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    firstname             {"安倍"}
    lastname              {"晋三"}
    firstname_kana        {"アベ"}
    lastname_kana         {"シンゾウ"}
    birthday              {19971124}
  end

end