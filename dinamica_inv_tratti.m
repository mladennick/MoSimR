%% Dati

%  Tensore d'inerzia di ogni link
tensore_inerzia_acciaio;
I(:,:,1) = I_b_ver;
I(:,:,2) = I_c_ver;
I(:,:,3) = I_d_ver;


% Forze 
f = 2; % fresatura
F = [f;0;f]; % Forza esterna

f2 = 1; % sbavatura
F2 = [f2;0;f2];
% F2 = [f2;f2;f2];

phi_fresatura = zeros(4);
phi_fresatura(1:3,4) = F;
phi_fresatura(4,1:3) = -F';

phi_sbavatura = zeros(4);
phi_sbavatura(1:3,4) = F2;
phi_sbavatura(4,1:3) = -F2';

phi = zeros(4);

% Matrice di accelerazione gravitazionale
Hg = zeros(4);
Hg(2,4) = -9.81;

if(exist('grafica','var') == 0)
    grafica = 0;
end

%% FASE 0 - robot fermo in P1
Q_z = load('dati/Q_z.mat');
Q_z = Q_z.Q_z;
Q_dot_z =  load('dati/Q_dot_z.mat');
Q_dot_z = Q_dot_z.Q_dot_z;
Q_dot2_z =  load('dati/Q_dot2_z.mat');
Q_dot2_z = Q_dot2_z.Q_dot2_z;

T_z = 5;
dT_z = T_z/(n-1);
tt_z = 0:dT_z:T_z;

[theta_z,Ek_z,Ep_z,W_z] = dinamica_inv(Q_z,Q_dot_z,Q_dot2_z,L,4,n,phi,I,Hg);
Etot_z = Ek_z+Ep_z;
dEtot_z = diff(Etot_z)/dT_z;

debug_energia(Ek_z,Ep_z,W_z,dT_z,tt_z)



%% P1-P2 afferraggio oggetto
% Caricamento posizione, velocita', accelerazione dei giunti 
Q_p = load('dati/Q_p.mat');
Q_p = Q_p.Q_p;
Q_dot_p =  load('dati/Q_dot_p.mat');
Q_dot_p = Q_dot_p.Q_dot_p;
Q_dot2_p =  load('dati/Q_dot2_p.mat');
Q_dot2_p = Q_dot2_p.Q_dot2_p;

T_p = 1.412;
dT_p = T_p/(n-1);
tt_p = 0:dT_p:T_p;

[theta_p,Ek_p,Ep_p,W_p] = dinamica_inv(Q_p,Q_dot_p,Q_dot2_p,L,4,n,phi,I,Hg);
Etot_p = Ek_p+Ep_p;
dEtot_p = diff(Etot_p)/dT_p;

if grafica == 1
    debug_energia(Ek_p,Ep_p,W_p,dT_p,tt_p)
end
% theta_tot = [theta_p];


%% P2-P3 robot in posizione per fresare
I(:,:,3) = I_dp_b;

% Caricamento posizione, velocita', accelerazione dei giunti 
Q_0 = load('dati/Q_0.mat');
Q_0 = Q_0.Q_0;
Q_dot_0 =  load('dati/Q_dot_0.mat');
Q_dot_0 = Q_dot_0.Q_dot_0;
Q_dot2_0 =  load('dati/Q_dot2_0.mat');
Q_dot2_0 = Q_dot2_0.Q_dot2_0;

T_0 = 4;
n = 100;
dT_0 = T_0/(n-1);
tt_0 = 0:dT_0:T_0;

[theta_0,Ek_0,Ep_0,W_0] = dinamica_inv(Q_0,Q_dot_0,Q_dot2_0,L,4,n,phi,I,Hg);
Etot_0 = Ek_0+Ep_0;
dEtot_0 = diff(Etot_0)/dT_0;
if grafica == 1
    debug_energia(Ek_0,Ep_0,W_0,dT_0,tt_0)
end
% theta_tot = [theta_p theta_0(2:end,:)];
%% P3-P4 prima fresatura

