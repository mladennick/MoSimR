function [x,xp,xpp] = cicloidale(t,T,S0,dS)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione per la legge di moto cicloidale
    % [x,xp,xpp] = cicloidale(t,T,S0,dS)
    %
    % Input:
    %       t (float): tempo per cui calcolare la legge   
    %       T (float): tempo di azionamento
    %       S0 (float): posizione iniziale
    %       dS (float): ampiezza movimento (S_finale-S_iniziale)
    % Return :
    %       [x,xp,xpp] (array,float): posizione, velocita', accelerazione
    %       ldm cicloidale
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Si assume Vini = Vfin = 0

A = dS*2*pi/T^2;

xpp = A*sin((2*pi/T)*t);
xp = -A*(T/(2*pi))*cos((2*pi/T)*t)+A*T/(2*pi);
x = -A*(T/(2*pi))^2*sin((2*pi/T)*t)+A*(T/(2*pi))*t+S0;

end

