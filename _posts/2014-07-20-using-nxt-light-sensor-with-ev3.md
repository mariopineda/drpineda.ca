---
layout: post  
title: Hacking EV3 software to use NXT light sensor
description: Got NXT sensors but running EV3 software? Here is a workaround allowing the EV3 sound sensor block to use the NXT light sensor block for the all so important black and white discrimination for line-following and sumo wrestling robots.  
modified: 2014-07-20
category: Mindstorms
tags:
- Mindstorms
- LEGO
featureimage: feature-mindstorms2.jpg
thumbnailimage: thumbnail-mindstorms2.jpg
comments: true 
permalink: using-nxt-light-sensor-in-ev3.html
--- 
<p>While most of the new <a href="http://www.lego.com/en-us/mindstorms/?domainredir=mindstorms.lego.com">Mindstorms EV3</a> software is backwards compatible with the <a href="http://en.wikipedia.org/wiki/Lego_Mindstorms_NXT">NXT hardware</a>, i.e. NXT can be programmed using EV3 software, there are some notable and somewhat annoying exceptions. Over the last few weeks I have been wrestling with one particularly pesky such incompatibility, namely using NXT light sensors with EV3 software. I suspect this problem might be rather common as the NXT is phased out by the EV3, particularly among FLL teams and in schools that have a mixed set up of Mindstorms bricks.</p>

<p>The root of the problem is that the NXT's light sensor has been replaced by a colour sensor in EV3 which has quite different capabilities. As a result the EV3 color sensor block, which intuitively may appear as the right program structure for controlling the NXT light sensor, cannot properly control the NXT light sensor hardware. While there has been various attempts to provide a solutions to this limitation (e.g. <a href="http://forums.usfirst.org/showthread.php?20685-Older-light-sensors-on-new-EV3">here</a>) the only workaround that has worked reliably for me is using the EV3 sound sensor block as an interface to the NXT light sensor hardware.</p>

<p>It sounds crazy to use the sound sensor block for the light sensor, but the the sound sensor block will turn on and off the NXT light sensor LED so you can measure both reflected light (dB mode with lamp on) and ambient light (dBa mode with lamp off). However, the measured range is scaled to about 17 (dark) to 70 (bright) instead of 0 - 100, so adjust your calibration and light thresholds accordingly!</p>

<p>The gist of the procedure consist of a calibration step where the light sensor is calibrated pointing at white and black surfaces. These calibration values are saved to a file and are then used by the bespoke light sensor code to evaluate the colour it is pointing at. While this workaround has shown to be reliable its main drawback is that there is a delay in the processing of the sound sensor data, so for example to use in in line following and edge detection algorithm requires the robot to move slowly or the sensor will not pick up the colour change.</p>

<p>The code is available below. To add it to the EV3 software just follow the following steps:
<ol>
<li>Download the <a href="/projects/mindstorms/LightSensorBlock.ev3s">LightSensorBlock.ev3s</a> file.</li>
<li>Click on the "EV3 Blocks" tab and select the sensor blocks you want to download.</li>
<li>In the EV3 Software, use the Tools->Import Block menu item to import the new sensor Block.</li>
</ol>
</p>
