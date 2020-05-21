----------------------------------------------------------------------------------------------
README.txt

VISUALIZING THE COVID-19 PANDEMIC 
----------------------------------------------------------------------------------------------

Author: Sharon Kuo
05.08.2020

----------------------------------------------------------------------------------------------
SUMMARY

This intent of this project was to collect real-time data on the COVID-19 pandemic and perform
data visualization to further understand trends and curves. A secondary objective was also to
explore the range of visual outputs that MATLAB offers, and exhibit its app designer and GUI 
capabilities, including recent developments in the software to tackle UI design.

**** Demo: https://youtu.be/jhABilI-3pI ****

----------------------------------------------------------------------------------------------
FEATURES

The app consists of a main menu and an interactive dashboard with four tabs, each presenting
various data in various forms. These include:

1) An interactive worldwide map (geobubble plot) with ability to scroll, zoom, and pan, change 
basemaps, toggle between color options, save map, and switch to data from past

2) Real-time statistics including confirmed cases, active cases, deaths, recovery. Can view
for any previous date in the pandemic

3) Graphical overlay plot of individual country data with a slider to go back in time and view 
past plots. Date and number of countries displayed can be selected; plot can be saved. 
Hovering/clicking on lines prompt data tips displaying more specific data

4) Timelapse animation of how the pandemic unfold from Day 1 (Jan 22, 2020) to current date.
It is a running bar chart with adjustable number of countries and ability to save final figure.


----------------------------------------------------------------------------------------------
OTHER DEMONSTRATED CAPABILITIES

- retrieving real-time data from the web
- processing and organizing large sets of data
- use of MATLAB appdesigner and callback functions
- attempt at UI design in MATLAB (use of icons, coloring, font variation)
- pop-ups, tooltips, dropdown menus, switches, sliders, buttons


----------------------------------------------------------------------------------------------
**** INSTRUCTIONS ****

To start program, either doubleclick "menu.mlapp" or run "start.m", which will bring you to
the menu app. From there on, everything should be quite intuitive.

Note that it may take a minute or two to download the data from the repository for the first 
time. The data will be stored in a "data" folder in whichever folder the app files are in. The 
main app will then open and the tabs on top navitage to different pages. 

To return to the main menu, simply navigate to the last tab and click "return to main menu" 
button.


----------------------------------------------------------------------------------------------
INCLUDED FILES

barChartAnimation.m - function called on to perform timelapse animation
loadData.m - function that loads and processes downloaded data from "data" folder
main.mlapp - main app that houses all data visualizations
menu.mlapp - menu start app
plotCountry.m - function called on to graph individual country data
plotMap.m - function that plots the geobubble map

return.png - return to menu icon
COVIDimage.jpg - image on menu
play.png - press play icon for animation

'examples' folder - includes examples of extracted graphics
'data' folder - downloaded database from 05/10/2020. This data can be replaced though menu app


