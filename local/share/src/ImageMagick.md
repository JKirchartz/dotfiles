%title Image Magick Tricks


1. combine 2 images (overlaid) this will combine 2 images, centered, and preserving alpha:

  composite -gravity center -alpha set top.png bottom.png output.png

2. get color data from image

  convert img.png -unique-colors -depth 8 txt:-
