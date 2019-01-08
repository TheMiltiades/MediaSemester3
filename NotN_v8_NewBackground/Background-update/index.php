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
<canvas id="canvas"></canvas>

<!-- constallation control panel 
<div id="ctrl_menu">
    <div id="ctrl_toggle">Toggle Controls</div>
    <div class="ctrl_row">
        <div class="ctrl_label">Particle Count</div>
        <input class="ctrl" id="num_particles" type="range" min="1" max="300" value="300">
    </div>
    <div class="ctrl_row">
        <div class="ctrl_label">Connection Distance</div>
        <input class="ctrl" id="distance" type="range" min="1" max="300" value="100">
    </div>
    <div class="ctrl_row">
        <div class="ctrl_label">Particle Radius</div>
        <input class="ctrl" id="radius" type="range" min="0" max="10" value="2">
    </div>
    <div class="ctrl_row">
        <div class="ctrl_label">Line Width</div>
        <input class="ctrl" id="lineWidth" type="range" min="1" max="500" value="100">
    </div>
    <div class="ctrl_row">
        <button class="jscolor {valueElement:'particleColor'}">Particle Color</button>
        <input id="particleColor" value="3434ff">
    </div>
    <div class="ctrl_row">
        <button class="jscolor {valueElement:'lineColor'}">Connection Color</button>
        <input id="lineColor" value="3434ff">
    </div>
    <div class="ctrl_row">
        <button class="jscolor {valueElement:'backgroundColor'}">Background Color</button>
        <input id="backgroundColor" value="111111">
    </div>
</div>
-->

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
                        $title = str_replace("_", " ", $title);
                        $title = str_replace("-", "</p><p>", $title);
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
			infinite: true,
			centerMode: true,
			slidesToShow: 3,
			slidesToScroll: 3
		  });
		});
	</script>
	<script src="./customJS/main.js" type="text/javascript" charset="utf-8"></script>
	<script src="./customJS/constallation.js" type="text/javascript" charset="utf-8"></script>

</body>
</html>
