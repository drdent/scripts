// for console
var list=$('a[data-action], button[data-action]');
for (var i = 0; i < list.length; i++) {
  var item=list[i];
  item.style.border = '1px solid red';
  var action=item.attributes['data-action'].value;
  $(item).parent().append("<div class='special-highlight'>"+action+"</div>");
}
var l=$('.special-highlight');
for (var k = 0; k < list.length; k++) {
  l[k].style.border='1px solid red';
}

//for bookmarking
javascript:(function(){var%20list=$('a[data-action],%20button[data-action]');for(var%20i=0;i<list.length;i++){var%20item=list[i];item.style.border='1px%20solid%20red';var%20action=item.attributes['data-action'].value;$(item).parent().append("<div%20class='special-highlight'>"+action+"</div>")}var%20l=$('.special-highlight');for(var%20k=0;k<list.length;k++){l[k].style.border='1px%20solid%20red'}})();
