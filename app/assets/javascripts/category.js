$(document).on('turbolinks:load', function() {

  // selectを追加するHTML
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
})
