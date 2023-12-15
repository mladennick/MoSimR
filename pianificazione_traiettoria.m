%% PIANIFICAZIONE DELLA TRAIETTORIA
%{
1. Il manipolatore si trova nel punto P1.
2. Dopo, si muove nel punto P2 con minimo tempo di attuazione (P1-P2).
In questa posizione, l'end-effector afferra il pezzo nel punto
rappresentato dal puntino nero.
    --> Poiche' il manipolatore ha 3 gradi di liberta', ipotesi semplificativa:
        il pezzo mantiene orientamento costante da sé (immaginando che ci 
        sia in mezzo un polso che permette di mantenere l'orientamento del 
        pezzo costante)
L'oggetto deve essere spostato vicino e lucidato da una fresatrice
collocata in una posizione nota. A questo scopo, due facce del pezzo devono
essere fresate, mantenendo velocita' e orientamento costanti (P2-P3, P3-P4,
P4-P5).
    --> Abbiamo mantenuto la velocita' costante attraverso una legge di
    moto a sette tratti (facendo in modo che il tratto di fresatura sia
    quello centrale ad accelerazione nulla), e abbiamo supposto che
    l'orientamento resti costante imponendo una traiettoria rettilinea del
    punto di presa
3. Dopo, il manipolatore muove il pezzo vicino a una fresatrice per sbavare
gli spigoli. Si consideri la lavorazione di due bordi adiacenti. (P5-P6, 
P6-P7, P7-P8, P8-P9, P9-P10, P10-P11, P11-P12, P12-P13, P13-P14, P14-P15).
    --> Supponiamo che la fresatrice sia la stessa.
4. Una volta che la sbavatura è stata completata, il manipolatore riporta
il pezzo alla posizione di presa P2 e ritorna rapidamente in P1 con minimo
tempo di attuazione (P15-P2, P2-P1).
%}

%% Dati

% Pezzo da lavorare
l_pz = 0.1;
h_pz = 0.04;

% Fresatrice
r = 0.05;            
cnt = [2.15; 0];       
height = 2;         
color = [0 0 1];
nSides = 100;   
fresatrice = struct('r',r,'cnt',cnt,'height',height,'color',color,'nSides',nSides);

% Punti di calcolo
n = 100;

% Condizioni iniziali e finali di velocita' e accelerazione (valgono sia
% nello spazio di lavoro, sia nello spazio dei giunti)
v0 = [0 0 0];
vf = [0 0 0];
a0 = [0 0 0];
af = [0 0 0];

% Punti noti della traiettoria

% Spazio di lavoro fresatura
S_p1 = [1.7500 0.3000 0];
S_p2 = [1.6475 -0.9223 0];
S_p3 = [2 0 0.05];
S_p4 = [2 0 -0.05-0.1];
S_p5 = [2.2  0 -0.05-0.1];
S_p6 = [2.2  0 -0.05-0.2];
S_p7 = [1.9 0 -0.05-0.2];

