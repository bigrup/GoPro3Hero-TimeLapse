# GoPro3Hero-TimeLapse
Strip photos out from gopro to make a usable timelapse

GoPro 3 Hero has a maximum interval for timelapse of 1/minute. I wanted to show a plant growing so I needed to strip out the majority of the shots leaving 1 in 30. This takes those files, reduces the number, renames them so they make sense and can be generated into a movie.

This is a 3 phase process. It is non destructive as its still in beta.

gen_file_list.sh

This looks in the DCIM folder, and then searches for all photos in sub directories, with a full path to the files. It outputs to filelist.txt - ** There has been a problem with this not sorting the files, not sure if its something to do with multithreading. Running the embedded ls -R command does yield the results in a sorted order.

Currently you then need to sort the file - Command, sort to output file (-o xxx), sourcefile

sort -o filelist2.txt filelist.txt  

Then replace the original file.

mv filelist.txt filelist_unsorted.txt
mv filelist2.txt filelist.txt

Then you need to run runprog.sh

This creates the executable script which will move the files, there is lots of debugging information in there. It will also create a DIR in DCIM called output

Once you have the output file,

chmod 755 the file, 
./run the file

This will copy all of the selected files (1 every 30mins) to the output directory and change the name to the new file format

rupXXXXX.jpg

When its run you can move the files to you location. 

Finally you can generate a movie, This requires ffmpeg. Not included in this repo. 

Run that in the directory with the pictures and you should get a movie file.

Next step, add some music!

Enjoy!
