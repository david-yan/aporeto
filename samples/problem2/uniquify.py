#!/usr/bin/env python
import sys
import os.path

def printUsage():
	print("Usage:")
	print("  uniquify [--help|-h]")
	print("  uniquify --file=<filename> --output=<output-filename> [-verbose]")

#parse through arguments
if len(sys.argv) == 1:
	print(1)
	printUsage()
	sys.exit()

if sys.argv[1] == "-h" or sys.argv[1] == "--help":
	if len(sys.argv) != 2:
		print("ERROR: Invalid arguments")
	printUsage()
	sys.exit()

if not (sys.argv[1].startswith("--file=") and sys.argv[2].startswith("--output=")):
	print("ERROR: Invalid arguments")
	printUsage()
	sys.exit(1)
if len(sys.argv) > 4 or (len(sys.argv) == 4 and sys.argv[3] != "-verbose"):
	print("ERROR: Invalid arguments")
	printUsage()
	sys.exit(1)

inputFilename = sys.argv[1].split('=', 1)[1]
outputFilename = sys.argv[2].split('=', 1)[1]
verbose = False
if len(sys.argv) == 4:
	verbose = True

if not os.path.isfile(inputFilename):
	print("ERROR: File does not exist")
	printUsage()
	sys.exit(1)
inFile = open(inputFilename, "r")
if verbose:
	print("Processing input file")
	if os.path.isfile(outputFilename):
		print("Overwriting output file")
outFile = open(outputFilename, "w")

lines = []
for line in inFile:
	if not line in lines:
		lines.append(line)
		outFile.write(line)
inFile.close()
outFile.close()
if verbose:
	print("Done")


