#Description:
Macy's overlay ad execution that ran on the washingtonpost.com homepage in November 2011

#Usage:
See index.html for example implementation. This is all that needs to be added to the HTML:

    <link rel="stylesheet" href="overlay.css" type="text/css" />
    <script type="text/javascript" src="overlay.js"></script>
    <script type="text/javascript">
      var wpAd = window.wpAd || {};
      wpAd.overlay = wpAd.overlay || {};
      
      //set overlay options:
      wpAd.overlay.bg_opacity = 0.75;
      wpAd.overlay.fade_speed = 400;
      wpAd.overlay.ct = 'http://www.example.com';
    </script>

##Options:
###bg_opacity
Opacity (0-1) of the background of the overlay.

###fade_speed;
Speed of the fading in/out of the overlay in milliseconds.

###ct
The clickthru URL for the overlay.