% Spazio dei giunti fresatura
Q_p1 = cinematica_inversa_NR2(S_p1,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p2 = cinematica_inversa_NR2(S_p2,[0 0 pi],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p3 = cinematica_inversa_NR2(S_p3,[0 0 pi],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p4 = cinematica_inversa_NR2(S_p4,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p4_1 = cinematica_inversa_NR2(S_p4,[0 0 pi],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p5 = cinematica_inversa_NR2(S_p5,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p6 = cinematica_inversa_NR2(S_p6,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p7 = cinematica_inversa_NR2(S_p7,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);


% Punti ausiliari per la definizione della traiettoria di sbavatura
Q = [2.15-r*sqrt(2),0,0]; % rosa
V = [Q(1)-l_pz*sqrt(2)/4,0,l_pz*sqrt(2)/4]; % verde
% R = [Q(1)+r*sqrt(2),0,r*sqrt(2)]; % azzurro
X = Q+[r*sqrt(2),0,-r*sqrt(2)]; % viola
W = V+[l_pz/2+r*sqrt(2),0,-l_pz/2-r*sqrt(2)]; % arancione
Y = X+[r-0.05*r,0,r-0.05*r]; %grigio

% Spazio di lavoro sbavatura
S_p8 = [Q(1)-l_pz*sqrt(2)/4-l_pz,0,-l_pz*sqrt(2)/4];
S_p9 = [Q(1)+r*sqrt(2)-l_pz,0,r*sqrt(2)];
S_p10 = [Q(1)+r*sqrt(2)-l_pz,0,r*sqrt(2)+r];
S_p11 = V+[-l_pz,0,-l_pz];
S_p12 = W+[-l_pz,0,-l_pz];
S_p13 = X+[0,0,-l_pz];
S_p14 = Y+[0,0,-l_pz];
% S_p15 = S_p14+[-l_pz,0,-l_pz];
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


% Analisi delle fasi del moto: calcolo della traiettoria nello spazio dei
% giunti/di lavoro, grafico di posizione, velocita' e accelerazione dei
% giunti con verifica dei limiti di velocita' e accelerazione massimi,
% grafico del robot in posizione iniziale e finale e della traiettoria
% nello spazio di lavoro.
%% FASE ZERO - INIZIO MONDO 

T_z = 5;
dT_z = T_z/(n-1);
tt_z = 0:dT_z:T_z;

Q_z = zeros(3,n);
Q_dot_z = zeros(3,n);
Q_dot2_z = zeros(3,n);

for i=1:n
    [x_z(i),y_z(i),z_z(i)] = cinematica_diretta(Q_z(1,i),Q_z(2,i),Q_z(3,i),L);
end
%% 1) Moto da P1 a P2: il robot afferra l'oggetto
% Minimo tempo di attuazione: legge di moto a sette tratti
% 
% k1=0.1;
% k2=1;
% k3=0.1;
% k4=11.6;  
% k5=0.1;
% k6=1;
% k7=0.1;

k1=0.5; 
k2=10;
k3=0.5;
k4=78;  
k5=0.5;
k6=10;
k7=0.5;

T_p = 1.412; % Tempo minimo azionamento P1-P2 (7 tratti)
dT_p = T_p/(n-1);
tt_p = 0:dT_p:T_p;

L1=k1*T_p/(k1+k2+k3+k4+k5+k6+k7);
L2=k2*T_p/(k1+k2+k3+k4+k5+k6+k7);
L3=k3*T_p/(k1+k2+k3+k4+k5+k6+k7);
L4=k4*T_p/(k1+k2+k3+k4+k5+k6+k7);
L5=k5*T_p/(k1+k2+k3+k4+k5+k6+k7);
L6=k6*T_p/(k1+k2+k3+k4+k5+k6+k7);
L7=k7*T_p/(k1+k2+k3+k4+k5+k6+k7);

dQ_p = Q_p2-Q_p1;

[sc_q1,vc_q1,A_q1,D_q1] = settetratti_generica_coeff(T_p,Q_p1(1),dQ_p(1),v0(1),vf(1),a0(1),af(1),L1,L2,L3,L4,L5,L6,L7);
[sc_q2,vc_q2,A_q2,D_q2] = settetratti_generica_coeff(T_p,Q_p1(2),dQ_p(2),v0(2),vf(2),a0(2),af(2),L1,L2,L3,L4,L5,L6,L7);
[sc_q3,vc_q3,A_q3,D_q3] = settetratti_generica_coeff(T_p,Q_p1(3),dQ_p(3),v0(3),vf(3),a0(3),af(3),L1,L2,L3,L4,L5,L6,L7);

for i=1:n
    t=tt_p(i);
    [q1_p(i),q1dot_p(i),q1dot2_p(i)] = settetratti_generica(t,T_p,Q_p1(1),dQ_p(1),v0(1),vf(1),a0(1),af(1),L1,L2,L3,L4,L5,L6,L7,sc_q1,vc_q1,A_q1,D_q1);
    [q2_p(i),q2dot_p(i),q2dot2_p(i)] = settetratti_generica(t,T_p,Q_p1(2),dQ_p(2),v0(2),vf(2),a0(2),af(2),L1,L2,L3,L4,L5,L6,L7,sc_q2,vc_q2,A_q2,D_q2);
    [q3_p(i),q3dot_p(i),q3dot2_p(i)] = settetratti_generica(t,T_p,Q_p1(3),dQ_p(3),v0(3),vf(3),a0(3),af(3),L1,L2,L3,L4,L5,L6,L7,sc_q3,vc_q3,A_q3,D_q3);
end

Q_p(1,:) = q1_p(:);
Q_p(2,:) = q2_p(:);
Q_p(3,:) = q3_p(:);

Q_dot_p(1,:) = q1dot_p(:);
Q_dot_p(2,:) = q2dot_p(:);
Q_dot_p(3,:) = q3dot_p(:);

Q_dot2_p(1,:) = q1dot2_p(:);
Q_dot2_p(2,:) = q2dot2_p(:);
Q_dot2_p(3,:) = q3dot2_p(:);

for i=1:n
    [x_p(i),y_p(i),z_p(i)] = cinematica_diretta(q1_p(i),q2_p(i),q3_p(i),L);
end

% % Debug: valutazione della velocita' derivando numericamente posizione
% for i = 1:3
%     Q_dot_p_debug(i,:) = diff(Q_p(i,:))/dT; 
%     Q_dot2_p_debug(i,:) = diff(Q_dot_p(i,:))/dT; 
% end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% plot_traiettoria_ws(Q_p1,Q_p2,L,fresatrice,x_p,y_p,z_p,1,'P1-P2: presa del pezzo',false,true,true)
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot posizione, velocita' e accelerazione dei giunti
plot_traiettoria_giunto(1,'r',q1_p,q1dot_p,q1dot2_p,tt_p,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
plot_traiettoria_giunto(2,'p',q2_p,q2dot_p,q2dot2_p,tt_p,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
plot_traiettoria_giunto(3,'r',q3_p,q3dot_p,q3dot2_p,tt_p,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)
% 
% % crea_subFigure_traiettoria(Q_p1,Q_p2,L,fresatrice,x_p,y_p,z_p,1,false,true)
% crea_subFigure_traiettoria_ws(Q_p1,Q_p2,L,fresatrice,x_p,y_p,z_p,1.5,false,true)
% % 
% % plot_traiettoria_giunto(1,'r',q1_p(1:end-1),Q_dot_p_debug(1,:),Q_dot2_p_debug(1,:),tt_p(1:end-1),[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
%% 2) Moto da P2 a P3: il robot si porta in prossimita' della fresatrice
% Moto con traiettoria rettilinea, legge cicloidale

T_0 = 4;
dT_0 = T_0/(n-1);
tt_0 = 0:dT_0:T_0;

[x0,y0,z0,v0_x,v0_y,v0_z,a0_x,a0_y,a0_z] = traiettoria_rett_cicl(S_p2,S_p3,T_0,n);

% [Q_0, Q_dot_0, Q_dot2_0] = cin_inv_traiettoria([x0;y0;z0],[v0_x;v0_y;v0_z],[a0_x;a0_y;a0_z],J,J_dot,Q_p2,L,[minQ1 minQ2],[maxQ1 maxQ2]);

% Caricamento posizione, velocita', accelerazione dei giunti 
% precedentemente calcolati e salvati
Q_0 = load('dati/Q_0.mat');
Q_0 = Q_0.Q_0;
Q_dot_0 =  load('dati/Q_dot_0.mat');
Q_dot_0 = Q_dot_0.Q_dot_0;
Q_dot2_0 =  load('dati/Q_dot2_0.mat');
Q_dot2_0 = Q_dot2_0.Q_dot2_0;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% plot_traiettoria_ws(Q_p2,Q_p3,L,fresatrice,x0,y0,z0,1,'Moto P2-P3: avvicinamento alla fresatrice',true,true,true)
% plot_traiettoria_ws(Q_0(:,1),Q_0(:,end),L,fresatrice,x0,y0,z0,1,'Moto P2-P3: avvicinamento alla fresatrice',true,true,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita' e accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',Q_0(1,:),Q_dot_0(1,:),Q_dot2_0(1,:),tt_0,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_0(2,:),Q_dot_0(2,:),Q_dot2_0(2,:),tt_0,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_0(3,:),Q_dot_0(3,:),Q_dot2_0(3,:),tt_0,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot interattivo della posizione del robot in alcuni punti intermedi
% % della traiettoria 

% figure  
% for i = 1:20:n
%     grid on
%     xlabel('x');
%     ylabel('z');
%     zlabel('y');
%     hold on
%     plotRPR_cubo(Q_0(:,i),L,'r')     
%     plotCylinderWithCaps(r,cnt,height,nSides,color)
%     plotCylinderWithCaps(r,cnt,-r,nSides,color)
%     xlim([-2 3])
%     ylim([-2 3])
%     zlim([-2 3])
%     plot3(x0,z0,y0,'k')
%     title('Moto P2-P3: posizionamento iniziale')
% end

% crea_subFigure_traiettoria(Q_p2,Q_p3,L,fresatrice,x0,y0,z0,1,true,true)

%% Parte per verificare dove avvenga effettiva fresatura
% 
% % Lato 1
% Sf_p3 = [2 0 0];
% Sf_p4 = [2 0 -0.1];
% 
% Qf_p3 = cinematica_inversa_NR2(Sf_p3,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
% Qf_p4 = cinematica_inversa_NR2(Sf_p4,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
% 
% figure  
% grid on
% xlabel('x');
% ylabel('z');
% zlabel('y');
% hold on
% plotRPR_cubo(Qf_p3,L,'r')     
% plotRPR_cubo(Qf_p4,L,'g') 
% plotCylinderWithCaps(r,cnt,height,nSides,color)
% plotCylinderWithCaps(r,cnt,-r,nSides,color)
% xlim([-2 3])
% ylim([-2 3])
% zlim([-2 3])
% title('Fresatura effettiva lato 1')
% hold off
% 
% % Lato 2
% Sf1_p4 = [2.05 0 -0.05-0.1];
% Sf_p5 = [2.15  0 -0.05-0.1];
% 
% Qf1_p4 = cinematica_inversa_NR2(Sf1_p4,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
% Qf_p5 = cinematica_inversa_NR2(Sf_p5,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
% 
% figure  
% grid on
% xlabel('x');
% ylabel('z');
% zlabel('y');
% hold on
% plotRPR_cubo(Qf1_p4,L,'r')     
% plotRPR_cubo(Qf_p5,L,'g') 
% plotCylinderWithCaps(r,cnt,height,nSides,color)
% plotCylinderWithCaps(r,cnt,-r,nSides,color)
% xlim([-2 3])
% ylim([-2 3])
% zlim([-2 3])
% title('Fresatura effettiva lato 2')
% hold off

%% 3) Moto da P3 a P4: fresatura lato 1 
% Traiettoria rettilinea, legge di moto sette tratti nello spazio di lavoro
% con velocita' costante nel tratto di fresatura

n = 100;
T_1 = 5;
dT_1 = T_1/(n-1);
tt_1 = 0:dT_1:T_1;

K1 = [0.01,5,0.01,4.2947,0.01,5,0.01];
[x1,y1,z1,v1_x,v1_y,v1_z,a1_x,a1_y,a1_z] = traiett_rett_7tratti(S_p3,S_p4,T_1,n,v0,vf,a0,af,K1);

% [Q_1, Q_dot_1, Q_dot2_1] = cin_inv_traiettoria([x1;y1;z1],[v1_x;v1_y;v1_z],[a1_x;a1_y;a1_z],J,J_dot,Q_p3,L,[minQ1 minQ2],[maxQ1 maxQ2]);

% Caricamento posizione, velocita', accelerazione dei giunti 
% precedentemente calcolati e salvati
Q_1 = load('dati/Q_1.mat');
Q_1 = Q_1.Q_1;
Q_dot_1 =  load('dati/Q_dot_1.mat');
Q_dot_1 = Q_dot_1.Q_dot_1;
Q_dot2_1 =  load('dati/Q_dot2_1.mat');
Q_dot2_1 = Q_dot2_1.Q_dot2_1;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% plot_traiettoria_ws(Q_p3,Q_p4,L,fresatrice,x1,y1,z1,1,'Moto P3-P4: lucidatura lato 1',true,true,true)
% plot_traiettoria_ws(Q_1(:,1),Q_1(:,end),L,fresatrice,x1,y1,z1,1,'Moto P3-P4: lucidatura lato 1',true,true,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita' e accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',Q_1(1,:),Q_dot_1(1,:),Q_dot2_1(1,:),tt_1,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_1(2,:),Q_dot_1(2,:),Q_dot2_1(2,:),tt_1,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_1(3,:),Q_dot_1(3,:),Q_dot2_1(3,:),tt_1,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)
% 

% Calcoli e grafici per determinare le caratteristiche della legge di moto
% affinché il tratto di fresatura sia a velocita' costante
% 
% t1 = 1.766; %inizio velocita' costante
% t2 = 3.234; %fine velocita' costante 
% 
% figure
% subplot(3,1,1)
% plot(tt_1,z1)
% hold on
% plot([tt_1(1) tt_1(end)], [0 0],[tt_1(1) tt_1(end)],[-0.1 -0.1])
% ylabel('position [m]')
% xlabel('time [s]')
% subplot(3,1,2)
% plot(tt_1,v1_z)
% hold on
% plot([t1 t1], [-0.1 0.1],[t2 t2], [-0.1 0.1])
% ylabel('velocita (m/s)')
% xlabel('time [s]')
% subplot(3,1,3)
% plot(tt_1,a1_z)
% hold on
% plot([t1 t1], [-0.05 0.05],[t2 t2], [-0.05 0.05])
% ylabel('acceleration [m/s^2]')
% xlabel('time [s]')
% sgtitle('Moto asse z')

% Calcolo percentuale durata tratto ad accelerazione nulla
% 1.4680:5 = x:100 --> x = 1.4980*100/5 = 29.96%
% Ricaviamo: L4 = 0.2996*T_1 = 1.4980
% L4 = k4*T/(sommaK) --> ... k4 = L4*(sommaK-k4)/(T-L4) =
%                                 1.4980*10.04/(5-1.4980)= 4.2947

% crea_subFigure_traiettoria(Q_p3,Q_p4,L,fresatrice,x1,y1,z1,1,true,true)

%% 4) Cambio configurazione in P4
% Si inverte la configurazione del robot per evitare collisioni

T_1_1 = 4;
dT_1_1 = T_1_1/(n-1);
tt_1_1 = 0:dT_1_1:T_1_1;


% [Q_1_1(1,:),Q_1_1(2,:),Q_1_1(3,:),Q_dot_1_1(1,:),Q_dot_1_1(2,:),Q_dot_1_1(3,:),Q_dot2_1_1(1,:),Q_dot2_1_1(2,:),Q_dot2_1_1(3,:)] = traiettoria_rett_cicl(Q_p4_1,Q_p4,T_1_1,n);

% Caricamento posizione, velocita', accelerazione dei giunti 
% precedentemente calcolati e salvati
Q_1_1 = load('dati/Q_1_1.mat');
Q_1_1 = Q_1_1.Q_1_1;
Q_dot_1_1 =  load('dati/Q_dot_1_1.mat');
Q_dot_1_1 = Q_dot_1_1.Q_dot_1_1;
Q_dot2_1_1=  load('dati/Q_dot2_1_1.mat');
Q_dot2_1_1 = Q_dot2_1_1.Q_dot2_1_1;

for i=1:n
    [x1_1(i),y1_1(i),z1_1(i)] = cinematica_diretta(Q_1_1(1,i),Q_1_1(2,i),Q_1_1(3,i),L);
end

plot_traiettoria_ws(Q_p4_1,Q_p4,L,fresatrice,S_p4(1),S_p4(2),S_p4(3),1,'Cambio configurazione',true,true,true)
% 
% plot_traiettoria_giunto(1,'r',Q_1_1(1,:),Q_dot_1_1(1,:),Q_dot2_1_1(1,:),tt_1_1,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_1_1(2,:),Q_dot_1_1(2,:),Q_dot2_1_1(2,:),tt_1_1,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_1_1(3,:),Q_dot_1_1(3,:),Q_dot2_1_1(3,:),tt_1_1,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

%% 5) Moto da P4 a P5: fresatura lato 2
% Traiettoria rettilinea, legge di moto sette tratti nello spazio di lavoro
% con velocita' costante nel tratto di fresatura

T_2 = 5;
dT_2 = T_2/(n-1);
tt_2 = 0:dT_2:T_2;

K2 = [0.01,5,0.01,5.0623,0.01,5,0.01];

[x2,y2,z2,v2_x,v2_y,v2_z,a2_x,a2_y,a2_z] = traiett_rett_7tratti(S_p4,S_p5,T_2,n,v0,vf,a0,af,K2);

% [Q_2, Q_dot_2, Q_dot2_2] = cin_inv_traiettoria([x2;y2;z2],[v2_x;v2_y;v2_z],[a2_x;a2_y;a2_z],J,J_dot,Q_p4,L,[minQ1 minQ2],[maxQ1 maxQ2]);

% % Caricamento posizione, velocita', accelerazione dei giunti 
% % precedentemente calcolati e salvati
Q_2 = load('dati/Q_2.mat');
Q_2 = Q_2.Q_2;
Q_dot_2 =  load('dati/Q_dot_2.mat');
Q_dot_2 = Q_dot_2.Q_dot_2;
Q_dot2_2=  load('dati/Q_dot2_2.mat');
Q_dot2_2 = Q_dot2_2.Q_dot2_2;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% % plot_traiettoria_ws(Q_p4,Q_p5,L,fresatrice,x2,y2,z2,1,'Moto P4-P5: lucidatura lato 2',true,true,true)
% plot_traiettoria_ws(Q_2(:,1),Q_2(:,end),L,fresatrice,x2,y2,z2,1,'Moto P4-P5: lucidatura lato 2',true,true,true)
% 
% % % Interferenza
% % Q_2_int = [0.1937,0.1684; 0.2248, 0.4281; 3.6652 3.6652];
% % plot_traiettoria_ws(Q_2_int(:,1),Q_2_int(:,end),L,fresatrice,x2,y2,z2,1,'Moto P4-P5: lucidatura lato 2',true,true,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita' e accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',Q_2(1,:),Q_dot_2(1,:),Q_dot2_2(1,:),tt_2,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_2(2,:),Q_dot_2(2,:),Q_dot2_2(2,:),tt_2,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_2(3,:),Q_dot_2(3,:),Q_dot2_2(3,:),tt_2,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)
% 

% Calcoli e grafici per determinare le caratteristiche della legge di moto
% affinché il tratto di fresatura sia a velocita' costante

% t1 = 1.662; %inizio velocita' costante
% t2 = 3.338; %fine velocita' costante 
% 
% figure
% subplot(3,1,1)
% plot(tt_1,x2)
% hold on
% plot([tt_2(1) tt_2(end)], [2.05 2.05],[tt_1(1) tt_1(end)],[2.15 2.15])
% ylabel('position [m]')
% xlabel('time [s]')
% subplot(3,1,2)
% plot(tt_1,v2_x)
% hold on
% plot([t1 t1], [-0.1 0.1],[t2 t2], [-0.1 0.1])
% ylabel('velocita (m/s)')
% xlabel('time [s]')
% subplot(3,1,3)
% plot(tt_1,a2_x)
% hold on
% plot([t1 t1], [-0.05 0.05],[t2 t2], [-0.05 0.05])
% ylabel('acceleration [m/s^2]')
% xlabel('time [s]')
% sgtitle('Moto asse x')

% Calcolo percentuale durata tratto ad accelerazione nulla
% 1.6760:5 = x:100 --> x = 1.6760*100/5 = 33.5200%
% Ricaviamo: L4 = 0.3352*T_2 = 1.6760
% L4 = k4*T/(sommaK) --> ... k4 = L4*(sommaK-k4)/(T-L4) =
%                                 1.6760*10.04/(5-1.6760)= 5.0623

% crea_subFigure_traiettoria(Q_p4,Q_p5,L,fresatrice,x2,y2,z2,1,true,true)

%% 6) Moto da P5 a P6: allontanamento dalla fresatrice per la seconda operazione di sbavatura
% Moto con traiettoria rettilinea, legge cicloidale

T_3 = 1;
dT_3 = T_3/(n-1);
tt_3 = 0:dT_3:T_3;

[x3,y3,z3,v3_x,v3_y,v3_z,a3_x,a3_y,a3_z] = traiettoria_rett_cicl(S_p5,S_p6,T_3,n);


% [Q_3, Q_dot_3, Q_dot2_3] = cin_inv_traiettoria([x3;y3;z3],[v3_x;v3_y;v3_z],[a3_x;a3_y;a3_z],J,J_dot,Q_p5,L,[minQ1 minQ2],[maxQ1 maxQ2]);

% Caricamento posizione, velocita', accelerazione dei giunti 
% precedentemente calcolati e salvati
Q_3 = load('dati/Q_3.mat');
Q_3 = Q_3.Q_3;
Q_dot_3 =  load('dati/Q_dot_3.mat');
Q_dot_3 = Q_dot_3.Q_dot_3;
Q_dot2_3 =  load('dati/Q_dot2_3.mat');
Q_dot2_3 = Q_dot2_3.Q_dot2_3;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% % plot_traiettoria_ws(Q_p5,Q_p6,L,fresatrice,x3,y3,z3,1,'Moto P5-P6: allontanamento dalla fresatrice',true,true,true)
% plot_traiettoria_ws(Q_3(:,1),Q_3(:,end),L,fresatrice,x3,y3,z3,1,'Moto P5-P6: allontanamento dalla fresatrice',true,true,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% % Plot posizione, velocita' e accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',Q_3(1,:),Q_dot_3(1,:),Q_dot2_3(1,:),tt_3,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_3(2,:),Q_dot_3(2,:),Q_dot2_3(2,:),tt_3,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_3(3,:),Q_dot_3(3,:),Q_dot2_3(3,:),tt_3,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

% crea_subFigure_traiettoria(Q_p5,Q_p6,L,fresatrice,x3,y3,z3,1,true,true)
%% 7) Moto da P6 a P7 : traslazione all'indietro per arrivare a P3 senza interferenze
% Moto con traiettoria rettilinea, legge cicloidale

T_4 = 2;
dT_4 = T_4/(n-1);
tt_4 = 0:dT_4:T_4;

[x4,y4,z4,v4_x,v4_y,v4_z,a4_x,a4_y,a4_z] = traiettoria_rett_cicl(S_p6,S_p7,T_4,n);


% [Q_4, Q_dot_4, Q_dot2_4] = cin_inv_traiettoria([x4;y4;z4],[v4_x;v4_y;v4_z],[a4_x;a4_y;a4_z],J,J_dot,Q_p6,L,[minQ1 minQ2],[maxQ1 maxQ2]);

% Caricamento posizione, velocita', accelerazione dei giunti 
% precedentemente calcolati e salvati
Q_4 = load('dati/Q_4.mat');
Q_4 = Q_4.Q_4;
Q_dot_4 =  load('dati/Q_dot_4.mat');
Q_dot_4 = Q_dot_4.Q_dot_4;
Q_dot2_4 =  load('dati/Q_dot2_4.mat');
Q_dot2_4 = Q_dot2_4.Q_dot2_4;


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% % plot_traiettoria_ws(Q_p6,Q_p7,L,fresatrice,x4,y4,z4,1,'Moto P6-P7: allontanamento dalla fresatrice',true,true,true)
% plot_traiettoria_ws(Q_4(:,1),Q_4(:,end),L,fresatrice,x4,y4,z4,1,'Moto P6-P7: allontanamento dalla fresatrice',true,true,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita', accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',Q_4(1,:),Q_dot_4(1,:),Q_dot2_4(1,:),tt_4,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_4(2,:),Q_dot_4(2,:),Q_dot2_4(2,:),tt_4,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_4(3,:),Q_dot_4(3,:),Q_dot2_4(3,:),tt_4,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

% crea_subFigure_traiettoria(Q_p6,Q_p7,L,fresatrice,x4,y4,z4,1,true,true)

%%  8) Moto da P7 a P8: posizionamento per secondo ciclo (sbavatura)
% Moto con traiettoria rettilinea, legge cicloidale

T_5 = 2;
dT_5 = T_5/(n-1);
tt_5 = 0:dT_5:T_5;

[x5,y5,z5,v5_x,v5_y,v5_z,a5_x,a5_y,a5_z] = traiettoria_rett_cicl(S_p7,S_p8,T_5,n);


% [Q_5, Q_dot_5, Q_dot2_5] = cin_inv_traiettoria([x5;y5;z5],[v5_x;v5_y;v5_z],[a5_x;a5_y;a5_z],J,J_dot,Q_p7,L,[minQ1 minQ2],[maxQ1 maxQ2]);

% Caricamento posizione, velocita', accelerazione dei giunti 
% precedentemente calcolati e salvati
Q_5 = load('dati/Q_5.mat');
Q_5 = Q_5.Q_5;
Q_dot_5 =  load('dati/Q_dot_5.mat');
Q_dot_5 = Q_dot_5.Q_dot_5;
Q_dot2_5 =  load('dati/Q_dot2_5.mat');
Q_dot2_5 = Q_dot2_5.Q_dot2_5;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% % plot_traiettoria_ws(Q_p7,Q_p8,L,fresatrice,x5,y5,z5,1,'Moto P7-P3: avvicinamento alla fresatrice',true,true,true)
% plot_traiettoria_ws(Q_5(:,1),Q_5(:,end),L,fresatrice,x5,y5,z5,1,'Moto P7-P3: avvicinamento alla fresatrice',true,true,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita', accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',Q_5(1,:),Q_dot_5(1,:),Q_dot2_5(1,:),tt_5,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_5(2,:),Q_dot_5(2,:),Q_dot2_5(2,:),tt_5,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_5(3,:),Q_dot_5(3,:),Q_dot2_5(3,:),tt_5,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

% crea_subFigure_traiettoria(Q_p7,Q_p8,L,fresatrice,x5,y5,z5,1,true,true)

%% 9) Ciclo sbavatura: moto da P8 a P9: prima sbavatura

% Traiettoria rettilinea, legge di moto sette tratti nello spazio di lavoro
% con velocita' costante nel tratto di fresatura

T_6 = 3;
dT_6 = T_6/(n-1);
tt_6 = 0:dT_6:T_6;

K6 = [0.01,5,0.01,5,0.01,5,0.01];
[x6,y6,z6,v6_x,v6_y,v6_z,a6_x,a6_y,a6_z] = traiett_rett_7tratti(S_p8,S_p9,T_6,n,v0,vf,a0,af,K6);


% [Q_6, Q_dot_6, Q_dot2_6] = cin_inv_traiettoria([x6;y6;z6],[v6_x;v6_y;v6_z],[a6_x;a6_y;a6_z],J,J_dot,Q_p8,L,[minQ1 minQ2],[maxQ1 maxQ2]);

% Caricamento posizione, velocita', accelerazione dei giunti 
% precedentemente calcolati e salvati
Q_6 = load('dati/Q_6.mat');
Q_6 = Q_6.Q_6;
Q_dot_6 =  load('dati/Q_dot_6.mat');
Q_dot_6 = Q_dot_6.Q_dot_6;
Q_dot2_6=  load('dati/Q_dot2_6.mat');
Q_dot2_6 = Q_dot2_6.Q_dot2_6;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% % plot_traiettoria_ws(Q_p8,Q_p9,L,fresatrice,x6,y6,z6,1,'Moto P8-P9: prima sbavatura',true,true,true)
% plot_traiettoria_ws(Q_6(:,1),Q_6(:,end),L,fresatrice,x6,y6,z6,1,'Moto P8-P9: prima sbavatura',true,true,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita', accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',Q_6(1,:),Q_dot_6(1,:),Q_dot2_6(1,:),tt_6,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_6(2,:),Q_dot_6(2,:),Q_dot2_6(2,:),tt_6,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_6(3,:),Q_dot_6(3,:),Q_dot2_6(3,:),tt_6,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

% figure  
% for i = 1:10:n
%     grid on
%     xlabel('x');
%     ylabel('z');
%     zlabel('y');
%     hold on
%     plotRPR_cubo(Q_6(:,i),L,'r')     
%     plotCylinderWithCaps(r,cnt,height,nSides,color)
%     plotCylinderWithCaps(r,cnt,-r,nSides,color)
%     xlim([-2 3])
%     ylim([-2 3])
%     zlim([-2 3])
%     plot3(x6,z6,y6,'k')
%     title('Moto P8-P9: sbavatura 1')
% end

% crea_subFigure_traiettoria(Q_p8,Q_p9,L,fresatrice,x6,y6,z6,1,true,true)

%% 10) Moto da P9 a P10: allontanamento dalla fresatrice
% Moto con traiettoria rettilinea, legge cicloidale

T_7 = 1;
dT_7 = T_7/(n-1);
tt_7 = 0:dT_7:T_7;

[x7,y7,z7,v7_x,v7_y,v7_z,a7_x,a7_y,a7_z] = traiettoria_rett_cicl(S_p9,S_p10,T_7,n);


% [Q_7, Q_dot_7, Q_dot2_7] = cin_inv_traiettoria([x7;y7;z7],[v7_x;v7_y;v7_z],[a7_x;a7_y;a7_z],J,J_dot,Q_p9,L,[minQ1 minQ2],[maxQ1 maxQ2]);

% Caricamento posizione, velocita', accelerazione dei giunti 
% precedentemente calcolati e salvati
Q_7 = load('dati/Q_7.mat');
Q_7 = Q_7.Q_7;
Q_dot_7 =  load('dati/Q_dot_7.mat');
Q_dot_7 = Q_dot_7.Q_dot_7;
Q_dot2_7 =  load('dati/Q_dot2_7.mat');
Q_dot2_7 = Q_dot2_7.Q_dot2_7;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% % plot_traiettoria_ws(Q_p9,Q_p10,L,fresatrice,x7,y7,z7,1,'Moto P9-P10: allontanamento dalla fresatrice',true,true,true)
% plot_traiettoria_ws(Q_7(:,1),Q_7(:,end),L,fresatrice,x7,y7,z7,1,'Moto P9-P10: allontanamento dalla fresatrice',true,true,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita', accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',Q_7(1,:),Q_dot_7(1,:),Q_dot2_7(1,:),tt_7,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_7(2,:),Q_dot_7(2,:),Q_dot2_7(2,:),tt_7,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_7(3,:),Q_dot_7(3,:),Q_dot2_7(3,:),tt_7,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

% crea_subFigure_traiettoria(Q_p9,Q_p10,L,fresatrice,x7,y7,z7,1,true,true)

%% 11) Moto da P10 a P11: posizionamento per seconda sbavatura
% Moto con traiettoria rettilinea, legge cicloidale

T_8 = 2;
dT_8 = T_8/(n-1);
tt_8 = 0:dT_8:T_8;

[x8,y8,z8,v8_x,v8_y,v8_z,a8_x,a8_y,a8_z] = traiettoria_rett_cicl(S_p10,S_p11,T_8,n);


% [Q_8, Q_dot_8, Q_dot2_8] = cin_inv_traiettoria([x8;y8;z8],[v8_x;v8_y;v8_z],[a8_x;a8_y;a8_z],J,J_dot,Q_p10,L,[minQ1 minQ2],[maxQ1 maxQ2]);

% Caricamento posizione, velocita', accelerazione dei giunti 
% precedentemente calcolati e salvati
Q_8 = load('dati/Q_8.mat');
Q_8 = Q_8.Q_8;
Q_dot_8 =  load('dati/Q_dot_8.mat');
Q_dot_8 = Q_dot_8.Q_dot_8;
Q_dot2_8 =  load('dati/Q_dot2_8.mat');
Q_dot2_8 = Q_dot2_8.Q_dot2_8;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% % plot_traiettoria_ws(Q_p10,Q_p11,L,fresatrice,x8,y8,z8,1,'Moto P10 a P11: posizionamento per seconda sbavatura',true,true,true)
% plot_traiettoria_ws(Q_8(:,1),Q_8(:,end),L,fresatrice,x8,y8,z8,1,'Moto P10 a P11: posizionamento per seconda sbavatura',true,true,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita', accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',Q_8(1,:),Q_dot_8(1,:),Q_dot2_8(1,:),tt_8,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_8(2,:),Q_dot_8(2,:),Q_dot2_8(2,:),tt_8,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_8(3,:),Q_dot_8(3,:),Q_dot2_8(3,:),tt_8,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

% crea_subFigure_traiettoria(Q_p10,Q_p11,L,fresatrice,x8,y8,z8,1,true,true)

%% 12) Moto da P11 a P12: seconda sbavatura
% Traiettoria rettilinea, legge di moto sette tratti nello spazio di lavoro
% con velocita' costante nel tratto di fresatura

T_9 = 3;
dT_9 = T_9/(n-1);
tt_9 = 0:dT_9:T_9;

K9 = [0.01,5,0.01,5,0.01,5,0.01];

[x9,y9,z9,v9_x,v9_y,v9_z,a9_x,a9_y,a9_z] = traiett_rett_7tratti(S_p11,S_p12,T_9,n,v0,vf,a0,af,K9);

% [Q_9, Q_dot_9, Q_dot2_9] = cin_inv_traiettoria([x9;y9;z9],[v9_x;v9_y;v9_z],[a9_x;a9_y;a9_z],J,J_dot,Q_p11,L,[minQ1 minQ2],[maxQ1 maxQ2]);

% Caricamento posizione, velocita', accelerazione dei giunti 
% precedentemente calcolati e salvati
Q_9 = load('dati/Q_9.mat');
Q_9 = Q_9.Q_9;
Q_dot_9 =  load('dati/Q_dot_9.mat');
Q_dot_9 = Q_dot_9.Q_dot_9;
Q_dot2_9 =  load('dati/Q_dot2_9.mat');
Q_dot2_9 = Q_dot2_9.Q_dot2_9;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% % plot_traiettoria_ws(Q_p11,Q_p12,L,fresatrice,x9,y9,z9,1,'Moto P11-P12: seconda sbavatura',true,true,true)
% plot_traiettoria_ws(Q_9(:,1),Q_9(:,end),L,fresatrice,x9,y9,z9,1,'Moto P11-P12: seconda sbavatura',true,true,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita', accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',Q_9(1,:),Q_dot_9(1,:),Q_dot2_9(1,:),tt_9,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_9(2,:),Q_dot_9(2,:),Q_dot2_9(2,:),tt_9,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_9(3,:),Q_dot_9(3,:),Q_dot2_9(3,:),tt_9,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)


% figure  
% for i = 1:10:n
%     grid on
%     xlabel('x');
%     ylabel('z');
%     zlabel('y');
%     hold on
%     plotRPR_cubo(Q_9(:,i),L,'r')     
%     plotCylinderWithCaps(r,cnt,height,nSides,color)
%     plotCylinderWithCaps(r,cnt,-r,nSides,color)
%     xlim([-2 3])
%     ylim([-2 3])
%     zlim([-2 3])
%     plot3(x9,z9,y9,'k')
%     title('Moto P11-P12 sbavatura 2')
% end

% crea_subFigure_traiettoria(Q_p11,Q_p12,L,fresatrice,x9,y9,z9,1,true,true)

%% 13) Moto da P12 a P13 : posizionamento terza sbavatura

T_10 = 1;
dT_10 = T_10/(n-1);
tt_10 = 0:dT_10:T_10;

[x10,y10,z10,v10_x,v10_y,v10_z,a10_x,a10_y,a10_z] = traiettoria_rett_cicl(S_p12,S_p13,T_10,n);


% [Q_10, Q_dot_10, Q_dot2_10] = cin_inv_traiettoria([x10;y10;z10],[v10_x;v10_y;v10_z],[a10_x;a10_y;a10_z],J,J_dot,Q_p12,L,[minQ1 minQ2],[maxQ1 maxQ2]);

% Caricamento posizione, velocita', accelerazione dei giunti 
% precedentemente calcolati e salvati
Q_10 = load('dati/Q_10.mat');
Q_10 = Q_10.Q_10;
Q_dot_10 =  load('dati/Q_dot_10.mat');
Q_dot_10 = Q_dot_10.Q_dot_10;
Q_dot2_10 =  load('dati/Q_dot2_10.mat');
Q_dot2_10 = Q_dot2_10.Q_dot2_10;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% % plot_traiettoria_ws(Q_p12,Q_p13,L,fresatrice,x10,y10,z10,1,'Moto P12 a P13: posizionamento per terza sbavatura',true,true,true)
% plot_traiettoria_ws(Q_10(:,1),Q_10(:,end),L,fresatrice,x10,y10,z10,1,'Moto P12 a P13: posizionamento per terza sbavatura',true,true,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita', accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',Q_10(1,:),Q_dot_10(1,:),Q_dot2_10(1,:),tt_10,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_10(2,:),Q_dot_10(2,:),Q_dot2_10(2,:),tt_10,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_10(3,:),Q_dot_10(3,:),Q_dot2_10(3,:),tt_10,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

% crea_subFigure_traiettoria(Q_p12,Q_p13,L,fresatrice,x10,y10,z10,1,true,true)

%% 14) Moto da P13 a P14: terza sbavatura

T_11 = 3;
dT_11 = T_11/(n-1);
tt_11 = 0:dT_11:T_11;

K11 = [0.01,5,0.01,15,0.01,5,0.01];

[x11,y11,z11,v11_x,v11_y,v11_z,a11_x,a11_y,a11_z] = traiett_rett_7tratti(S_p13,S_p14,T_11,n,v0,vf,a0,af,K11);


% [Q_11, Q_dot_11, Q_dot2_11] = cin_inv_traiettoria([x11;y11;z11],[v11_x;v11_y;v11_z],[a11_x;a11_y;a11_z],J,J_dot,Q_p13,L,[minQ1 minQ2],[maxQ1 maxQ2]);

% Caricamento posizione, velocita', accelerazione dei giunti 
% precedentemente calcolati e salvati
Q_11 = load('dati/Q_11.mat');
Q_11 = Q_11.Q_11;
Q_dot_11 =  load('dati/Q_dot_11.mat');
Q_dot_11 = Q_dot_11.Q_dot_11;
Q_dot2_11 =  load('dati/Q_dot2_11.mat');
Q_dot2_11 = Q_dot2_11.Q_dot2_11;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% % plot_traiettoria_ws(Q_p13,Q_p14,L,fresatrice,x11,y11,z11,1,'Moto P13-P14: terza sbavatura',true,true,true)
% plot_traiettoria_ws(Q_11(:,1),Q_11(:,end),L,fresatrice,x11,y11,z11,1,'Moto P13-P14: terza sbavatura',true,true,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita', accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',Q_11(1,:),Q_dot_11(1,:),Q_dot2_11(1,:),tt_11,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_11(2,:),Q_dot_11(2,:),Q_dot2_11(2,:),tt_11,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_11(3,:),Q_dot_11(3,:),Q_dot2_11(3,:),tt_11,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)


% figure  
% for i = 1:10:n
%     grid on
%     xlabel('x');
%     ylabel('z');
%     zlabel('y');
%     hold on
%     plotRPR_cubo(Q_11(:,i),L,'r')     
%     plotCylinderWithCaps(r,cnt,height,nSides,color)
%     plotCylinderWithCaps(r,cnt,-r,nSides,color)
%     xlim([-2 3])
%     ylim([-2 3])
%     zlim([-2 3])
%     plot3(x11,z11,y11,'k')
%     title('Moto P13-P14: sbavatura 3')
% end

crea_subFigure_traiettoria(Q_p13,Q_p14,L,fresatrice,x11,y11,z11,1,true,true)


%% 15) Moto da P14 a P15: allontanamento dalla fresatrice

T_12 = 1;
dT_12 = T_12/(n-1);
tt_12 = [0:dT_12:T_12];

[x12,y12,z12,v12_x,v12_y,v12_z,a12_x,a12_y,a12_z] = traiettoria_rett_cicl(S_p14,S_p15,T_12,n);


% [Q_12, Q_dot_12, Q_dot2_12] = cin_inv_traiettoria([x12;y12;z12],[v12_x;v12_y;v12_z],[a12_x;a12_y;a12_z],J,J_dot,Q_p14,L,[minQ1 minQ2],[maxQ1 maxQ2]);

% Caricamento posizione, velocita', accelerazione dei giunti 
% precedentemente calcolati e salvati
Q_12 = load('dati/Q_12.mat');
Q_12 = Q_12.Q_12;
Q_dot_12 =  load('dati/Q_dot_12.mat');
Q_dot_12 = Q_dot_12.Q_dot_12;
Q_dot2_12 =  load('dati/Q_dot2_12.mat');
Q_dot2_12 = Q_dot2_12.Q_dot2_12;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% % plot_traiettoria_ws(Q_p14,Q_p15,L,fresatrice,x12,y12,z12,1,'Moto P14 a P15: allontanamento dalla fresatrice',true,true,true)
% plot_traiettoria_ws(Q_12(:,1),Q_12(:,end),L,fresatrice,x12,y12,z12,1,'Moto P14 a P15: allontanamento dalla fresatrice',true,true,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita', accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',Q_12(1,:),Q_dot_12(1,:),Q_dot2_12(1,:),tt_12,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_12(2,:),Q_dot_12(2,:),Q_dot2_12(2,:),tt_12,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_12(3,:),Q_dot_12(3,:),Q_dot2_12(3,:),tt_12,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

crea_subFigure_traiettoria(Q_p14,Q_p15,L,fresatrice,x12,y12,z12,1,true,true)

%% 16) Cambio configurazione in P15
% Si inverte la configurazione del robot per evitare collisioni

T_12_1 = 5;
dT_12_1 = T_12_1/(n-1);
tt_12_1 = [0:dT_12_1:T_12_1];

[Q_12_1(1,:),Q_12_1(2,:),Q_12_1(3,:),Q_dot_12_1(1,:),Q_dot_12_1(2,:),Q_dot_12_1(3,:),Q_dot2_12_1(1,:),Q_dot2_12_1(2,:),Q_dot2_12_1(3,:)] = traiettoria_rett_cicl(Q_p15,Q_p15_1,T_12_1,n);

for i=1:n
    [x12_1(i),y12_1(i),z12_1(i)] = cinematica_diretta(Q_12_1(1,i),Q_12_1(2,i),Q_12_1(3,i),L);
end

% plot_traiettoria_ws(Q_p15,Q_p15_1,L,fresatrice,S_p15(1),S_p15(2),S_p15(3),1,'Cambio configurazione',true,true,true)
% 
% plot_traiettoria_giunto(1,'r',Q_12_1(1,:),Q_dot_12_1(1,:),Q_dot2_12_1(1,:),tt_12_1,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_12_1(2,:),Q_dot_12_1(2,:),Q_dot2_12_1(2,:),tt_12_1,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_12_1(3,:),Q_dot_12_1(3,:),Q_dot2_12_1(3,:),tt_12_1,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)


%% 17) Moto da P15 a P2: rilascio del pezzo
% Legge di moto cicloidale

T_r = 3;
dT_r = T_r/(n-1);
tt_r = 0:dT_r:T_r;

[xr,yr,zr,vr_x,vr_y,vr_z,ar_x,ar_y,ar_z] = traiettoria_rett_cicl(S_p15,S_p2,T_r,n);

% [Q_r, Q_dot_r, Q_dot2_r] = cin_inv_traiettoria_2([xr;yr;zr],[vr_x;vr_y;vr_z],[ar_x;ar_y;ar_z],J,J_dot,Q_p2,L,[minQ1 minQ2],[maxQ1 maxQ2]);

% Caricamento posizione, velocita', accelerazione dei giunti 
% precedentemente calcolati e salvati
Q_r = load('dati/Q_r.mat');
Q_r = Q_r.Q_r;
Q_dot_r =  load('dati/Q_dot_r.mat');
Q_dot_r = Q_dot_r.Q_dot_r;
Q_dot2_r =  load('dati/Q_dot2_r.mat');
Q_dot2_r= Q_dot2_r.Q_dot2_r;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% % plot_traiettoria_ws(Q_p15_1,Q_p2,L,fresatrice,xr,yr,zr,1,'Moto P14 a P15: rilascio del pezzo',true,true,true)
% plot_traiettoria_ws(Q_r(:,1),Q_r(:,end),L,fresatrice,xr,yr,zr,1,'Moto P14 a P15: rilascio del pezzo',true,true,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita', accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',Q_r(1,:),Q_dot_r(1,:),Q_dot2_r(1,:),tt_r,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',Q_r(2,:),Q_dot_r(2,:),Q_dot2_r(2,:),tt_r,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',Q_r(3,:),Q_dot_r(3,:),Q_dot2_r(3,:),tt_r,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

crea_subFigure_traiettoria(Q_p15_1,Q_p2,L,fresatrice,xr,yr,zr,1,true,true)

%% 18) Moto da P2 a P1: il robot torna in posizione di riposo
% Minimo tempo di attuazione, legge di moto sette tratti

k1=0.5; 
k2=10;
k3=0.5;
k4=78;  
k5=0.5;
k6=10;
k7=0.5;

T_f = 1.412;
dT_f = T_f/(n-1);
tt_f = 0:dT_f:T_f;

L1=k1*T_f/(k1+k2+k3+k4+k5+k6+k7);
L2=k2*T_f/(k1+k2+k3+k4+k5+k6+k7);
L3=k3*T_f/(k1+k2+k3+k4+k5+k6+k7);
L4=k4*T_f/(k1+k2+k3+k4+k5+k6+k7);
L5=k5*T_f/(k1+k2+k3+k4+k5+k6+k7);
L6=k6*T_f/(k1+k2+k3+k4+k5+k6+k7);
L7=k7*T_f/(k1+k2+k3+k4+k5+k6+k7);

dQ_f = Q_p1-Q_p2;

[sc_q1,vc_q1,A_q1,D_q1] = settetratti_generica_coeff(T_f,Q_p2(1),dQ_f(1),v0(1),vf(1),a0(1),af(1),L1,L2,L3,L4,L5,L6,L7);
[sc_q2,vc_q2,A_q2,D_q2] = settetratti_generica_coeff(T_f,Q_p2(2),dQ_f(2),v0(2),vf(2),a0(2),af(2),L1,L2,L3,L4,L5,L6,L7);
[sc_q3,vc_q3,A_q3,D_q3] = settetratti_generica_coeff(T_f,Q_p2(3),dQ_f(3),v0(3),vf(3),a0(3),af(3),L1,L2,L3,L4,L5,L6,L7);

for i=1:n
    t=tt_f(i);
    [q1_f(i),q1dot_f(i),q1dot2_f(i)] = settetratti_generica(t,T_f,Q_p2(1),dQ_f(1),v0(1),vf(1),a0(1),af(1),L1,L2,L3,L4,L5,L6,L7,sc_q1,vc_q1,A_q1,D_q1);
    [q2_f(i),q2dot_f(i),q2dot2_f(i)] = settetratti_generica(t,T_f,Q_p2(2),dQ_f(2),v0(2),vf(2),a0(2),af(2),L1,L2,L3,L4,L5,L6,L7,sc_q2,vc_q2,A_q2,D_q2);
    [q3_f(i),q3dot_f(i),q3dot2_f(i)] = settetratti_generica(t,T_f,Q_p2(3),dQ_f(3),v0(3),vf(3),a0(3),af(3),L1,L2,L3,L4,L5,L6,L7,sc_q3,vc_q3,A_q3,D_q3);
end

Q_f(1,:) = q1_f(:);
Q_f(2,:) = q2_f(:);
Q_f(3,:) = q3_f(:);

Q_dot_f(1,:) = q1dot_f(:);
Q_dot_f(2,:) = q2dot_f(:);
Q_dot_f(3,:) = q3dot_f(:);

Q_dot2_f(1,:) = q1dot2_f(:);
Q_dot2_f(2,:) = q2dot2_f(:);
Q_dot2_f(3,:) = q3dot2_f(:);

for i=1:n
    [x_f(i),y_f(i),z_f(i)] = cinematica_diretta(q1_f(i),q2_f(i),q3_f(i),L);
end


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot traiettoria nello spazio di lavoro
% plot_traiettoria_ws(Q_p2,Q_p1,L,fresatrice,x_f,y_f,z_f,1,'P2-P1: ritorno in posizione iniziale P1',true,false,true)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Plot posizione, velocita', accelerazione dei giunti
% plot_traiettoria_giunto(1,'r',q1_f,q1dot_f,q1dot2_f,tt_f,[minQ1 maxQ1],[minQ1_dot maxQ1_dot],[minQ1_dot2 maxQ1_dot2],2)
% plot_traiettoria_giunto(2,'p',q2_f,q2dot_f,q2dot2_f,tt_f,[minQ2 maxQ2],[minQ2_dot maxQ2_dot],[minQ2_dot2 maxQ2_dot2],2)
% plot_traiettoria_giunto(3,'r',q3_f,q3dot_f,q3dot2_f,tt_f,[minQ3 maxQ3],[minQ3_dot maxQ3_dot],[minQ3_dot2 maxQ3_dot2],2)

% crea_subFigure_traiettoria(Q_p2,Q_p1,L,fresatrice,x_f,y_f,z_f,1,true,true)

%% FASE RIPOSO 
T_z = 5;
dT_z = T_z/(n-1);
tt_z = 0:dT_z:T_z;

Q_z = zeros(3,n);
Q_dot_z = zeros(3,n);
Q_dot2_z = zeros(3,n);

for i=1:n
    [x_z(i),y_z(i),z_z(i)] = cinematica_diretta(Q_z(1,i),Q_z(2,i),Q_z(3,i),L);
end
%% Concatenazione elementi
tt_concat(1,:) = tt_p;
T_concat(1) = T_p;

tt_concat(2,:) = tt_0;
T_concat(2) = T_0;

tt_concat(3,:) = tt_1;
T_concat(3) = T_1;

tt_concat(4,:) = tt_1_1;
T_concat(4) = T_1_1;

tt_concat(5,:) = tt_2;
T_concat(5) = T_2;

tt_concat(6,:) = tt_3;
T_concat(6) = T_3;

tt_concat(7,:) = tt_4;
T_concat(7) = T_4;

tt_concat(8,:) = tt_5;
T_concat(8) = T_5;

tt_concat(9,:) = tt_6;
T_concat(9) = T_6;

tt_concat(10,:) = tt_7;
T_concat(10) = T_7;

tt_concat(11,:) = tt_8;
T_concat(11) = T_8;

tt_concat(12,:) = tt_9;
T_concat(12) = T_9;

tt_concat(13,:) = tt_10;
T_concat(13) = T_10;

tt_concat(14,:) = tt_11;
T_concat(14) = T_11;

tt_concat(15,:) = tt_12;
T_concat(15) = T_12;

tt_concat(16,:) = tt_12_1;
T_concat(16) = T_12_1;

tt_concat(17,:) = tt_r;
T_concat(17) = T_r;

tt_concat(18,:) = tt_f;
T_concat(18) = T_f;

tt_concat(19,:) = tt_z;
T_concat(19) = T_z;

[T_tot,tt_tot] = concatena(tt_concat,T_concat);

T_tot = T_tot + T_z;
tt_tot = tt_tot + T_z;
tt_tot = [tt_z(1:end-1) tt_tot(1:end)];

Q_tot = [Q_z Q_p(:,2:end) Q_0(:,2:end) Q_1(:,2:end) Q_1_1(:,2:end) Q_2(:,2:end) Q_3(:,2:end) Q_4(:,2:end) Q_5(:,2:end) Q_6(:,2:end) Q_7(:,2:end) Q_8(:,2:end) Q_9(:,2:end) Q_10(:,2:end) Q_11(:,2:end) Q_12(:,2:end) Q_12_1(:,2:end) Q_r(:,2:end) Q_f(:,2:end) Q_z(:,2:end)];
Q_dot_tot = [Q_dot_z Q_dot_p(:,2:end) Q_dot_0(:,2:end) Q_dot_1(:,2:end) Q_dot_1_1(:,2:end) Q_dot_2(:,2:end) Q_dot_3(:,2:end) Q_dot_4(:,2:end) Q_dot_5(:,2:end) Q_dot_6(:,2:end) Q_dot_7(:,2:end) Q_dot_8(:,2:end) Q_dot_9(:,2:end) Q_dot_10(:,2:end) Q_dot_11(:,2:end) Q_dot_12(:,2:end) Q_dot_12_1(:,2:end) Q_dot_r(:,2:end) Q_dot_f(:,2:end) Q_dot_z(:,2:end)];
Q_dot2_tot = [Q_dot2_z Q_dot2_p(:,2:end) Q_dot2_0(:,2:end) Q_dot2_1(:,2:end) Q_dot2_1_1(:,2:end) Q_dot2_2(:,2:end) Q_dot2_3(:,2:end) Q_dot2_4(:,2:end) Q_dot2_5(:,2:end) Q_dot2_6(:,2:end) Q_dot2_7(:,2:end) Q_dot2_8(:,2:end) Q_dot2_9(:,2:end) Q_dot2_10(:,2:end) Q_dot2_11(:,2:end) Q_dot2_12(:,2:end) Q_dot2_12_1(:,2:end) Q_dot2_r(:,2:end) Q_dot2_f(:,2:end) Q_dot2_z(:,2:end)];

x_tot = [x_z x_p(:,2:end) x0(:,2:end) x1(:,2:end) x1_1(:,2:end) x2(:,2:end) x3(:,2:end) x4(:,2:end) x5(:,2:end) x6(:,2:end) x7(:,2:end) x8(:,2:end) x9(:,2:end) x10(:,2:end) x11(:,2:end) x12(:,2:end) x12_1(:,2:end) xr(:,2:end) x_f(:,2:end) x_z(:,2:end)];
y_tot = [y_z y_p(:,2:end) y0(:,2:end) y1(:,2:end) y1_1(:,2:end) y2(:,2:end) y3(:,2:end) y4(:,2:end) y5(:,2:end) y6(:,2:end) y7(:,2:end) y8(:,2:end) y9(:,2:end) y10(:,2:end) y11(:,2:end) y12(:,2:end) y12_1(:,2:end) yr(:,2:end) y_f(:,2:end) y_z(:,2:end)];
z_tot = [z_z z_p(:,2:end) z0(:,2:end) z1(:,2:end) z1_1(:,2:end) z2(:,2:end) z3(:,2:end) z4(:,2:end) z5(:,2:end) z6(:,2:end) z7(:,2:end) z8(:,2:end) z9(:,2:end) z10(:,2:end) z11(:,2:end) z12(:,2:end) z12_1(:,2:end) zr(:,2:end) z_f(:,2:end) z_z(:,2:end)];