% Caricamento posizione, velocita', accelerazione dei giunti 
Q_1 = load('dati/Q_1.mat');
Q_1 = Q_1.Q_1;
Q_dot_1 =  load('dati/Q_dot_1.mat');
Q_dot_1 = Q_dot_1.Q_dot_1;
Q_dot2_1 =  load('dati/Q_dot2_1.mat');
Q_dot2_1 = Q_dot2_1.Q_dot2_1;

T_1 = 5;
dT_1 = T_1/(n-1);
tt_1 = 0:dT_1:T_1;

[theta_1,Ek_1,Ep_1,W_1] = dinamica_inv(Q_1,Q_dot_1,Q_dot2_1,L,4,n,phi_fresatura,I,Hg);
Etot_1 = Ek_1+Ep_1;
dEtot_1 = diff(Etot_1)/dT_1;

if grafica == 1
    debug_energia(Ek_1,Ep_1,W_1,dT_1,tt_1)
end


% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:)];

%% Cambio configurazione in P4 
Q_1_1 = load('dati/Q_1_1.mat');
Q_1_1 = Q_1_1.Q_1_1;
Q_dot_1_1 =  load('dati/Q_dot_1_1.mat');
Q_dot_1_1 = Q_dot_1_1.Q_dot_1_1;
Q_dot2_1_1=  load('dati/Q_dot2_1_1.mat');
Q_dot2_1_1 = Q_dot2_1_1.Q_dot2_1_1;

T_1_1 = 4;

dT_1_1 = T_1_1/(n-1);
tt_1_1 = 0:dT_1_1:T_1_1;

[theta_1_1,Ek_1_1,Ep_1_1,W_1_1] = dinamica_inv(Q_1_1,Q_dot_1_1,Q_dot2_1_1,L,4,n,phi,I,Hg);
Etot_1_1 = Ek_1_1+Ep_1_1;
dEtot_1_1 = diff(Etot_1_1)/dT_1_1;


if grafica == 1
    debug_energia(Ek_1_1,Ep_1_1,W_1_1,dT_1_1,tt_1_1)
end



% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:) theta_1_1(2:end,:)];
%% P4-P5 - fresatura lato 2

% Caricamento posizione, velocita', accelerazione dei giunti 
Q_2 = load('dati/Q_2.mat');
Q_2 = Q_2.Q_2;
Q_dot_2 =  load('dati/Q_dot_2.mat');
Q_dot_2 = Q_dot_2.Q_dot_2;
Q_dot2_2=  load('dati/Q_dot2_2.mat');
Q_dot2_2 = Q_dot2_2.Q_dot2_2;


T_2 = 5;

dT_2 = T_2/(n-1);
tt_2 = 0:dT_2:T_2;

[theta_2,Ek_2,Ep_2,W_2] = dinamica_inv(Q_2,Q_dot_2,Q_dot2_2,L,4,n,phi_fresatura,I,Hg);
Etot_2 = Ek_2+Ep_2;
dEtot_2 = diff(Etot_2)/dT_2;



if grafica == 1
    debug_energia(Ek_2,Ep_2,W_2,dT_2,tt_2)
end



% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:) theta_1_1(2:end,:) theta_2(2:end,:)];

%% P5-P6 allontanamento fresa

% Caricamento posizione, velocita', accelerazione dei giunti 
Q_3 = load('dati/Q_3.mat');
Q_3 = Q_3.Q_3;
Q_dot_3 =  load('dati/Q_dot_3.mat');
Q_dot_3 = Q_dot_3.Q_dot_3;
Q_dot2_3 =  load('dati/Q_dot2_3.mat');
Q_dot2_3 = Q_dot2_3.Q_dot2_3;

T_3 = 1;

dT_3 = T_3/(n-1);
tt_3 = 0:dT_3:T_3;

[theta_3,Ek_3,Ep_3,W_3] = dinamica_inv(Q_3,Q_dot_3,Q_dot2_3,L,4,n,phi,I,Hg);
Etot_3 = Ek_3+Ep_3;
dEtot_3 = diff(Etot_3)/dT_3;


