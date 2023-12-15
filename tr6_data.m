%% Dimensioni_link
a = 650; %mm
b = 600; %mm
l_max = 450; %mm 
c = 500; %mm
d = 300; %mm

% b = 660; % nuova misura per debug
%% Conversione mm --> m
a = a/1000; %m
b = b/1000; %m
l_max = l_max/1000; %m
c = c / 1000; %m
d = d / 1000; %m

L = [a,b,c,d];

%% Limiti posizone giunti
maxQ1 = 90; %deg
minQ1 = -90; %deg

maxQ2 = l_max; %m
minQ2 = 0; %m

minQ3 = -360; %deg
maxQ3 = 360; %deg

%% Limiti velocita' e accelerazione

maxQ1_dot = 2;  %rad/s
minQ1_dot = -2; %rad/s

maxQ2_dot = 0.5;  %m/s
minQ2_dot = -0.5; %m/s

maxQ3_dot = 2.5; %rad/s
minQ3_dot = -2.5; %rad/s

maxQ1_dot2 = 20;  %rad/s^2
minQ1_dot2 = -20; %rad/s^2

maxQ2_dot2 = 5;  %m/s^2
minQ2_dot2 = -5; %m/s^2

maxQ3_dot2 = 25; %rad/s^2
minQ3_dot2 = -25; %rad/s^2


%% Parametri per calcolo cinematica
n = 100;