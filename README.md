# aporeto_homework

## Bash Shell Script sample:
* Runs as described in problem
* Nothing too special to note

## Python sample:
* Run by including python in front, i.e. `python uniquify.py ...`
* Uses basic assumption that the list of unique lines in file can all fit in memory
  * Alternative solution if above assumption fails would be to partition the file and create a file for each partition, then to merge all files together. This would take a few runs to complete. 
* Also uses basic assumption that python has a very fast lookup time for items in its lists
  * Possible optimization would be to store the lines in a HashSet instead of a list

## Go sample:
* `go get` probably does not work because first time using Go
  * Executable file comes precompiled in bin
* Relies on goquery external package
* Also uses basic assumption that word count mapping can fit in memory for each url
* Not parallelized solution