if grafica == 1
    debug_energia(Ek_3,Ep_3,W_3,dT_3,tt_3)
end




% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:) theta_1_1(2:end,:) theta_2(2:end,:) theta_3(2:end,:)];
%% P6-P7 traslazione

% Caricamento posizione, velocita', accelerazione dei giunti 
Q_4 = load('dati/Q_4.mat');
Q_4 = Q_4.Q_4;
Q_dot_4 =  load('dati/Q_dot_4.mat');
Q_dot_4 = Q_dot_4.Q_dot_4;
Q_dot2_4 =  load('dati/Q_dot2_4.mat');
Q_dot2_4 = Q_dot2_4.Q_dot2_4;

T_4 = 2;

dT_4 = T_4/(n-1);
tt_4 = 0:dT_4:T_4;

[theta_4,Ek_4,Ep_4,W_4] = dinamica_inv(Q_4,Q_dot_4,Q_dot2_4,L,4,n,phi,I,Hg);
Etot_4 = Ek_4+Ep_4;
dEtot_4 = diff(Etot_4)/dT_4;


if grafica == 1
    debug_energia(Ek_4,Ep_4,W_4,dT_4,tt_4)
end




% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:) theta_1_1(2:end,:) theta_2(2:end,:) theta_3(2:end,:),...
%     theta_4(2:end,:)];



%% P7-P8 posizionamento

Q_5 = load('dati/Q_5.mat');
Q_5 = Q_5.Q_5;
Q_dot_5 =  load('dati/Q_dot_5.mat');
Q_dot_5 = Q_dot_5.Q_dot_5;
Q_dot2_5 =  load('dati/Q_dot2_5.mat');
Q_dot2_5 = Q_dot2_5.Q_dot2_5;

T_5 = 2;

dT_5 = T_5/(n-1);
tt_5 = 0:dT_5:T_5;

[theta_5,Ek_5,Ep_5,W_5] = dinamica_inv(Q_5,Q_dot_5,Q_dot2_5,L,4,n,phi,I,Hg);
Etot_5 = Ek_5+Ep_5;
dEtot_5 = diff(Etot_5)/dT_5;


if grafica == 1
    debug_energia(Ek_5,Ep_5,W_5,dT_5,tt_5)
end




% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:) theta_1_1(2:end,:) theta_2(2:end,:) theta_3(2:end,:),...
%     theta_4(2:end,:) theta_5(2:end,:)];

%% P8-P9 prima sbavatura

Q_6 = load('dati/Q_6.mat');
Q_6 = Q_6.Q_6;
Q_dot_6 =  load('dati/Q_dot_6.mat');
Q_dot_6 = Q_dot_6.Q_dot_6;
Q_dot2_6=  load('dati/Q_dot2_6.mat');
Q_dot2_6 = Q_dot2_6.Q_dot2_6;

T_6 = 3;

dT_6 = T_6/(n-1);
tt_6 = 0:dT_6:T_6;

[theta_6,Ek_6,Ep_6,W_6] = dinamica_inv(Q_6,Q_dot_6,Q_dot2_6,L,4,n,phi_sbavatura,I,Hg);
Etot_6 = Ek_6+Ep_6;
dEtot_6 = diff(Etot_6)/dT_6;


if grafica == 1
    debug_energia(Ek_6,Ep_6,W_6,dT_6,tt_6)
end



% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:) theta_1_1(2:end,:) theta_2(2:end,:) theta_3(2:end,:),...
%     theta_4(2:end,:) theta_5(2:end,:) theta_6(2:end,:)];

%% P9-P10 allontanamento fresa

Q_7 = load('dati/Q_7.mat');
Q_7 = Q_7.Q_7;
Q_dot_7 =  load('dati/Q_dot_7.mat');
Q_dot_7 = Q_dot_7.Q_dot_7;
Q_dot2_7 =  load('dati/Q_dot2_7.mat');
Q_dot2_7 = Q_dot2_7.Q_dot2_7;

