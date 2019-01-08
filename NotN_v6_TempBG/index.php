<!DOCTYPE html>
<html>
<head>
    <title>Video Showcase for events - by Designerds</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="./slick/slick.css">
    <link rel="stylesheet" type="text/css" href="./slick/slick-theme.css">
    <link rel="stylesheet" type="text/css" href="./customCSS/styles.css">
    <link rel="icon" href="images/DesignerdsIcon.ico">
</head>
<body>
    <div class="background-image"></div>
    <section class="center slider">
      <?php 
            // Haal de video's op uit de map en maak voor iedere video een aparte div aan. Hierin wordt de video getoond en de subtext wordt uit de bestandsnaam gelezen.
            $files = glob('videos/*.{mp4}', GLOB_BRACE);
            foreach($files as $file):?>
            <div>
                <video>
		        <source src="<?php echo $file ?>" type="video/mp4">
	               Your browser does not support the video tag.
	            </video>
	            <p>
                    <?php 
                        $title = str_replace("videos/","", $file);
                        $title = str_replace(".mp4", "", $title);
                        $title = str_replace("_", "</p><p>", $title);
                        echo $title;
                    ?>
                </p>
            </div>
        <?php endforeach; ?>
  </section>


  <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
  <script src="./slick/slick.js" type="text/javascript" charset="utf-8"></script>
  <script type="text/javascript">
		// Slick slider 	
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
