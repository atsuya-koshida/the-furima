$(function(){
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