T_7 = 1;

dT_7 = T_7/(n-1);
tt_7 = 0:dT_7:T_7;

[theta_7,Ek_7,Ep_7,W_7] = dinamica_inv(Q_7,Q_dot_7,Q_dot2_7,L,4,n,phi,I,Hg);
Etot_7 = Ek_7+Ep_7;
dEtot_7 = diff(Etot_7)/dT_7;


if grafica == 1
    debug_energia(Ek_7,Ep_7,W_7,dT_7,tt_7)
end



% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:) theta_1_1(2:end,:) theta_2(2:end,:) theta_3(2:end,:),...
%     theta_4(2:end,:) theta_5(2:end,:) theta_6(2:end,:) theta_7(2:end,:)];
%% P10-P11 posizionamento

Q_8 = load('dati/Q_8.mat');
Q_8 = Q_8.Q_8;
Q_dot_8 =  load('dati/Q_dot_8.mat');
Q_dot_8 = Q_dot_8.Q_dot_8;
Q_dot2_8 =  load('dati/Q_dot2_8.mat');
Q_dot2_8 = Q_dot2_8.Q_dot2_8;

T_8 = 2;

dT_8 = T_8/(n-1);
tt_8 = 0:dT_8:T_8;

[theta_8,Ek_8,Ep_8,W_8] = dinamica_inv(Q_8,Q_dot_8,Q_dot2_8,L,4,n,phi,I,Hg);
Etot_8 = Ek_8+Ep_8;
dEtot_8 = diff(Etot_8)/dT_8;


if grafica == 1
    debug_energia(Ek_8,Ep_8,W_8,dT_8,tt_8)
end


% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:) theta_1_1(2:end,:) theta_2(2:end,:) theta_3(2:end,:),...
%     theta_4(2:end,:) theta_5(2:end,:) theta_6(2:end,:) theta_7(2:end,:) theta_8(2:end,:)];

%% P11-P12 seconda sbavatura

Q_9 = load('dati/Q_9.mat');
Q_9 = Q_9.Q_9;
Q_dot_9 =  load('dati/Q_dot_9.mat');
Q_dot_9 = Q_dot_9.Q_dot_9;
Q_dot2_9 =  load('dati/Q_dot2_9.mat');
Q_dot2_9 = Q_dot2_9.Q_dot2_9;

T_9 = 3;
dT_9 = T_9/(n-1);
tt_9 = 0:dT_9:T_9;

[theta_9,Ek_9,Ep_9,W_9] = dinamica_inv(Q_9,Q_dot_9,Q_dot2_9,L,4,n,phi_sbavatura,I,Hg);
Etot_9 = Ek_9+Ep_9;
dEtot_9 = diff(Etot_9)/dT_9;


if grafica == 1
    debug_energia(Ek_9,Ep_9,W_9,dT_9,tt_9)
end



% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:) theta_1_1(2:end,:) theta_2(2:end,:) theta_3(2:end,:),...
%     theta_4(2:end,:) theta_5(2:end,:) theta_6(2:end,:) theta_7(2:end,:) theta_8(2:end,:) theta_9(2:end,:)];
%% P12-P13 posizionamento terza sbavatura

Q_10 = load('dati/Q_10.mat');
Q_10 = Q_10.Q_10;
Q_dot_10 =  load('dati/Q_dot_10.mat');
Q_dot_10 = Q_dot_10.Q_dot_10;
Q_dot2_10 =  load('dati/Q_dot2_10.mat');
Q_dot2_10 = Q_dot2_10.Q_dot2_10;

T_10 = 1;

dT_10 = T_10/(n-1);
tt_10 = 0:dT_10:T_10;

[theta_10,Ek_10,Ep_10,W_10] = dinamica_inv(Q_10,Q_dot_10,Q_dot2_10,L,4,n,phi,I,Hg);
Etot_10 = Ek_10+Ep_10;
dEtot_10 = diff(Etot_10)/dT_10;

