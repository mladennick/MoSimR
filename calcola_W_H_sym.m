%% MATRICI VELOCITA' E ACCELERAZIONI SIMBOLICHE

% Variabili simboliche
syms q1_dot q2_dot q3_dot q1_dot2 q2_dot2 q3_dot2

%% VELOCITA'

% Matrici che descrivono l'asse del moto relativo tra due link
L_01_0 = [0 -1 0 0 ;1 0 0 0;0 0 0 0;0 0 0 1];
L_12_1 = [0 0 0 1;0 0 0 0;0 0 0 0;0 0 0 1];
L_23_2 = [0 0 0 0;0 0 -1 0;0 1 0 0;0 0 0 1];

% Calcolo matrici di velocita' relativa tra un link e quello successivo
W_01_0 = L_01_0*q1_dot;
W_12_1 = L_12_1*q2_dot;
W_23_2 = L_23_2*q3_dot;

% Applicazione matrici di trasformazione M_ij per trasformare le matrici
% W rispetto al riferimento di base (0)
W_12_0 = M_01*W_12_1*inv(M_01);
W_23_0 = M_02*W_23_2*inv(M_02);

% Calcolo velocita' finale dell'end-effector:
W_03_0 = W_01_0 + W_12_0 + W_23_0;
W_02_0 = W_01_0 + W_12_0;

%% ACCELERAZIONI

% Calcolo delle matrici di accelerazioni tra un link e quello successivo
H_01_0 = L_01_0*q1_dot2 + L_01_0*L_01_0*q1_dot^2;
H_12_1 = L_12_1*q2_dot2 + L_12_1*L_12_1*q2_dot^2;
H_23_2 = L_23_2*q3_dot2 + L_23_2*L_23_2*q3_dot^2;

% Applicazione matrici di trasformazione M_ij per trasformare le matrici
% H rispetto al riferimento di base (0)
H_12_0 = M_01*H_12_1*inv(M_01);
H_23_0 = M_02*H_23_2*inv(M_02);

% Calcolo accelerazione finale
H_02_0 = H_01_0 + H_12_0 + 2*W_01_0*W_12_0;
H_03_0 = H_02_0 + H_23_0 + 2*W_02_0*W_23_0;