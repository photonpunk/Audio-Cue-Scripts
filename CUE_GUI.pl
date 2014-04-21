##  Copyright (c) 2013, The University of Alabama Libraries.
##  Contributed by {Austin Dixon}  {5/20/2013}.
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


# GUI for CueMaker and CueSplitter script


#! usr/local/bin/perl
use Tkx;
use LWP::Simple;


# SETUP
    											
# frame objects
my $fa;
my $fb;
# button objects
my $ba;
my $bb;
my $bc;
my $bd;

$choice = 1; # default selection

#-------------------------------------------------
# make files sub routine

sub runFileConverter {

	if ($choice == 1){
		system("python CueMaker.py");
		sleep(4);
		system("perl CueSplitter.pl");
	}
	
	elsif ($choice == 2){
		system("python CueMaker.py");
	}
	
	elsif ($choice == 3){
		system("perl CueSplitter.pl");
	}

}

#-------------------------------------------------
# GUI elements

# main window
my $mw = Tkx::widget->new(".");
$mw->g_wm_title("Cue GUI");
$mw->g_wm_minsize(270, 50);

# frame a
$fa = $mw->new_frame(
-relief => 'solid',
-borderwidth => 1,
-background => 'light gray',
);
$fa->g_pack( -side => 'bottom', -fill => 'both' );

#---------------------------------------------------
# make button

$ba = $fa->new_button(
-text => 'RUN',
-font => 'bold',
-command => \&runFileConverter,
-height => 2,
-width => 15,
);
$ba->g_pack( -side => 'top', -pady => 10 );

#------------------------------------------------
# frame b (choose to run CueSplitter)

$fb = $mw->new_frame(
-relief => 'solid',
-borderwidth => 1,
-background => 'light gray',
);
$fb->g_pack( -side => 'top', -fill => 'both' );

$bb = $fb->new_radiobutton(
-bg => 'light gray',
-text => "Run CueMaker and CueSplitter", 
-font => 'bold',
-variable => \$choice, 
-value => 1,	
);
$bb->g_pack( -anchor => w, -side => 'top', -pady => 4 );

$bc = $fb->new_radiobutton(
-bg => 'light gray',
-text => "Run CueMaker only",
-font => 'bold',
-variable => \$choice, 
-value => 2,	
);
$bc->g_pack(  -anchor => w, -side => 'top', -pady => 4);

$bd = $fb->new_radiobutton(
-bg => 'light gray',
-text => "Run CueSplitter only",
-font => 'bold',
-variable => \$choice, 
-value => 3,	
);
$bd->g_pack(  -anchor => w, -side => 'top', -pady => 4 );

#------------------------------------------------

Tkx::MainLoop();
