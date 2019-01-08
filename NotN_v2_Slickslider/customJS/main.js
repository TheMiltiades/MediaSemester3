	

	//start with and keep focus on button	
		
		//start with
	$(document).on('ready', function() {
		$(".slick-next").focus();
	});
	
		//keep on
	function refocus() {
		$(".slick-next").focus();
	};
	
		//making it work with fullscreen focus loss
	function enterFullscreen(paramElem) {

		var element = paramElem;

		var requestMethod = element.requestFullscreen ||
			 element.webkitRequestFullscreen ||
			 element.webkitRequestFullScreen ||
			 element.mozRequestFullScreen ||
			 element.msRequestFullscreen;

		 if( requestMethod ) {
			 requestMethod.apply( element );
		 }

		 document.addEventListener('webkitfullscreenchange', regainFocusOnExitFullScreen, false);
		 document.addEventListener('mozfullscreenchange', regainFocusOnExitFullScreen, false);
		 document.addEventListener('fullscreenchange', regainFocusOnExitFullScreen, false);
		 document.addEventListener('MSFullscreenChange', regainFocusOnExitFullScreen, false);
		
	}

	function regainFocusOnExitFullScreen(textabc){
		if(!(document.webkitIsFullScreen || document.mozFullScreen || document.msFullscreenElement)){
			 document.querySelector('.slick-next').focus();
			 document.removeEventListener('webkitfullscreenchange', regainFocusOnExitFullScreen, false);
			 document.removeEventListener('mozfullscreenchange', regainFocusOnExitFullScreen, false);
			 document.removeEventListener('fullscreenchange', regainFocusOnExitFullScreen, false);
			 document.removeEventListener('MSFullscreenChange', regainFocusOnExitFullScreen, false);
		}
	}
	
	// w (start) and s (stop) keys
	function exitFullscreen(video){
		
		if (video.ExitFullScreen) {
			  video.ExitFullScreen();
			} else if (video.msExitFullScreen) {
			  video.msExitFullScreen();
			} else if (video.mozExitFullScreen) {
			  video.mozExitFullScreen();
			} else if (video.webkitExitFullScreen) {
			  video.webkitExitFullScreen();
			}
		
	}
	
	
	document.addEventListener('keydown', function(event) {
		
		//w
		if(event.keyCode == 87){
			var vp = document.getElementsByClassName("slick-current");
			var vp1 = vp[0].childNodes[0].childNodes[0].childNodes[1];
			
			vp1.play();
			
			enterFullscreen(vp1);
			
		}
		
		//s
		if(event.keyCode == 83){
			var vp = document.getElementsByClassName("slick-current");
			var vp2 = vp[0].childNodes[0].childNodes[0].childNodes[1];
			
			vp2.pause();
			
			exitFullscreen(vp2);
			
			refocus();
		}
	});

	// close video after ending
	var videos = document.getElementsByTagName("video");
	
	for (i = 0; i < videos.length; i++){
		videos[i].addEventListener("ended", myHandler, false);
	}
	
	function myHandler() {
		
		exitFullscreen(this);
		
		refocus();
	}
	