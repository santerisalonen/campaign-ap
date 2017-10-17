// push message to parent from thank you page
$(document).ready(function() {
	var event = {
		'event' : 'subscribe'
	};
  parent.postMessage(event, "http://kampanja.apollomatkat.fi");
  parent.postMessage(event, "https://kampanja.apollomatkat.fi");
 // parent.postMessage(event, "http://localhost:1111");
});