if grafica == 1
    debug_energia(Ek_10,Ep_10,W_10,dT_10,tt_10)
end



% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:) theta_1_1(2:end,:) theta_2(2:end,:) theta_3(2:end,:),...
%     theta_4(2:end,:) theta_5(2:end,:) theta_6(2:end,:) theta_7(2:end,:) theta_8(2:end,:) theta_9(2:end,:),...
%     theta_10(2:end,:)];
%% P13-P14 terza sbavatura

Q_11 = load('dati/Q_11.mat');
Q_11 = Q_11.Q_11;
Q_dot_11 =  load('dati/Q_dot_11.mat');
Q_dot_11 = Q_dot_11.Q_dot_11;
Q_dot2_11 =  load('dati/Q_dot2_11.mat');
Q_dot2_11 = Q_dot2_11.Q_dot2_11;

T_11 = 3;

dT_11 = T_11/(n-1);
tt_11 = 0:dT_11:T_11;

[theta_11,Ek_11,Ep_11,W_11] = dinamica_inv(Q_11,Q_dot_11,Q_dot2_11,L,4,n,phi_sbavatura,I,Hg);
Etot_11 = Ek_11+Ep_11;
dEtot_11 = diff(Etot_11)/dT_11;

if grafica == 1
    debug_energia(Ek_11,Ep_11,W_11,dT_11,tt_11)
end



% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:) theta_1_1(2:end,:) theta_2(2:end,:) theta_3(2:end,:),...
%     theta_4(2:end,:) theta_5(2:end,:) theta_6(2:end,:) theta_7(2:end,:) theta_8(2:end,:) theta_9(2:end,:),...
%     theta_10(2:end,:) theta_11(2:end,:)];

%% P14-P15 allontanamento dalla fresatrice

Q_12 = load('dati/Q_12.mat');
Q_12 = Q_12.Q_12;
Q_dot_12 =  load('dati/Q_dot_12.mat');
Q_dot_12 = Q_dot_12.Q_dot_12;
Q_dot2_12 =  load('dati/Q_dot2_12.mat');
Q_dot2_12 = Q_dot2_12.Q_dot2_12;

T_12 = 1;

dT_12 = T_12/(n-1);
tt_12 = [0:dT_12:T_12];

[theta_12,Ek_12,Ep_12,W_12] = dinamica_inv(Q_12,Q_dot_12,Q_dot2_12,L,4,n,phi,I,Hg);
Etot_12 = Ek_12+Ep_12;
dEtot_12 = diff(Etot_12)/dT_12;

if grafica == 1
    debug_energia(Ek_12,Ep_12,W_12,dT_12,tt_12)
end


% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:) theta_1_1(2:end,:) theta_2(2:end,:) theta_3(2:end,:),...
%     theta_4(2:end,:) theta_5(2:end,:) theta_6(2:end,:) theta_7(2:end,:) theta_8(2:end,:) theta_9(2:end,:),...
%     theta_10(2:end,:) theta_11(2:end,:) theta_12(2:end,:)];

%% Cambio configurazione in P15

Q_12_1 = load('dati/Q_12_1.mat');
Q_12_1 = Q_12_1.Q_12_1;
Q_dot_12_1 =  load('dati/Q_dot_12_1.mat');
Q_dot_12_1 = Q_dot_12_1.Q_dot_12_1;
Q_dot2_12_1 =  load('dati/Q_dot2_12_1.mat');
Q_dot2_12_1 = Q_dot2_12_1.Q_dot2_12_1;

T_12_1 = 5;

dT_12_1 = T_12_1/(n-1);
tt_12_1 = [0:dT_12_1:T_12_1];

[theta_12_1,Ek_12_1,Ep_12_1,W_12_1] = dinamica_inv(Q_12_1,Q_dot_12_1,Q_dot2_12_1,L,4,n,phi,I,Hg);
Etot_12_1 = Ek_12_1+Ep_12_1;
dEtot_12_1 = diff(Etot_12_1)/dT_12_1;

