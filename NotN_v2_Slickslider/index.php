<!DOCTYPE html>
<html>
<head>
  <title>video selector</title>
  <meta charset="UTF-8">
  <link rel="stylesheet" type="text/css" href="./slick/slick.css">
  <link rel="stylesheet" type="text/css" href="./slick/slick-theme.css">
  <link rel="stylesheet" type="text/css" href="./customCSS/styles.css">
</head>
<body>

  <section class="center slider">
    <div>
      <video controls>
		<source src="videos/2D_Animated_Short_Film_PASSENGER.mp4" type="video/mp4">
	  Your browser does not support the video tag.
	  </video>
	  <p>Video1 _ Persoon1</p>
    </div>
    <div>
      <video controls>
    <source src="videos/3D_Animated_Short_BLIK.mp4" type="video/mp4">
  Your browser does not support the video tag.
  </video>
	  <p>Video2 _ Persoon2</p>
    </div>
    <div>
      <video controls>
		<source src="videos/Beeld_Tijd_En_Ruimte_1.mp4" type="video/mp4">
	  Your browser does not support the video tag.
	  </video>
	  <p>Video3 _ Persoon4</p>
    </div>
    <div>
      <video controls>
		<source src="videos/Daddy_Day_3D_Animation.mp4" type="video/mp4">
	  Your browser does not support the video tag.
	  </video>
	  <p>Video4 _ Persoon4</p>
    </div>
    <div>
      <video controls>
		<source src="videos/Doorgeefanimatie_Eindexamenwerk.mp4" type="video/mp4">
	  Your browser does not support the video tag.
	  </video>
	  <p>Video5 _ Persoon5</p>
    </div>
    <div>
      <video controls>
		<source src="videos/Eerstejaars_Animatie.mp4" type="video/mp4">
	  Your browser does not support the video tag.
	  </video>
	  <p>Video6 _ Persoon6</p>
    </div>
    <div>
      <video controls>
		<source src="videos/Good_Times_Toelating_HKU.mp4" type="video/mp4">
	  Your browser does not support the video tag.
	  </video>
	  <p>Video7 _ Persoon7</p>
    </div>
    <div>
      <video controls>
		<source src="videos/SHEEPED_AWAY_2D_Animation.mp4" type="video/mp4">
	  Your browser does not support the video tag.
	  </video>
	  <p>Video8 _ Persoon8</p>
    </div>
  </section>


  <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
  <script src="./slick/slick.js" type="text/javascript" charset="utf-8"></script>
  <script type="text/javascript">
		//slick slider 	
		$(document).on('ready', function() {
		  $(".center").slick({
			arrows: true,
			draggable: true,
			infinite: true,
			centerMode: true,
			slidesToShow: 3,
			slidesToScroll: 3
		  });
		});
	</script>
	<script src="./customJS/main.js" type="text/javascript" charset="utf-8"></script>

</body>
</html>
