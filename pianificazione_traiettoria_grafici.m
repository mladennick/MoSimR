%% Grafici pianificazione moto manipolatore

% Pezzo da lavorare
l_pz = 0.1;
h_pz = 0.04;

% Calcolo workspace 2D per viste manipolatore + traiettorie
[X1,Y1,Z1] = plot_ws_2D_viste(minQ1,maxQ1,minQ2,maxQ2,minQ3,maxQ3,L,n,1);
[X2,Y2,Z2] = plot_ws_2D_viste(minQ1,maxQ1,minQ2,maxQ2,minQ3,maxQ3,L,n,3);

% Fresatrice
r = 0.05;            
cnt = [2.15; 0];       
height = 2;         
color = [0 0 1];
nSides = 100;   
fresatrice = struct('r',r,'cnt',cnt,'height',height,'color',color,'nSides',nSides);

% Condizioni iniziali e finali di velocita' e accelerazione (valgono sia
% nello spazio di lavoro, sia nello spazio dei giunti)
v0 = [0 0 0];
vf = [0 0 0];
a0 = [0 0 0];
af = [0 0 0];

% Punti nello spazio di lavoro
% Fresatura
S_p1 = [1.7500 0.3000 0];
S_p2 = [1.6475 -0.9223 0];
S_p3 = [2 0 0.05];
S_p4 = [2 0 -0.05-0.1];
S_p5 = [2.2  0 -0.05-0.1];
S_p6 = [2.2  0 -0.05-0.2];
S_p7 = [1.9 0 -0.05-0.2];

