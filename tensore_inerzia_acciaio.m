%% CALCOLO DEL TENSORE D'INERZIA DI OGNI LINK

%% Dati

% Masse: m_i = massa del link i-esimo
m_a = 40015.53; % [g]
m_a = m_a*10^-3; % [kg]
m_b = 21553.72;  % [g]  
% m_b = 11553.72;
m_b = m_b*10^-3; % [kg]
m_c = 18435.20; % [g] 
% m_c = 15435.20;
m_c = m_c*10^-3; % [kg]
m_d = 4142.63;  % [g]
% m_d = 4142.63-1;  % [g]
m_d = m_d*10^-3; % [kg]

% Massa ultimo link + pezzo modellizzato come massa puntiforme nel punto di
% presa
m_dp = 5142.63; % [g]
m_dp = m_dp*10^-3; % [kg]

% Per il link i:
%   G_i: centro di massa del link calcolato rispetto il giunto verso base
%   J_i: matrice d'inerzia rispetto al baricentro
%   B_i: coordinate dell'origine del riferimento collocato nel giunto verso
%   il gripper rispetto al riferimento collocato nel giunto verso base

% Link base (a)
G_a = [370.65 0 0]; % [mm]
G_a = G_a*10^-3; % [m]
J_a = [302565138.95,0.00,0.00;...
       0.00,2146586401.66,482.71;...
       0.00,482.71,2142856816.02]; % [g*mm^2]
J_a = J_a*10^-9; % [kg*m^2]
B_a = [668.74 0 0]; % [mm]
B_a = B_a*10^-3; % [m]

% Link 1 (b)
G_b = [109.56 -0.62 0]; % [mm]
G_b = G_b*10^-3; % [m]
J_b = [114580504.31,1580110.53,0.00;...
       1580110.53,629242562.89,-3.35;
       0.00, -3.35, 641754462.61]; % [g*mm^2]
J_b = J_b*10^-9; % [kg*m^2]
B_b = [452 0 0]; % [mm]
B_b = B_b*10^-3; % [m]

% Link 2 (c)
G_c = [457.91 -0.56 0]; % [mm]
G_c = G_c*10^-3; % [m]
J_c = [93432590.05,-2396278.43,0.00;...
       -2396278.43,1632961728.85,0.00;...
       0.00,0.00,1633630918.99]; % [g*mm^2]
J_c = J_c*10^-9; % [kg*m^2]
B_c = [980 0 0]; % [mm]
B_c = B_c*10^-3; % [m]

% Link 3 (d)
G_d = [0.07 126.98 0]; % [mm]
G_d = G_d*10^-3; % [m]
J_d = [49792681.34,35004.39,0.00;...
       35004.39,6152746.42,0.00;...
       0.00,0.00,47827169.43]; % [g*mm^2]
J_d = J_d*10^-9; % [kg*m^2]
B_d = [0 300 0]; % [mm]
B_d = B_d*10^-3; % [m]

% OLD
% Link 3 (d) + pezzo nell'angolo
% G_dp = [-5.68 160.72 -8.65]; % [mm]
% G_dp = G_dp*10^-3; % [m]
% J_dp = [75643202.79,4167840.39,-1059867.15;
%         4167840.39,8452290.84,6220246.46;
%         -1059867.15,6220246.46,72786700.13]; % [g*mm^2]
% J_dp = J_d*10^-9; % [kg*m^2]
% B_dp = [0 300 0]; % [mm]
% B_dp = B_d*10^-3; % [m]
% 
% % % Link 3 (d) + pezzo centrale
% G_dp = [0.05 160.72 0]; % [mm]
% G_dp = G_dp*10^-3; % [m]
% J_dp = [74048018.54,-44306.22,0.00;...
%         -44306.22,6152916.66,0.00;...
%         0.00,0.00,72082510.19]; % [g*mm^2]
% J_dp = J_d*10^-9; % [kg*m^2]
% B_dp = [0 300 0]; % [mm]
% B_dp = B_d*10^-3; % [m]

%% Calcolo degli pseudo-tensori di inerzia rispetto il baricentro
I_a = conversione_J_I(J_a,m_a,[0 0 0]);
I_b = conversione_J_I(J_b,m_b,[0 0 0]);
I_c = conversione_J_I(J_c,m_c,[0 0 0]);
I_d = conversione_J_I(J_d,m_d,[0 0 0]);
I_dp = conversione_J_I(J_d,m_dp,[0 0 0]);

%% Matrice di trasformazione per descrivere posizione relativa 
%  - tra baricentro e giunto estremo nel caso 1
%  - tra giunto verso base e giunto estremo nel caso 2

M_bg = [eye(3); 0 0 0];

M_bg_a = [M_bg,[G_a-B_a,1]']; % [m]
M_bg_b = [M_bg,[G_b-B_b,1]']; % [m]
M_bg_c = [M_bg,[G_c-B_c,1]']; % [m]
M_bg_d = [M_bg,[G_d-B_d,1]']; % [m]
% M_bg_dp = [M_bg,[G_dp-B_dp,1]']; % [m]

%% Pseudo-tensore di inerzia del link i-esimo rispetto il giunto estremo i-esimo
I_a_b = M_bg_a*I_a*M_bg_a';
I_b_b = M_bg_b*I_b*M_bg_b';
I_c_b = M_bg_c*I_c*M_bg_c';
I_d_b = M_bg_d*I_d*M_bg_d';
I_dp_b = M_bg_d*I_dp*M_bg_d';
% 
% Controllo (dati nel riferimento collocato nel giunto verso il gripper)
J_a_2 = [302565138.95,0.00,0.00;...
         0.00,5702287485.71,482.71;...
         0.00,482.71,5698557900.07];
I_a_ver = conversione_J_I(J_a_2*10^-9,m_a,G_a-B_a);

J_b_2 = [114588903.65,-3027375.00,0.00;...
         -3027375.00,3156693270.95,-3.35;...
         0.00,-3.35,3169213570.01];
I_b_ver = conversione_J_I(J_b_2*10^-9,m_b,G_b-B_b);

J_c_2 = [93438448.50,-7822056.64,-0.01;...
         -7822056.64,6658026842.36,0.00;...
         -0.01,0.00,6658701890.95];
I_c_ver = conversione_J_I(J_c_2*10^-9,m_c,G_c-B_c);

J_d_2 = [173810201.57 -82702.43 0.00;...
         -82702.43 6152764.77 0.00;...
         0.00 0.00 171844708.01];
I_d_ver = conversione_J_I(J_d_2*10^-9,m_d,G_d-B_d);


% Pezzo nell'angolo
% J_dp_2 = [175790868.24,97452.43,-1312750.00;...
%           97452.43,9003431.43,22250.00;...
%           -1312750.00,22250.00,172715374.68];

% Pezzo centrale
% J_dp_2 = [173810618.24,-82702.43,0.00;...
%           -82702.43,6152931.43,0.00;...
%           0.00,0.00,171845124.68];
%       
% I_dp_ver = conversione_J_I(J_dp_2*10^-9,m_dp,G_dp-B_dp);
% 
% 
