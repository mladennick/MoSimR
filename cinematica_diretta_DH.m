%% Cinematica diretta mediante DH 
% Dichiarazione variabili simboliche
syms alfa beta l a b c d;

% Dichiarazione matrici
M_b0 = [1 0 0 0; 0 0 1 0; 0 -1 0 a; 0 0 0 1];
M_01 = [cos(alfa) -sin(alfa)*0 sin(alfa)*1 b*cos(alfa); sin(alfa) cos(alfa)*0 -cos(alfa)*1 b*sin(alfa);0 1 0 0;0 0 0 1];
M_12 = [1 0 0 0; 0 1 0 0; 0 0 1 l; 0 0 0 1];
M_23 = [cos(beta) -sin(beta) sin(beta)*0 0; sin(beta) cos(beta) -cos(beta)*0 0; 0 0 1 c; 0 0 0 1];
M_3p = [0 0 1 d; 1 0 0 0; 0 1 0 0; 0 0 0 1];


M_bp_DH = M_b0*M_01*M_12*M_23*M_3p; 