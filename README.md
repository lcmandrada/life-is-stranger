# Life Is Stranger

**Legacy Project**

A basic interactive story written for x86 TASM with the following instructions:
- find traces and conversations to find Luna
- arrow keys to drive the character
- left click to interact with traces
- enter to interact with conversations
- escape to go back

# Build
It was built using TASM in DOSBox, thus it must be built and run within DOSBox.
```
tasm /m2 life
tlink life
```

It can be played by executing
```
life
```

# Note
A batch file was written that attached a song to the executable file.
Since it uses a portable DOSBox and VLC player, the total size of that repository is relatively huge and was not uploaded here.
For whatever it's worth, the song is Golden Hour by Jonathan Morali.

Also, TASM is included in this repository but DOSBox isn't.  
DOSBox is an x86 emulator and can be downloaded from [here](https://www.dosbox.com/download.php?main=1).