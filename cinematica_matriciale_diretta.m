%% Cinematica diretta con metodo matriciale
% Dichiarazione variabili simboliche
syms q1 q2 q3 a b c d q1_dot q2_dot q3_dot q1_dot2 q2_dot2 q3_dot2 real;

% Matrici di posizione
M_01 = [1 0 0 a; 0 1 0 0; 0 0 1 0; 0 0 0 1];
M_12 = [cos(q1) -sin(q1) 0 b*cos(q1); sin(q1) cos(q1) 0 b*sin(q1);0 0 1 0;0 0 0 1]; 
M_23 = [1 0 0 c+q2;0 1 0 0;0 0 1 0;0 0 0 1]; 
M_34 = [1 0 0 0;0 cos(q3) -sin(q3) d*cos(q3);0 sin(q3) cos(q3) d*sin(q3);0 0 0 1];

M_02 = M_01*M_12;
M_03 = M_01*M_12*M_23;
M_04 = M_01*M_12*M_23*M_34;

% Matrici L
L_12_1 = [0 -1 0 0 ;1 0 0 0;0 0 0 0;0 0 0 0]; % rotZ
L_23_2 = [0 0 0 1;0 0 0 0;0 0 0 0;0 0 0 0];   % trasX
L_34_3 = [0 0 0 0;0 0 -1 0;0 1 0 0;0 0 0 0];  % rotX

% Matrici di velocita'
W_01_0 = zeros(4);
        
W_12_1 = L_12_1*q1_dot;
W_12_0 = M_01*W_12_1*inv(M_01);
W_02_0 = W_01_0+W_12_0;

W_23_2 = L_23_2*q2_dot; 
W_23_0 = M_02*W_23_2*inv(M_02);
W_03_0 = W_01_0+W_12_0+W_23_0; 

W_34_3 = L_34_3*q3_dot;
W_34_0 = M_03*W_34_3*inv(M_03);

W_04_0 = W_01_0+W_12_0+W_23_0+W_34_0;

% Matrici di accelerazione
H_12_1 = (L_12_1^2)*(q1_dot^2)+L_12_1*q1_dot2;
H_23_2 = (L_23_2^2)*(q2_dot^2)+L_23_2*q2_dot2;
H_34_3 = (L_34_3^2)*(q3_dot^2)+L_34_3*q3_dot2;

H_12_0 = M_01*H_12_1*inv(M_01);
H_23_0 = M_02*H_23_2*inv(M_02);
H_34_0 = M_03*H_34_3*inv(M_03);

H_01_0 = zeros(4);
H_02_0 = H_01_0+H_12_0+2*W_01_0*W_12_0;
H_03_0 = H_02_0+H_23_0+2*W_02_0*W_23_0;

H_04_0 = H_03_0+H_34_0+2*W_03_0*W_34_0;

    


