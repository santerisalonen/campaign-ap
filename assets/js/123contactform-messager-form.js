function getURLParameter(name) {

  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [null, ''])[1].replace(/\+/g, '%20')) || null;
}
// make 123contactform post messages to parent
// push message to parent when checkbox is selected
$(document).ready(function() {
  
  var labels = getURLParameter('labels');
  labels = ( labels ) ? labels.split(',') : [];

  for(var i = 0; i < labels.length; i++) {
    // console.log(labels[i]);
    var $label = $('.label-text .label-cont:contains('+labels[i]+')');
    
    $label.closest('label').prev('input').prop('checked', true);

    
  }
  
  
  var fireEvent = function(event) {
   parent.postMessage(event, "http://kampanja.apollomatkat.fi");
   parent.postMessage(event, "https://kampanja.apollomatkat.fi");
   parent.postMessage(event, "http://localhost:1111");  
  }
	$('input[type=checkbox]').change(function() {
    
    var title = $(this).closest('.fieldcontainer').parent('.fieldcontainer').find('.class123-fieldname').text();    
    if ( $(this).is(':checked') ) {
      var event = {
        'event' : 'checkBoxCheck',
        'title' : title,
        'value' : $(this).next('label').text() 
      };
    }
    else {
      var event = {
        'event' : 'checkBoxUnCheck',
        'title' : title,
        'value' : $(this).next('label').text()
      };
    }
    fireEvent(event);
    
  });
	$('input[type=radio]').change(function() {
    var title = $(this).closest('.fieldcontainer').parent('.fieldcontainer').find('.class123-fieldname').text();    
   
    var event = {
      'event' : 'radioSelect',
      'title' : title,
      'value' : $(this).next('label').text()
    };
    fireEvent(event);

  });   
      
});