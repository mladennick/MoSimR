function [x,y,z] = cinematica_diretta(q1,q2,q3,L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funzione per il calcolo della cinematica diretta tramite approccio
% geometrico
% [x,y,z] = cinematica_diretta(q1,q2,q3,L)
%
% Input : 
%       q1,q2,q3 (double): valori coordinate giunti
%       L (array,double): vettore contenente la descrizione geometrica
%       del robot
% Return : 
%       x,y,z (double): posizione gripper nello spazio di lavoro
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Set up soglia limite per valori di sin e cos
    threshold = 10^-16;
    
    
    % Scorporamento parametri vettore L
    a = L(1);
    b = L(2);
    c = L(3);
    d = L(4);
    
    % Calcolo cinematica diretta    
    x = a+(b+q2+c)*cos(q1)-d*cos(q3)*sin(q1);
    y = (b+q2+c)*sin(q1)+d*cos(q3)*cos(q1);
    z = d*sin(q3);
    
    
    % Verifica valori sin e cos settati nulli se sotto una certa soglia per
    % evitare problemi con errori macchina
    if(abs(x) < threshold)
        x = 0;
    end
    if(abs(y) < threshold)
        y = 0;
    end
    if(abs(z) < threshold)
        z = 0;
    end
end