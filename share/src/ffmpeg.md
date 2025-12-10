%title FFMPEG

Add audio to video

    ffmpeg -i input.mp4 -i input.mp3 -c copy -map 0:v:0 -map 1:a:0 output.mp4

Convert video to another format

    ffmpeg -i movie.mov -vcodec copy -acodec copy out.mp4
