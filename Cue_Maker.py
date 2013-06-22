##  Copyright (c) 2013, The University of Alabama Libraries.
##  Contributed by {Austin Dixon}  {4/29/13}.
##  All rights reserved.
 
##  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
##    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
##    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the
##       distribution.
##    * Neither the name of The University of Alabama Libraries nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
##THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
##THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
##CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
##PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
##LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
##EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


#
# creates cue files to be used by audio splitting software
#
# only works for .wav files, but can easily be edited to work for other filetypes
# file.cue file must already be created in same folder as script
# time code must be entered in mm:ss format (ex. 01:23 would be 1 minute and 23 seconds)
# first time code must be 00:00
# if a gap is needed between tracks, change INDEX 01 to INDEX 00
 
def main():
  fileName = getFile()
	trackTitle, trackTime = timecode(fileName)
	makeCue(fileName, trackTitle, trackTime)
	
def getFile():
 
	f = open("cue.txt","r")
	fileName = f.readlines()
	f.close()
	
	return fileName
 
def timecode(fileName):
	trackTime = []
	trackTitle = []
	num = 1
 
	
	while (num < len(fileName)):
		
		s = fileName[num].split(' ')
		
		time = s[1]
		title = s[0]
		
		trackTime.append(time)
		trackTitle.append(title)
		num = num + 1
			
	return trackTitle, trackTime
	
def makeCue(fileName, trackTitle, trackTime):
	t = 1 
	num = 0
	q = '"'
	header = 'FILE ' + q + fileName[0].rstrip() + q + ' WAVE'
	
	file = open("file.cue","w")
	file.write(header)
	file.write('\n\n')
	
	while (num < len(trackTime)):
		if (t < 10):
			trackName = "TITLE " + q + trackTitle[num] + q
			ts = "0" + str(t)
			track = "TRACK " + ts + " AUDIO"
			index = "INDEX 01 " + trackTime[num].rstrip()
			
			
			
			file.write(track)
			file.write('\n')
			file.write(index)
			file.write('\n')
			file.write(trackName)
			file.write('\n\n')
			
			t = t + 1
			num = num + 1
		
		else:
			trackName = "TITLE " + q + trackTitle[num] + q
			track = "TRACK " + str(t) + " AUDIO"
			index = "INDEX 01 " + trackTime[num].rstrip()
			
			file.write(track)
			file.write('\n')
			file.write(index)
			file.write('\n')
			file.write(trackName)
			file.write('\n\n')
			
			t = t + 1
			num = num + 1
	
	file.close()
 
	
main()
