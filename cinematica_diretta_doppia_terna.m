%% Cinematica diretta tramite metodo doppia terna
% Dichiarazione variabili simboliche
syms alfa beta l a b c d;

% Dichiarazione matrici
M_b0 = [0 1 0 0; 0 0 1 0; 1 0 0 a; 0 0 0 1];
Q_1 = [cos(alfa) -sin(alfa) 0 0; sin(alfa) cos(alfa) 0 0; 0 0 1 0; 0 0 0 1];
A_1 = [0 0 1 b; 1 0 0 0; 0 1 0 0; 0 0 0 1];
Q_2 = [1 0 0 0; 0 1 0 0; 0 0 1 l; 0 0 0 1];
A_2 = [1 0 0 0; 0 1 0 0; 0 0 1 c; 0 0 0 1];
Q_3 = [cos(beta) -sin(beta) 0 0; sin(beta) cos(beta) 0 0; 0 0 1 0; 0 0 0 1];
A_3 = [0 0 1 d; 1 0 0 0; 0 1 0 0; 0 0 0 1];


M_bp = M_b0*Q_1*A_1*Q_2*A_2*Q_3*A_3;