% Punti nello spazio dei giunti
% Fresatura
Q_p1 = cinematica_inversa_NR2(S_p1,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p2 = cinematica_inversa_NR2(S_p2,[0 0 pi],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p3 = cinematica_inversa_NR2(S_p3,[0 0 pi],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p4 = cinematica_inversa_NR2(S_p4,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p4_1 = cinematica_inversa_NR2(S_p4,[0 0 pi],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p5 = cinematica_inversa_NR2(S_p5,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p6 = cinematica_inversa_NR2(S_p6,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p7 = cinematica_inversa_NR2(S_p7,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);

% Punti ausiliari per la definizione della traiettoria di sbavatura
Q = [2.15-r*sqrt(2),0,0]; 
V = [Q(1)-l_pz*sqrt(2)/4,0,l_pz*sqrt(2)/4]; 
X = Q+[r*sqrt(2),0,-r*sqrt(2)];
W = V+[l_pz/2+r*sqrt(2),0,-l_pz/2-r*sqrt(2)]; 
Y = X+[r-0.05*r,0,r-0.05*r]; 

% Spazio di lavoro sbavatura
S_p8 = [Q(1)-l_pz*sqrt(2)/4-l_pz,0,-l_pz*sqrt(2)/4];
S_p9 = [Q(1)+r*sqrt(2)-l_pz,0,r*sqrt(2)];
S_p10 = [Q(1)+r*sqrt(2)-l_pz,0,r*sqrt(2)+r];
S_p11 = V+[-l_pz,0,-l_pz];
S_p12 = W+[-l_pz,0,-l_pz];
S_p13 = X+[0,0,-l_pz];
S_p14 = Y+[0,0,-l_pz];
S_p15 = S_p14+[-l_pz-0.15,0,-l_pz];

% Spazio dei giunti sbavatura
Q_p8 = cinematica_inversa_NR2(S_p8,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p9 = cinematica_inversa_NR2(S_p9,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p10 = cinematica_inversa_NR2(S_p10,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p11 = cinematica_inversa_NR2(S_p11,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p12 = cinematica_inversa_NR2(S_p12,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p13 = cinematica_inversa_NR2(S_p13,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p14 = cinematica_inversa_NR2(S_p14,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p15 = cinematica_inversa_NR2(S_p15,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p15_1 = cinematica_inversa_NR2(S_p15,[0 0 pi],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);



%% 1) P1-P2 afferraggio oggetto

% Caricamento posizione, velocita', accelerazione dei giunti 
Q_p = load('dati/Q_p.mat');
Q_p = Q_p.Q_p;
Q_dot_p =  load('dati/Q_dot_p.mat');
Q_dot_p = Q_dot_p.Q_dot_p;
Q_dot2_p =  load('dati/Q_dot2_p.mat');
Q_dot2_p = Q_dot2_p.Q_dot2_p;

for i=1:n
    [x_p(i),y_p(i),z_p(i)] = cinematica_diretta(Q_p(1,i),Q_p(2,i),Q_p(3,i),L);
end

% Tempo
T_p = 1.412;
dT_p = T_p/(n-1);
tt_p = 0:dT_p:T_p;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita' e accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_p(1,:),Q_dot_p(1,:),Q_dot2_p(1,:),tt_p,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_p(2,:),Q_dot_p(2,:),Q_dot2_p(2,:),tt_p,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_p(3,:),Q_dot_p(3,:),Q_dot2_p(3,:),tt_p,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 3D nello spazio di lavoro
plot_traiettoria_ws(Q_p1,Q_p2,L,fresatrice,x_p,y_p,z_p,1,'P1-P2: presa del pezzo',false,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_p1,Q_p2,L,fresatrice,x_p,y_p,z_p,1.5,false,true,X1,Y1,Z1,X2,Y2,Z2)

%% 2) P2-P3 robot in posizione per fresare

% Caricamento posizione, velocita', accelerazione dei giunti 
Q_0 = load('dati/Q_0.mat');
Q_0 = Q_0.Q_0;
Q_dot_0 =  load('dati/Q_dot_0.mat');
Q_dot_0 = Q_dot_0.Q_dot_0;
Q_dot2_0 =  load('dati/Q_dot2_0.mat');
Q_dot2_0 = Q_dot2_0.Q_dot2_0;

n = 100;
T_0 = 4;
dT_0 = T_0/(n-1);
tt_0 = 0:dT_0:T_0;

[x0,y0,z0,v0_x,v0_y,v0_z,a0_x,a0_y,a0_z] = traiettoria_rett_cicl(S_p2,S_p3,T_0,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita' e accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_0(1,:),Q_dot_0(1,:),Q_dot2_0(1,:),tt_0,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_0(2,:),Q_dot_0(2,:),Q_dot2_0(2,:),tt_0,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_0(3,:),Q_dot_0(3,:),Q_dot2_0(3,:),tt_0,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_0(:,1),Q_0(:,end),L,fresatrice,x0,y0,z0,1,'Moto P2-P3: avvicinamento alla fresatrice',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_p2,Q_p3,L,fresatrice,x0,y0,z0,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)

%% 3) P3-P4 prima fresatura

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

K1 = [0.01,5,0.01,4.2947,0.01,5,0.01];
[x1,y1,z1,v1_x,v1_y,v1_z,a1_x,a1_y,a1_z] = traiett_rett_7tratti(S_p3,S_p4,T_1,n,v0,vf,a0,af,K1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita' e accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_1(1,:),Q_dot_1(1,:),Q_dot2_1(1,:),tt_1,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_1(2,:),Q_dot_1(2,:),Q_dot2_1(2,:),tt_1,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_1(3,:),Q_dot_1(3,:),Q_dot2_1(3,:),tt_1,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_1(:,1),Q_1(:,end),L,fresatrice,x1,y1,z1,1,'Moto P3-P4: lucidatura lato 1',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_1(:,1),Q_1(:,end),L,fresatrice,x1,y1,z1,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)

%% 4) Cambio configurazione in P4 

Q_1_1 = load('dati/Q_1_1.mat');
Q_1_1 = Q_1_1.Q_1_1;
Q_dot_1_1 =  load('dati/Q_dot_1_1.mat');
Q_dot_1_1 = Q_dot_1_1.Q_dot_1_1;
Q_dot2_1_1=  load('dati/Q_dot2_1_1.mat');
Q_dot2_1_1 = Q_dot2_1_1.Q_dot2_1_1;

T_1_1 = 4;
dT_1_1 = T_1_1/(n-1);
tt_1_1 = 0:dT_1_1:T_1_1;

for i=1:n
    [x1_1(i),y1_1(i),z1_1(i)] = cinematica_diretta(Q_1_1(1,i),Q_1_1(2,i),Q_1_1(3,i),L);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita' e accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_1_1(1,:),Q_dot_1_1(1,:),Q_dot2_1_1(1,:),tt_1_1,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_1_1(2,:),Q_dot_1_1(2,:),Q_dot2_1_1(2,:),tt_1_1,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_1_1(3,:),Q_dot_1_1(3,:),Q_dot2_1_1(3,:),tt_1_1,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_p4_1,Q_p4,L,fresatrice,x1_1,y1_1,z1_1,1,'Cambio configurazione',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_1_1(:,1),Q_1_1(:,end),L,fresatrice,S_p4(1),S_p4(2),S_p4(3),1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)

%% 5) P4-P5 - fresatura lato 2

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

K2 = [0.01,5,0.01,5.0623,0.01,5,0.01];
[x2,y2,z2,v2_x,v2_y,v2_z,a2_x,a2_y,a2_z] = traiett_rett_7tratti(S_p4,S_p5,T_2,n,v0,vf,a0,af,K2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita' e accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_2(1,:),Q_dot_2(1,:),Q_dot2_2(1,:),tt_2,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_2(2,:),Q_dot_2(2,:),Q_dot2_2(2,:),tt_2,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_2(3,:),Q_dot_2(3,:),Q_dot2_2(3,:),tt_2,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_2(:,1),Q_2(:,end),L,fresatrice,x2,y2,z2,1,'Moto P4-P5: lucidatura lato 2',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_2(:,1),Q_2(:,end),L,fresatrice,x2,y2,z2,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)

%% 6) P5-P6 allontanamento dalla fresatrice

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

[x3,y3,z3,v3_x,v3_y,v3_z,a3_x,a3_y,a3_z] = traiettoria_rett_cicl(S_p5,S_p6,T_3,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Plot posizione, velocita' e accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_3(1,:),Q_dot_3(1,:),Q_dot2_3(1,:),tt_3,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_3(2,:),Q_dot_3(2,:),Q_dot2_3(2,:),tt_3,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_3(3,:),Q_dot_3(3,:),Q_dot2_3(3,:),tt_3,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_3(:,1),Q_3(:,end),L,fresatrice,x3,y3,z3,1,'Moto P5-P6: allontanamento dalla fresatrice',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_3(:,1),Q_3(:,end),L,fresatrice,x3,y3,z3,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)

%% 7) Moto da P6 a P7 : traslazione all'indietro per arrivare a P3 senza interferenze

Q_4 = load('dati/Q_4.mat');
Q_4 = Q_4.Q_4;
Q_dot_4 =  load('dati/Q_dot_4.mat');
Q_dot_4 = Q_dot_4.Q_dot_4;
Q_dot2_4 =  load('dati/Q_dot2_4.mat');
Q_dot2_4 = Q_dot2_4.Q_dot2_4;

T_4 = 2;
dT_4 = T_4/(n-1);
tt_4 = 0:dT_4:T_4;

[x4,y4,z4,v4_x,v4_y,v4_z,a4_x,a4_y,a4_z] = traiettoria_rett_cicl(S_p6,S_p7,T_4,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita', accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_4(1,:),Q_dot_4(1,:),Q_dot2_4(1,:),tt_4,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_4(2,:),Q_dot_4(2,:),Q_dot2_4(2,:),tt_4,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_4(3,:),Q_dot_4(3,:),Q_dot2_4(3,:),tt_4,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_4(:,1),Q_4(:,end),L,fresatrice,x4,y4,z4,1,'Moto P6-P7: allontanamento dalla fresatrice',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_4(:,1),Q_4(:,end),L,fresatrice,x4,y4,z4,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)


%% 8) Moto da P7 a P8: posizionamento per secondo ciclo (sbavatura)

Q_5 = load('dati/Q_5.mat');
Q_5 = Q_5.Q_5;
Q_dot_5 =  load('dati/Q_dot_5.mat');
Q_dot_5 = Q_dot_5.Q_dot_5;
Q_dot2_5 =  load('dati/Q_dot2_5.mat');
Q_dot2_5 = Q_dot2_5.Q_dot2_5;

T_5 = 2;
dT_5 = T_5/(n-1);
tt_5 = 0:dT_5:T_5;

[x5,y5,z5,v5_x,v5_y,v5_z,a5_x,a5_y,a5_z] = traiettoria_rett_cicl(S_p7,S_p8,T_5,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita', accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_5(1,:),Q_dot_5(1,:),Q_dot2_5(1,:),tt_5,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_5(2,:),Q_dot_5(2,:),Q_dot2_5(2,:),tt_5,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_5(3,:),Q_dot_5(3,:),Q_dot2_5(3,:),tt_5,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_5(:,1),Q_5(:,end),L,fresatrice,x5,y5,z5,1,'Moto P7-P3: avvicinamento alla fresatrice',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_5(:,1),Q_5(:,end),L,fresatrice,x5,y5,z5,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)

%% 9) Ciclo sbavatura: moto da P8 a P9: prima sbavatura

Q_6 = load('dati/Q_6.mat');
Q_6 = Q_6.Q_6;
Q_dot_6 =  load('dati/Q_dot_6.mat');
Q_dot_6 = Q_dot_6.Q_dot_6;
Q_dot2_6=  load('dati/Q_dot2_6.mat');
Q_dot2_6 = Q_dot2_6.Q_dot2_6;

T_6 = 3;
dT_6 = T_6/(n-1);
tt_6 = 0:dT_6:T_6;

K6 = [0.01,5,0.01,5,0.01,5,0.01];
[x6,y6,z6,v6_x,v6_y,v6_z,a6_x,a6_y,a6_z] = traiett_rett_7tratti(S_p8,S_p9,T_6,n,v0,vf,a0,af,K6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita', accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_6(1,:),Q_dot_6(1,:),Q_dot2_6(1,:),tt_6,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_6(2,:),Q_dot_6(2,:),Q_dot2_6(2,:),tt_6,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_6(3,:),Q_dot_6(3,:),Q_dot2_6(3,:),tt_6,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_6(:,1),Q_6(:,end),L,fresatrice,x6,y6,z6,1,'Moto P8-P9: prima sbavatura',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_6(:,1),Q_6(:,end),L,fresatrice,x6,y6,z6,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)


%% 10) Moto da P9 a P10: allontanamento dalla fresatrice

Q_7 = load('dati/Q_7.mat');
Q_7 = Q_7.Q_7;
Q_dot_7 =  load('dati/Q_dot_7.mat');
Q_dot_7 = Q_dot_7.Q_dot_7;
Q_dot2_7 =  load('dati/Q_dot2_7.mat');
Q_dot2_7 = Q_dot2_7.Q_dot2_7;

T_7 = 1;
dT_7 = T_7/(n-1);
tt_7 = 0:dT_7:T_7;

[x7,y7,z7,v7_x,v7_y,v7_z,a7_x,a7_y,a7_z] = traiettoria_rett_cicl(S_p9,S_p10,T_7,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita', accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_7(1,:),Q_dot_7(1,:),Q_dot2_7(1,:),tt_7,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_7(2,:),Q_dot_7(2,:),Q_dot2_7(2,:),tt_7,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_7(3,:),Q_dot_7(3,:),Q_dot2_7(3,:),tt_7,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_7(:,1),Q_7(:,end),L,fresatrice,x7,y7,z7,1,'Moto P9-P10: allontanamento dalla fresatrice',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_7(:,1),Q_7(:,end),L,fresatrice,x7,y7,z7,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)


%% 11) Moto da P10 a P11: posizionamento per seconda sbavatura
Q_8 = load('dati/Q_8.mat');
Q_8 = Q_8.Q_8;
Q_dot_8 =  load('dati/Q_dot_8.mat');
Q_dot_8 = Q_dot_8.Q_dot_8;
Q_dot2_8 =  load('dati/Q_dot2_8.mat');
Q_dot2_8 = Q_dot2_8.Q_dot2_8;

T_8 = 2;
dT_8 = T_8/(n-1);
tt_8 = 0:dT_8:T_8;

[x8,y8,z8,v8_x,v8_y,v8_z,a8_x,a8_y,a8_z] = traiettoria_rett_cicl(S_p10,S_p11,T_8,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita', accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_8(1,:),Q_dot_8(1,:),Q_dot2_8(1,:),tt_8,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_8(2,:),Q_dot_8(2,:),Q_dot2_8(2,:),tt_8,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_8(3,:),Q_dot_8(3,:),Q_dot2_8(3,:),tt_8,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_8(:,1),Q_8(:,end),L,fresatrice,x8,y8,z8,1,'Moto P10 a P11: posizionamento per seconda sbavatura',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_8(:,1),Q_8(:,end),L,fresatrice,x8,y8,z8,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)


%% 12) Moto da P11 a P12: seconda sbavatura

Q_9 = load('dati/Q_9.mat');
Q_9 = Q_9.Q_9;
Q_dot_9 =  load('dati/Q_dot_9.mat');
Q_dot_9 = Q_dot_9.Q_dot_9;
Q_dot2_9 =  load('dati/Q_dot2_9.mat');
Q_dot2_9 = Q_dot2_9.Q_dot2_9;

T_9 = 3;
dT_9 = T_9/(n-1);
tt_9 = 0:dT_9:T_9;

K9 = [0.01,5,0.01,5,0.01,5,0.01];
[x9,y9,z9,v9_x,v9_y,v9_z,a9_x,a9_y,a9_z] = traiett_rett_7tratti(S_p11,S_p12,T_9,n,v0,vf,a0,af,K9);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita', accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_9(1,:),Q_dot_9(1,:),Q_dot2_9(1,:),tt_9,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_9(2,:),Q_dot_9(2,:),Q_dot2_9(2,:),tt_9,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_9(3,:),Q_dot_9(3,:),Q_dot2_9(3,:),tt_9,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_9(:,1),Q_9(:,end),L,fresatrice,x9,y9,z9,1,'Moto P11-P12: seconda sbavatura',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_9(:,1),Q_9(:,end),L,fresatrice,x9,y9,z9,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)


%% 13) Moto da P12 a P13 : posizionamento terza sbavatura

Q_10 = load('dati/Q_10.mat');
Q_10 = Q_10.Q_10;
Q_dot_10 =  load('dati/Q_dot_10.mat');
Q_dot_10 = Q_dot_10.Q_dot_10;
Q_dot2_10 =  load('dati/Q_dot2_10.mat');
Q_dot2_10 = Q_dot2_10.Q_dot2_10;

T_10 = 1;
dT_10 = T_10/(n-1);
tt_10 = 0:dT_10:T_10;

[x10,y10,z10,v10_x,v10_y,v10_z,a10_x,a10_y,a10_z] = traiettoria_rett_cicl(S_p12,S_p13,T_10,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita', accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_10(1,:),Q_dot_10(1,:),Q_dot2_10(1,:),tt_10,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_10(2,:),Q_dot_10(2,:),Q_dot2_10(2,:),tt_10,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_10(3,:),Q_dot_10(3,:),Q_dot2_10(3,:),tt_10,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_10(:,1),Q_10(:,end),L,fresatrice,x10,y10,z10,1,'Moto P12 a P13: posizionamento per terza sbavatura',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_10(:,1),Q_10(:,end),L,fresatrice,x10,y10,z10,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)


%% 14) Moto da P13 a P14: terza sbavatura

Q_11 = load('dati/Q_11.mat');
Q_11 = Q_11.Q_11;
Q_dot_11 =  load('dati/Q_dot_11.mat');
Q_dot_11 = Q_dot_11.Q_dot_11;
Q_dot2_11 =  load('dati/Q_dot2_11.mat');
Q_dot2_11 = Q_dot2_11.Q_dot2_11;

T_11 = 3;
dT_11 = T_11/(n-1);
tt_11 = 0:dT_11:T_11;


[x11,y11,z11,v11_x,v11_y,v11_z,a11_x,a11_y,a11_z] = traiettoria_rett_cicl(S_p13,S_p14,T_11,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita', accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_11(1,:),Q_dot_11(1,:),Q_dot2_11(1,:),tt_11,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_11(2,:),Q_dot_11(2,:),Q_dot2_11(2,:),tt_11,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_11(3,:),Q_dot_11(3,:),Q_dot2_11(3,:),tt_11,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_11(:,1),Q_11(:,end),L,fresatrice,x11,y11,z11,1,'Moto P13-P14: terza sbavatura',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_11(:,1),Q_11(:,end),L,fresatrice,x11,y11,z11,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)


%% 15) Moto da P14 a P15: allontanamento dalla fresatrice

Q_12 = load('dati/Q_12.mat');
Q_12 = Q_12.Q_12;
Q_dot_12 =  load('dati/Q_dot_12.mat');
Q_dot_12 = Q_dot_12.Q_dot_12;
Q_dot2_12 =  load('dati/Q_dot2_12.mat');
Q_dot2_12 = Q_dot2_12.Q_dot2_12;

T_12 = 1;
dT_12 = T_12/(n-1);
tt_12 = [0:dT_12:T_12];

[x12,y12,z12,v12_x,v12_y,v12_z,a12_x,a12_y,a12_z] = traiettoria_rett_cicl(S_p14,S_p15,T_12,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita', accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_12(1,:),Q_dot_12(1,:),Q_dot2_12(1,:),tt_12,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_12(2,:),Q_dot_12(2,:),Q_dot2_12(2,:),tt_12,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_12(3,:),Q_dot_12(3,:),Q_dot2_12(3,:),tt_12,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_12(:,1),Q_12(:,end),L,fresatrice,x12,y12,z12,1,'Moto P14 a P15: allontanamento dalla fresatrice',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_12(:,1),Q_12(:,end),L,fresatrice,x12,y12,z12,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)


%% 16) Cambio configurazione in P15

Q_12_1 = load('dati/Q_12_1.mat');
Q_12_1 = Q_12_1.Q_12_1;
Q_dot_12_1 =  load('dati/Q_dot_12_1.mat');
Q_dot_12_1 = Q_dot_12_1.Q_dot_12_1;
Q_dot2_12_1 =  load('dati/Q_dot2_12_1.mat');
Q_dot2_12_1 = Q_dot2_12_1.Q_dot2_12_1;

T_12_1 = 5;
dT_12_1 = T_12_1/(n-1);
tt_12_1 = [0:dT_12_1:T_12_1];

for i=1:n
    [x12_1(i),y12_1(i),z12_1(i)] = cinematica_diretta(Q_12_1(1,i),Q_12_1(2,i),Q_12_1(3,i),L);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita', accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_12_1(1,:),Q_dot_12_1(1,:),Q_dot2_12_1(1,:),tt_12_1,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_12_1(2,:),Q_dot_12_1(2,:),Q_dot2_12_1(2,:),tt_12_1,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_12_1(3,:),Q_dot_12_1(3,:),Q_dot2_12_1(3,:),tt_12_1,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_p15,Q_p15_1,L,fresatrice,x12_1,y12_1,z12_1,1,'Cambio configurazione',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_12_1(:,1),Q_12_1(:,end),L,fresatrice,S_p15(1),S_p15(2),S_p15(3),1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)


%% 17) Moto da P15 a P2: rilascio del pezzo

Q_r = load('dati/Q_r.mat');
Q_r = Q_r.Q_r;
Q_dot_r =  load('dati/Q_dot_r.mat');
Q_dot_r = Q_dot_r.Q_dot_r;
Q_dot2_r =  load('dati/Q_dot2_r.mat');
Q_dot2_r= Q_dot2_r.Q_dot2_r;


T_r = 3;
dT_r = T_r/(n-1);
tt_r = 0:dT_r:T_r;

[xr,yr,zr,vr_x,vr_y,vr_z,ar_x,ar_y,ar_z] = traiettoria_rett_cicl(S_p15,S_p2,T_r,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita', accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_r(1,:),Q_dot_r(1,:),Q_dot2_r(1,:),tt_r,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_r(2,:),Q_dot_r(2,:),Q_dot2_r(2,:),tt_r,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_r(3,:),Q_dot_r(3,:),Q_dot2_r(3,:),tt_r,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_r(:,1),Q_r(:,end),L,fresatrice,xr,yr,zr,1,'Moto P14 a P15: rilascio del pezzo',true,true,true)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot traiettoria 2D nello spazio di lavoro
crea_subFigure_traiettoria_ws(Q_r(:,1),Q_r(:,end),L,fresatrice,xr,yr,zr,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)


%% 18) Moto da P2 a P1: il robot torna in posizione di riposo
% Minimo tempo di attuazione, legge di moto sette tratti

Q_f = load('dati/Q_f.mat');
Q_f = Q_f.Q_f;
Q_dot_f =  load('dati/Q_dot_f.mat');
Q_dot_f = Q_dot_f.Q_dot_f;
Q_dot2_f =  load('dati/Q_dot2_f.mat');
Q_dot2_f = Q_dot2_f.Q_dot2_f;

T_f = 1.412;
dT_f = T_f/(n-1);
tt_f = 0:dT_f:T_f;

for i=1:n
    [x_f(i),y_f(i),z_f(i)] = cinematica_diretta(Q_f(1,i),Q_f(2,i),Q_f(3,i),L);
end


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
plot_traiettoria_ws(Q_p2,Q_p1,L,fresatrice,x_f,y_f,z_f,1,'P2-P1: ritorno in posizione iniziale P1',true,false,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita', accelerazione dei giunti
plot_traiettoria_giunto(1,'r',Q_f(1,:),Q_dot_f(1,:),Q_dot2_f(1,:),tt_f,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',Q_f(2,:),Q_dot_f(2,:),Q_dot2_f(2,:),tt_f,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',Q_f(3,:),Q_dot_f(3,:),Q_dot2_f(3,:),tt_f,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)


crea_subFigure_traiettoria_ws(Q_p2,Q_p1,L,fresatrice,x_f,y_f,z_f,1.5,true,true,X1,Y1,Z1,X2,Y2,Z2)


%% Grafici traiettoria completa
% Posizione completa
figure
plot(tt_tot,Q_tot(1,:),'-','LineWidth',1.6)
grid on
xlim([0 T_tot])
ylim([-2 2])
xlabel('tempo [s]');
ylabel('Posizione [rad]')
title('Giunto 1')
hold on
plot([tt_tot(1) tt_tot(end)], [deg2rad(minQ1) deg2rad(minQ1)],'r--',[tt_tot(1) tt_tot(end)],[deg2rad(maxQ1) deg2rad(maxQ1)],'r--');

figure
plot(tt_tot,Q_tot(2,:),'-','LineWidth',1.6)
hold on
plot([tt_tot(1) tt_tot(end)], [minQ2 minQ2],'r--',[tt_tot(1) tt_tot(end)],[maxQ2 maxQ2],'r--');
grid on
xlim([0 T_tot])
ylim([-0.1 0.5])
xlabel('tempo [s]');
ylabel('Posizione [m]')
title('Giunto 2')

figure
plot(tt_tot,Q_tot(3,:),'-','LineWidth',1.6)
grid on
xlim([0 T_tot])
ylim([-8 8])
xlabel('tempo [s]');
ylabel('Posizione [rad]')
title('Giunto 3')
hold on
plot([tt_tot(1) tt_tot(end)], [deg2rad(minQ3) deg2rad(minQ3)],'r--',[tt_tot(1) tt_tot(end)],[deg2rad(maxQ3) deg2rad(maxQ3)],'r--');

% Velocita' completa
figure
plot(tt_tot,Q_dot_tot(1,:),'-','LineWidth',1.6)
grid on
xlim([0 T_tot])
ylim([-2.5 2.5])
xlabel('tempo [s]');
ylabel('Velocità [rad/s]')
title('Giunto 1')
hold on
plot([tt_tot(1) tt_tot(end)], [minQ1_dot minQ1_dot],'r--',[tt_tot(1) tt_tot(end)],[maxQ1_dot maxQ1_dot],'r--');

figure
plot(tt_tot,Q_dot_tot(2,:),'-','LineWidth',1.6)
hold on
plot([tt_tot(1) tt_tot(end)], [minQ2_dot minQ2_dot],'r--',[tt_tot(1) tt_tot(end)],[maxQ2_dot maxQ2_dot],'r--');
grid on
xlim([0 T_tot])
ylim([-0.6 0.6])
xlabel('tempo [s]');
ylabel('Velocità [m/s]')
title('Giunto 2')

figure
plot(tt_tot,Q_dot_tot(3,:),'-','LineWidth',1.6)
grid on
xlim([0 T_tot])
ylim([-3.5 3.5])
xlabel('tempo [s]');
ylabel('Velocità [rad/s]')
title('Giunto 3')
hold on
plot([tt_tot(1) tt_tot(end)], [minQ3_dot minQ3_dot],'r--',[tt_tot(1) tt_tot(end)],[maxQ3_dot maxQ3_dot],'r--');

% Accelerazione completa
figure
plot(tt_tot,Q_dot2_tot(1,:),'-','LineWidth',1.6)
grid on
xlim([0 T_tot])
ylim([-25 25])
xlabel('tempo [s]');
ylabel('Accelerazione [rad/s^2]')
title('Giunto 1')
hold on
plot([tt_tot(1) tt_tot(end)], [minQ1_dot2 minQ1_dot2],'r--',[tt_tot(1) tt_tot(end)],[maxQ1_dot2 maxQ1_dot2],'r--');

figure
plot(tt_tot,Q_dot2_tot(2,:),'-','LineWidth',1.6)
hold on
plot([tt_tot(1) tt_tot(end)], [minQ2_dot2 minQ2_dot2],'r--',[tt_tot(1) tt_tot(end)],[maxQ2_dot2 maxQ2_dot2],'r--');
grid on
xlim([0 T_tot])
ylim([-6 6])
xlabel('tempo [s]');
ylabel('Accelerazione [m/s^2]')
title('Giunto 2')

figure
plot(tt_tot,Q_dot2_tot(3,:),'-','LineWidth',1.6)
grid on
xlim([0 T_tot])
ylim([-35 35])
xlabel('tempo [s]');
ylabel('Accelerazione [rad/s^2]')
title('Giunto 3')
hold on
plot([tt_tot(1) tt_tot(end)], [minQ3_dot2 minQ3_dot2],'r--',[tt_tot(1) tt_tot(end)],[maxQ3_dot2 maxQ3_dot2],'r--')