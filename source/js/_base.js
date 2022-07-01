// Base

//
// Auto-gen right subnav items from headers
// ------------------------------

function createRightHandNav(){
  var $result = $('<div/>');
  var curDepth = 0;

  $('h2,h3').addClass('heading');
  $('.heading').each(function() {

      var $li_text = $("<a href='#" + this.id + "'>" + $(this).text() + "</a>");
      var $li = $('<li/>').append($li_text);

      var depth = parseInt(this.tagName.substring(1));

      if(depth > curDepth) { // going deeper
          $result.append($('<ul class="nav sub-nav"/>').append($li));
          $result = $li;

      } else if (depth < curDepth) { // going shallower
          $result.parents('ul:last').append($li);
          $result = $li;

      } else { // same level
          $result.parent().append($li);
          $result = $li;
      }

      curDepth = depth;

  });

  $result = $result.parents('ul:last');

  // clean up
  $('h2,h3').removeClass('heading');

  if( !(typeof $result[0] === "undefined") ) {
    $('#subnav-right')[0].innerHTML = $result[0].outerHTML;
  }
}