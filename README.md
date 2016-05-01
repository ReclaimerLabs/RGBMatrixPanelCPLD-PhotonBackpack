Copyright (c) 2016 Jason Cerundolo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

RGB Matrix Panel CPLD Photon Backpack
==================

An interface board between a Particle Photon and an RGB Matrix Panel. 
A CPLD provides the interface between the two and handles protocol 
conversion. 

Pick up an RGB LED panel from Adafruit. 
https://www.adafruit.com/products/2026

Pick up a CPLD backpack from Reclaimer Labs. 
http://reclaimerlabs.com

Use with the matching Particle library. 
https://github.com/ReclaimerLabs/RGBmatrixpanelCPLD

This board allows the use of hardware timers and DMA to achieve low 
overhead transfers of information to the matrix panels. The CPLD on the 
backpack converts SPI data into the parallel format expected by 
the matrix panel. The only ongoing computation needed from the CPU 
is to set up the next DMA transfer and compute the time to display 
the next row of bit data. This take the CPU time needed from ~40% 
to <1% for two 32x32 panels. The limited factor is now RAM and 
transfer speed. 
