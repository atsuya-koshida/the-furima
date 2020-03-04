$(function(){

  // 画像のプレビューとそれの削除機能
  $(function(){

    //プレビューのhtmlを定義
    function buildHTML(count) {
      var html = `<div class="preview-box" id="preview-box__${count}">
                    <div class="upper-box">
                      <img src="" alt="preview">
                    </div>
                    <div class="lower-box">
                      <div class="delete-box" id="delete_btn_${count}">
                        <span>削除</span>
                      </div>
                    </div>
                  </div>`
      return html;
    }

    // 商品情報編集時(/items/:id/editページへリンクした際のアクション)
    if (window.location.href.match(/\/items\/\d+\/edit/)) {
      // 登録済み画像のプレビュー表示の要素を取得する
      var prevContent = $('.label-content').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content').css('width', labelWidth);
      // プレビューにidを追加
      $('.preview-box').each(function(index, box) {
        $(box).attr('id', `preview-box__${index}`);
      })
      // 削除ボタンにidを追加
      $('.delete-box').each(function(index, box) {
        $(box).attr('id', `delete_btn_${index}`);
      })
      var count = $('.preview-box').length;
      // プレビューが10個あったらラベルを隠す
      if (count == 10) { 
        $('.label-content').hide();
      }
    }

    // プレビューの追加
    $(document).on('change', '.hidden-field', function() {
      //hidden-fieldのidの数値のみ取得
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //labelボックスのidとforを更新
      $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
      //選択したfileのオブジェクトを取得
      var file = this.files[0];
      var reader = new FileReader();
      //readAsDataURLで指定したFileオブジェクトを読み込む
      reader.readAsDataURL(file);
      //読み込み時に発火するイベント
      reader.onload = function() {
        var image = this.result;
        //プレビューが元々なかった場合はhtmlを追加
        if ($(`#preview-box__${id}`).length == 0) {
          var count = $('.preview-box').length;
          var html = buildHTML(id);
          //ラベルの直前のプレビュー群にプレビューを追加
          var prevContent = $('.label-content').prev();
          $(prevContent).append(html);
        }
        //イメージを追加
        $(`#preview-box__${id} img`).attr('src', `${image}`);
        var count = $('.preview-box').length;
        //プレビューが10個あったらラベルを隠す
        if (count == 10) { 
          $('.label-content').hide();
        }

        // プレビュー削除したフィールドにdestroy用のチェックボックスがあった場合、チェックを外す
        if ($(`#item_images_attributes_${id}__destroy`)) {
          $(`#item_images_attributes_${id}__destroy`).prop('checked', false);
        }

        //ラベルのidとforの値を変更
        if(count < 10){
          //プレビューの数でラベルのオプションを更新する
          $('.label-box').attr({id: `label-box--${count}`,for: `item_images_attributes_${count}_image`});
        }
      }
    });

    // 画像の削除
    $(document).on('click', '.delete-box', function() {
      console.log('87')
      var count = $('.preview-box').length;
      //item_images_attributes_${id}_image から${id}に入った数字のみを抽出
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //取得したidに該当するプレビューを削除
      $(`#preview-box__${id}`).remove();

      // 新規投稿時と編集時の場合分け
      // 新規投稿時(削除用チェックボックスの有無で判定)
      if ($(`#item_images_attributes_${id}__destroy`).length == 0) {
        console.log('97')
        //フォームの中身を削除 
        $(`#item_images_attributes_${id}_image`).val("");
        //削除時のラベル操作
        var count = $('.preview-box').length;
        //10個目が消されたらラベルを表示
        if (count == 9) {
          $('.label-content').show();
        }
        if(id < 10){
          //削除された際に、空っぽになったfile_fieldをもう一度入力可能にする
          $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
        }
      } else {
        console.log('111')
        // 投稿編集時
        $(`#item_images_attributes_${id}__destroy`).prop('checked', true);
        // 10個目が消されたらラベルを表示
        if (count == 9) {
          $('.label-content').show();
        }
        if(id < 10){
          //削除された際に、空っぽになったfile_fieldをもう一度入力可能にする
          $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
        }
      }
    });
  });


  // カテゴリー選択機能
  var cat_seach = $(".category-form");

  function appendSelect(catNum) {
    if(catNum == 1) {
      var select_id = `m_category`
    } else if(catNum == 2) {
      var select_id = `s_category`
    }
    var html =
    `<select name="item[category_id]" class="item-select" id="${select_id}">
        <option value>---</option>
    </select>`
    cat_seach.append(html)
  }

  // optionを追加するHTML
  function appendCat(catOption, catNum) {
    if (catNum == 1) {
      var appendId = $("#m_category")
    } else if (catNum == 2) {
      var appendId = $("#s_category")
    }
    appendId.append(
      $("<option>")
        .val($(catOption).attr('id'))
        .text($(catOption).attr('name'))
    )
  }

  // L(親)カテゴリーが選択された時のアクション
  $("#l_category").on('change', function() {
    l_cat = $(this).val()
    $("#m_category, #s_category").remove()

    // ajaxでリクエストを送信
      $.ajax({
        type: "GET",
        url: "/items/category_more",
        data: {l_cat: l_cat},
        dataType: 'json'
      })
      // doneメソッドでappendする
      .done(function(m_cat) {
        var catNum = 1
        appendSelect(catNum)
        m_cat.forEach(function(m_cat) {
          appendCat(m_cat, catNum)
        })
      })
    })

    // M(子)カテゴリーが選択された時のアクション
  $(document).on('change', "#m_category", function() {
    m_cat = $(this).val()
    $("#s_category").remove()

    $.ajax({
      type: "GET",
      url: "/items/category_more",
      data: {m_cat: m_cat},
      dataType: 'json'
    })
    .done(function(s_cat) {
      var catNum = 2
      appendSelect(catNum)
      s_cat.forEach(function(s_cat) {
        appendCat(s_cat, catNum)
      })
    })
  })


  // 販売利益計算機能
  $('#price_calc').on('input', function(){
    var data = $('#price_calc').val();
    var profit = Math.round(data * 0.9);
    var fee = (data - profit);
    $('.commission').html(fee);
    $('.commission').prepend('¥');
    $('.profit').html(profit);
    $('.profit').prepend('¥');
    if(profit == '') {
      $('.profit').html('')
      $('.commission').html('')
    }
  });
});

