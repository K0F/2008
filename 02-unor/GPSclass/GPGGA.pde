/*$GPGGA

Global Positioning System Fix Data

Name 	Example Data 	Description
Sentence Identifier 	$GPGGA 	Global Positioning System Fix Data
Time 	170834 	17:08:34 Z
Latitude 	4124.8963, N 	41d 24.8963' N or 41d 24' 54" N
Longitude 	08151.6838, W 	81d 51.6838' W or 81d 51' 41" W
Fix Quality:
- 0 = Invalid
- 1 = GPS fix
- 2 = DGPS fix 	1 	Data is from a GPS fix
Number of Satellites 	05 	5 Satellites are in view
Horizontal Dilution of Precision (HDOP) 	1.5 	Relative accuracy of horizontal position
Altitude 	280.2, M 	280.2 meters above mean sea level
Height of geoid above WGS84 ellipsoid 	-34.0, M 	-34.0 meters
Time since last DGPS update 	blank 	No last update
DGPS reference station id 	blank 	No station id
Checksum 	*75 	Used by program to check for transmission errors

Courtesy of Brian McClure, N8PQI.

Global Positioning System Fix Data. Time, position and fix related data for a GPS receiver.

eg2. $--GGA,hhmmss.ss,llll.ll,a,yyyyy.yy,a,x,xx,x.x,x.x,M,x.x,M,x.x,xxxx

hhmmss.ss = UTC of position
llll.ll = latitude of position
a = N or S
yyyyy.yy = Longitude of position
a = E or W
x = GPS Quality indicator (0=no fix, 1=GPS fix, 2=Dif. GPS fix)
xx = number of satellites in use
x.x = horizontal dilution of precision
x.x = Antenna altitude above mean-sea-level
M = units of antenna altitude, meters
x.x = Geoidal separation
M = units of geoidal separation, meters
x.x = Age of Differential GPS data (seconds)
xxxx = Differential reference station ID

eg3. $GPGGA,hhmmss.ss,llll.ll,a,yyyyy.yy,a,x,xx,x.x,x.x,M,x.x,M,x.x,xxxx*hh
1    = UTC of Position
2    = Latitude
3    = N or S
4    = Longitude
5    = E or W
6    = GPS quality indicator (0=invalid; 1=GPS fix; 2=Diff. GPS fix)
7    = Number of satellites in use [not those in view]
8    = Horizontal dilution of position
9    = Antenna altitude above/below mean sea level (geoid)
10   = Meters  (Antenna height unit)
11   = Geoidal separation (Diff. between WGS-84 earth ellipsoid and
       mean sea level.  -=geoid is below WGS-84 ellipsoid)
12   = Meters  (Units of geoidal separation)
13   = Age in seconds since last update from diff. reference station
14   = Diff. reference station ID#
15   = Checksum
*/
