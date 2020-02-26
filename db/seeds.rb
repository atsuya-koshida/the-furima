categories=[
  {level1:"レディース",level1_children:[
                                      {level2:"トップス",level2_children:["シャツ","キャミソール","タンクトップ","ニット/セーター","パーカー","その他"]},
                                      {level2:"ジャケット/アウター",level2_children:["ジャケット","ダウンベスト","ジャンパー/ブルゾン","ポンチョ","ロングコート","その他"]},
                                      {level2:"パンツ",level2_children:["デニム/ジーンズ","ショートパンツ","カジュアルパンツ","オールインワン","ガウチョパンツ","その他"]},
                                      {level2:"スカート",level2_children:["ミニスカート","ひざ丈スカート","ロングスカート","キュロット","その他"]},
                                      {level2:"ワンピース",level2_children:["ミニワンピース","ひざ丈ワンピース","ロングワンピース","その他"]},
                                      {level2:"靴",level2_children:["ハイヒール/パンプス","ブーツ","サンダル","スニーカー","ローファー/革靴","その他"]},
                                      {level2:"帽子",level2_children:["ニットキャップ/ビーニー","ハット","ハンチング/ベレー帽","キャップ","キャスケット","その他"]},
                                      {level2:"バッグ",level2_children:["ハンドバッグ","トートバッグ","エコバッグ","リュック/バックパック","ボストンバッグ","その他"]},
                                      {level2:"アクセサリー",level2_children:["ネックレス","ブレスレット","リング","ピアス","イヤリング","その他"]},
                                      {level2:"小物",level2_children:["財布","手袋","ハンカチ","ベルト","マフラー","時計","その他"]}
                                     ]
  },
  {level1:"メンズ",level1_children:[
                                      {level2:"トップス",level2_children:["シャツ","タンクトップ","ニット/セーター","パーカー","カーディガン","その他"]},
                                      {level2:"ジャケット/アウター",level2_children:["ジャケット","ピーコート","ステンカラーコート","トレンチコート","ダッフルコート","その他"]}
                                     ]
  },
  {level1:"ベビー・キッズ",level1_children:[
                                      {level2:"ベビー服",level2_children:["トップス","パンツ","スカート","肌着","パジャマ","その他"]},
                                      {level2:"キッズ服",level2_children:["トップス","パンツ","スカート","肌着","パジャマ","その他"]}
                                     ]
  },
  {level1:"インテリア・住まい・小物",level1_children:[
                                      {level2:"キッチン",level2_children:["食器","調理器具","キッチン雑貨","その他"]},
                                      {level2:"ベッド",level2_children:["マットレス","脚","システムベッド","その他"]}
                                     ]
  },
  {level1:"本・音楽・ゲーム",level1_children:[
                                      {level2:"本",level2_children:["絵本","漫画","雑誌","参考書","写真集","その他"]},
                                      {level2:"その他",level2_children:["CD","DVD","ゲーム","その他"]}
                                     ]
  },
  {level1:"ホビー",level1_children:[
                                      {level2:"おもちゃ",level2_children:["ぬいぐるみ","模型","ラジコン","キャラクターグッズ","その他"]},
                                      {level2:"その他",level2_children:["グッズ","カード","フィギュア","楽器","美術品","その他"]}
                                     ]
  },
  {level1:"コスメ・香水・美容",level1_children:[
                                      {level2:"化粧品",level2_children:["メイクアップ","ベースメイク","ネイルケア","スキンケア","ヘアケア","その他"]},
                                      {level2:"その他",level2_children:["香水","ボディケア","オーラルケア","ダイエット","その他"]}
                                     ]
  },
  {level1:"家電・スマホ・カメラ",level1_children:[
                                      {level2:"小物機器",level2_children:["スマートフォン","PC","カメラ","その他"]},
                                      {level2:"家電",level2_children:["テレビ","オーディオ機器","生活家電","美容/健康","その他"]}
                                     ]
  },
  {level1:"スポーツ・レジャー",level1_children:[
                                      {level2:"スポーツ",level2_children:["サッカー","野球","テニス","ゴルフ","フィッシング","その他"]},
                                      {level2:"レジャー",level2_children:["アウトドア","自転車","登山","旅行","スキー","その他"]}
                                     ]
  },
  {level1:"その他",level1_children:[
                                      {level2:"チケット",level2_children:["スポーツ","演劇","イベント","映画","割引券","その他"]},
                                      {level2:"自動車",level2_children:["本体","タイヤ","パーツ","アクセサリ","オートバイ","その他"]}
                                     ]
  }
]

categories.each.with_index(1) do |category,i|
level1_var="@category#{i}"
level1_val= Category.create(name:"#{category[:level1]}")
eval("#{level1_var} = level1_val")
category[:level1_children].each.with_index(1) do |level1_child,j|
level2_var="#{level1_var}_#{j}"
level2_val= eval("#{level1_var}.children.create(name:level1_child[:level2])")
eval("#{level2_var} = level2_val")
level1_child[:level2_children].each do |level2_children_val|
eval("#{level2_var}.children.create(name:level2_children_val)")
end
end
end