if grafica == 1
    debug_energia(Ek_12_1,Ep_12_1,W_12_1,dT_12_1,tt_12_1)
end





% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:) theta_1_1(2:end,:) theta_2(2:end,:) theta_3(2:end,:),...
%     theta_4(2:end,:) theta_5(2:end,:) theta_6(2:end,:) theta_7(2:end,:) theta_8(2:end,:) theta_9(2:end,:),...
%     theta_10(2:end,:) theta_11(2:end,:) theta_12(2:end,:) theta_12_1(2:end,:)];

%% P15-P2 rilascio pezzo

Q_r = load('dati/Q_r.mat');
Q_r = Q_r.Q_r;
Q_dot_r =  load('dati/Q_dot_r.mat');
Q_dot_r = Q_dot_r.Q_dot_r;
Q_dot2_r =  load('dati/Q_dot2_r.mat');
Q_dot2_r= Q_dot2_r.Q_dot2_r;

T_r = 3;

dT_r = T_r/(n-1);
tt_r = 0:dT_r:T_r;

[theta_r,Ek_r,Ep_r,W_r] = dinamica_inv(Q_r,Q_dot_r,Q_dot2_r,L,4,n,phi,I,Hg);
Etot_r = Ek_r+Ep_r;
dEtot_r = diff(Etot_r)/dT_r;

if grafica == 1
    debug_energia(Ek_r,Ep_r,W_r,dT_r,tt_r)
end


% theta_tot = [theta_p theta_0(2:end,:) theta_1(2:end,:) theta_1_1(2:end,:) theta_2(2:end,:) theta_3(2:end,:),...
%     theta_4(2:end,:) theta_5(2:end,:) theta_6(2:end,:) theta_7(2:end,:) theta_8(2:end,:) theta_9(2:end,:),...
%     theta_10(2:end,:) theta_11(2:end,:) theta_12(2:end,:) theta_12_1(2:end,:) theta_r(2:end,:)];

%% P2-P1 ritorno a posizione di riposo
I(:,:,3) = I_d_ver;

Q_f = load('dati/Q_f.mat');
Q_f = Q_f.Q_f;
Q_dot_f =  load('dati/Q_dot_f.mat');
Q_dot_f = Q_dot_f.Q_dot_f;
Q_dot2_f =  load('dati/Q_dot2_f.mat');
Q_dot2_f= Q_dot2_f.Q_dot2_f;

I(:,:,3) = I_d_b;

T_f = 1.412;
T_sim = T_f;
dT_f = T_f/(n-1);
tt_f = 0:dT_f:T_f;

[theta_f,Ek_f,Ep_f,W_f] = dinamica_inv(Q_f,Q_dot_f,Q_dot2_f,L,4,n,phi,I,Hg);
Etot_f = Ek_f+Ep_f;
dEtot_f = diff(Etot_f)/dT_f;

if grafica == 1
    debug_energia(Ek_f,Ep_f,W_f,dT_f,tt_f)
end




%% Robot fermo in P1

Q_z = load('dati/Q_z.mat');
Q_z = Q_z.Q_z;
Q_dot_z =  load('dati/Q_dot_z.mat');
Q_dot_z = Q_dot_z.Q_dot_z;
Q_dot2_z =  load('dati/Q_dot2_z.mat');
Q_dot2_z = Q_dot2_z.Q_dot2_z;

T_z = 5;
dT_z = T_z/(n-1);
tt_z = 0:dT_z:T_z;

I(:,:,3) = I_d_b;

[theta_z,Ek_z,Ep_z,W_z] = dinamica_inv(Q_z,Q_dot_z,Q_dot2_z,L,4,n,phi,I,Hg);
Etot_z = Ek_z+Ep_z;
dEtot_z = diff(Etot_z)/dT_z;

if grafica == 1
    debug_energia(Ek_z,Ep_z,W_z,dT_z,tt_z)
end



%% concatenazione coppie
theta_tot = [theta_z; theta_p(2:end,:); theta_0(2:end,:); theta_1(2:end,:);theta_1_1(2:end,:);theta_2(2:end,:);...
             theta_3(2:end,:); theta_4(2:end,:); theta_5(2:end,:); theta_6(2:end,:);...
             theta_7(2:end,:); theta_8(2:end,:); theta_9(2:end,:); theta_10(2:end,:); theta_11(2:end,:);...
             theta_12(2:end,:); theta_12_1(2:end,:); theta_r(2:end,:); theta_f(2:end,:); theta_z(2:end,:)];

%% DEBUG ENERGIA
Ek_tot = [Ek_z Ek_p(2:end) Ek_0(2:end) Ek_1(2:end) Ek_1_1(2:end) Ek_2(2:end) Ek_3(2:end) Ek_4(2:end) Ek_5(2:end) Ek_6(2:end) Ek_7(2:end) Ek_8(2:end) Ek_9(2:end) Ek_10(2:end) Ek_11(2:end) Ek_12(2:end) Ek_12_1(2:end) Ek_r(2:end) Ek_f(2:end) Ek_z(2:end)];
Ep_tot = [Ep_z Ep_p(2:end) Ep_0(2:end) Ep_1(2:end) Ep_1_1(2:end) Ep_2(2:end) Ep_3(2:end) Ep_4(2:end) Ep_5(2:end) Ep_6(2:end) Ep_7(2:end) Ep_8(2:end) Ep_9(2:end) Ep_10(2:end) Ep_11(2:end) Ep_12(2:end) Ep_12_1(2:end) Ep_r(2:end) Ep_f(2:end) Ep_z(2:end)];
Etot_tot = [Etot_z Etot_p(2:end) Etot_0(2:end) Etot_1(2:end) Etot_1_1(2:end) Etot_2(2:end) Etot_3(2:end) Etot_4(2:end) Etot_5(2:end) Etot_6(2:end) Etot_7(2:end) Etot_8(2:end) Etot_9(2:end) Etot_10(2:end) Etot_11(2:end) Etot_12(2:end) Etot_12_1(2:end) Etot_r(2:end) Etot_f(2:end) Etot_z(2:end)];
dEtot_tot = [dEtot_z dEtot_p dEtot_0 dEtot_1 dEtot_1_1 dEtot_2 dEtot_3 dEtot_4 dEtot_5 dEtot_6 dEtot_7 dEtot_8 dEtot_9 dEtot_10 dEtot_11 dEtot_12 dEtot_12_1 dEtot_r dEtot_f dEtot_z];
W_tot = [W_z W_p(2:end) W_0(2:end) W_1(2:end) W_1_1(2:end) W_2(2:end) W_3(2:end) W_4(2:end) W_5(2:end) W_6(2:end) W_7(2:end) W_8(2:end) W_9(2:end) W_10(2:end) W_11(2:end) W_12(2:end) W_12_1(2:end) W_r(2:end) W_f(2:end) W_z(2:end)];

if grafica == 1
    figure()
    xlabel('t [s]')
    ylabel('Energia [J]')
    xlim([0 T_tot])
    hold on
    plot(tt_tot,Ek_tot,tt_tot,Ep_tot,tt_tot,Etot_tot,'--','LineWidth',1.6) 
    title('Energia cinetica, potenziale, totale')
    legend('Energia cinetica','Energia potenziale','Energia totale','location','south')
    grid on

    figure()
    yline(0);
    xlabel('t [s]')
    xlim([0 T_tot])
    ylabel('Potenza [W]')
    hold on
    plot(tt_tot,W_tot,'y','LineWidth',1.6) 
    plot(tt_tot(1:end-1),dEtot_tot,'--','LineWidth', 1.6)
    title('Confronto potenza in ingresso-derivata energia totale')
    legend('','Pm+Pe','d(Etot)/dt','location','north')
    grid on
end

dinamica_inv_tratti_check = 1;