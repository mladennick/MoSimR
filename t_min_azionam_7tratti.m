%% TEMPO MINIMO DI AZIONAMENTO P1-P2 LDM SETTE TRATTI

% vedere traiett_rett_7tratti
% NB: MODIFICARE PIANIFICAZIONE TRAIETTORIA!!!

close all

% Calcolo parametri k sulla base della legge di moto tre tratti
% Tre tratti giunto q3
t1 = maxQ3_dot/maxQ3_dot2; 
t3 = t1; 
l1 = t1/T; % 0.0737 --> 7.3712%
l3 = l1;
l2 = 1-l1-l3; % 0.8592 --> 85.9155%

%%
% Tempo minimo azionamento: 1.42 s, trovato guardando quando la velocita'
% di q3 (giunto piu' lento) satura al limite massimo.

% % Inizializzazione parametri legge di moto 7 tratti
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

%%
T = 1.412; 
n = 10000;
dT = T/(n-1);
tt = 0:dT:T;

L1=k1*T/(k1+k2+k3+k4+k5+k6+k7);
L2=k2*T/(k1+k2+k3+k4+k5+k6+k7);
L3=k3*T/(k1+k2+k3+k4+k5+k6+k7);
L4=k4*T/(k1+k2+k3+k4+k5+k6+k7);
L5=k5*T/(k1+k2+k3+k4+k5+k6+k7);
L6=k6*T/(k1+k2+k3+k4+k5+k6+k7);
L7=k7*T/(k1+k2+k3+k4+k5+k6+k7);

% Punti traiettoria
S_p1 = [1.7500 0.3000 0];
S_p2 = [1.6475 -0.9223 0];
Q_p1 = cinematica_inversa_NR2(S_p1,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p2 = cinematica_inversa_NR2(S_p2,[0 0 pi],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);

dQ = Q_p2-Q_p1;

v0 = [0 0 0];
vf = [0 0 0];
a0 = [0 0 0];
af = [0 0 0];

[sc_q1,vc_q1,A_q1,D_q1] = settetratti_generica_coeff(T,Q_p1(1),dQ(1),v0(1),vf(1),a0(1),af(1),L1,L2,L3,L4,L5,L6,L7);
[sc_q2,vc_q2,A_q2,D_q2] = settetratti_generica_coeff(T,Q_p1(2),dQ(2),v0(2),vf(2),a0(2),af(2),L1,L2,L3,L4,L5,L6,L7);
[sc_q3,vc_q3,A_q3,D_q3] = settetratti_generica_coeff(T,Q_p1(3),dQ(3),v0(3),vf(3),a0(3),af(3),L1,L2,L3,L4,L5,L6,L7);

for i=1:n
    t=tt(i);
    [q1(i),q1dot(i),q1dot2(i)] = settetratti_generica(t,T,Q_p1(1),dQ(1),v0(1),vf(1),a0(1),af(1),L1,L2,L3,L4,L5,L6,L7,sc_q1,vc_q1,A_q1,D_q1);
    [q2(i),q2dot(i),q2dot2(i)] = settetratti_generica(t,T,Q_p1(2),dQ(2),v0(2),vf(2),a0(2),af(2),L1,L2,L3,L4,L5,L6,L7,sc_q2,vc_q2,A_q2,D_q2);
    [q3(i),q3dot(i),q3dot2(i)] = settetratti_generica(t,T,Q_p1(3),dQ(3),v0(3),vf(3),a0(3),af(3),L1,L2,L3,L4,L5,L6,L7,sc_q3,vc_q3,A_q3,D_q3);
end

% figure
% subplot(3,1,1)
% plot(tt,q1)
% hold on
% plot([tt(1) tt(end)],[deg2rad(minQ1) deg2rad(minQ1)],'r')
% plot([tt(1) tt(end)],[deg2rad(maxQ1) deg2rad(maxQ1)],'r')
% ylabel('position [rad]')
% xlabel('time [s]')
% subplot(3,1,2)
% plot(tt,q1dot)
% hold on
% plot([tt(1) tt(end)],[minQ1_dot minQ1_dot],'r')
% plot([tt(1) tt(end)],[maxQ1_dot maxQ1_dot],'r')
% ylabel('velocita (rad/s)')
% xlabel('time [s]')
% subplot(3,1,3)
% plot(tt,q1dot2)
% hold on
% plot([tt(1) tt(end)],[minQ1_dot2 minQ1_dot2],'r')
% plot([tt(1) tt(end)],[maxQ1_dot2 maxQ1_dot2],'r')
% ylabel('acceleration [rad/s^2]')
% xlabel('time [s]')
% sgtitle('Moto giunto q1')
% 
% figure
% subplot(3,1,1)
% plot(tt,q2)
% hold on
% plot([tt(1) tt(end)],[minQ2 minQ2],'r')
% plot([tt(1) tt(end)],[maxQ2 maxQ2],'r')
% ylabel('position [m]')
% xlabel('time [s]')
% subplot(3,1,2)
% plot(tt,q2dot)
% hold on
% plot([tt(1) tt(end)],[minQ2_dot minQ2_dot],'r')
% plot([tt(1) tt(end)],[maxQ2_dot maxQ2_dot],'r')
% ylabel('velocita (m/s)')
% xlabel('time [s]')
% subplot(3,1,3)
% plot(tt,q2dot2)
% hold on
% plot([tt(1) tt(end)],[minQ2_dot2 minQ2_dot2],'r')
% plot([tt(1) tt(end)],[maxQ2_dot2 maxQ2_dot2],'r')
% ylabel('acceleration [m/s^2]')
% xlabel('time [s]')
% sgtitle('Moto giunto q2')

figure
subplot(3,1,1)
plot(tt,q3)
hold on
plot([tt(1) tt(end)],[deg2rad(minQ3) deg2rad(minQ3)],'r')
plot([tt(1) tt(end)],[deg2rad(maxQ3) deg2rad(maxQ3)],'r')
ylabel('position [rad]')
xlabel('time [s]')
subplot(3,1,2)
plot(tt,q3dot)
hold on
plot([tt(1) tt(end)],[minQ3_dot minQ3_dot],'r')
plot([tt(1) tt(end)],[maxQ3_dot maxQ3_dot],'r')
ylabel('velocita (rad/s)')
xlabel('time [s]')
subplot(3,1,3)
plot(tt,q3dot2)
hold on
plot([tt(1) tt(end)],[minQ3_dot2 minQ3_dot2],'r')
plot([tt(1) tt(end)],[maxQ3_dot2 maxQ3_dot2],'r')
ylabel('acceleration [rad/s^2]')
xlabel('time [s]')
sgtitle('Moto giunto q3')

%% Iterazioni per determinare tempo T in cui il giunto piu' "lento" raggiunge la velocita' massima

Tmin = 1.412; 
Tmax = 1.412;

for j=Tmin:0.001:Tmax
    
    T = j
    n = 10000;
    dT = T/(n-1);
    tt = 0:dT:T;
    
    L1=k1*T/(k1+k2+k3+k4+k5+k6+k7);
    L2=k2*T/(k1+k2+k3+k4+k5+k6+k7);
    L3=k3*T/(k1+k2+k3+k4+k5+k6+k7);
    L4=k4*T/(k1+k2+k3+k4+k5+k6+k7);
    L5=k5*T/(k1+k2+k3+k4+k5+k6+k7);
    L6=k6*T/(k1+k2+k3+k4+k5+k6+k7);
    L7=k7*T/(k1+k2+k3+k4+k5+k6+k7);
    
    [sc_q1,vc_q1,A_q1,D_q1] = settetratti_generica_coeff(T,Q_p1(1),dQ(1),v0(1),vf(1),a0(1),af(1),L1,L2,L3,L4,L5,L6,L7);
    [sc_q2,vc_q2,A_q2,D_q2] = settetratti_generica_coeff(T,Q_p1(2),dQ(2),v0(2),vf(2),a0(2),af(2),L1,L2,L3,L4,L5,L6,L7);
    [sc_q3,vc_q3,A_q3,D_q3] = settetratti_generica_coeff(T,Q_p1(3),dQ(3),v0(3),vf(3),a0(3),af(3),L1,L2,L3,L4,L5,L6,L7);

    for i=1:n
        t=tt(i);
        [q1(i),q1dot(i),q1dot2(i)] = settetratti_generica(t,T,Q_p1(1),dQ(1),v0(1),vf(1),a0(1),af(1),L1,L2,L3,L4,L5,L6,L7,sc_q1,vc_q1,A_q1,D_q1);
        [q2(i),q2dot(i),q2dot2(i)] = settetratti_generica(t,T,Q_p1(2),dQ(2),v0(2),vf(2),a0(2),af(2),L1,L2,L3,L4,L5,L6,L7,sc_q2,vc_q2,A_q2,D_q2);
        [q3(i),q3dot(i),q3dot2(i)] = settetratti_generica(t,T,Q_p1(3),dQ(3),v0(3),vf(3),a0(3),af(3),L1,L2,L3,L4,L5,L6,L7,sc_q3,vc_q3,A_q3,D_q3);
    end

    close all 
    
%     figure
%     subplot(3,1,1)
%     plot(tt,q1)
%     hold on
%     plot([tt(1) tt(end)],[deg2rad(minQ1) deg2rad(minQ1)],'r')
%     plot([tt(1) tt(end)],[deg2rad(maxQ1) deg2rad(maxQ1)],'r')
%     ylabel('position [rad]')
%     xlabel('time [s]')
%     subplot(3,1,2)
%     plot(tt,q1dot)
%     hold on
%     plot([tt(1) tt(end)],[minQ1_dot minQ1_dot],'r')
%     plot([tt(1) tt(end)],[maxQ1_dot maxQ1_dot],'r')
%     ylabel('velocita (rad/s)')
%     xlabel('time [s]')
%     subplot(3,1,3)
%     plot(tt,q1dot2)
%     hold on
%     plot([tt(1) tt(end)],[minQ1_dot2 minQ1_dot2],'r')
%     plot([tt(1) tt(end)],[maxQ1_dot2 maxQ1_dot2],'r')
%     ylabel('acceleration [rad/s^2]')
%     xlabel('time [s]')
%     sgtitle('Moto giunto q1')

%     figure
%     subplot(3,1,1)
%     plot(tt,q2)
%     hold on
%     plot([tt(1) tt(end)],[minQ2 minQ2],'r')
%     plot([tt(1) tt(end)],[maxQ2 maxQ2],'r')
%     ylabel('position [m]')
%     xlabel('time [s]')
%     subplot(3,1,2)
%     plot(tt,q2dot)
%     hold on
%     plot([tt(1) tt(end)],[minQ2_dot minQ2_dot],'r')
%     plot([tt(1) tt(end)],[maxQ2_dot maxQ2_dot],'r')
%     ylabel('velocita (m/s)')
%     xlabel('time [s]')
%     subplot(3,1,3)
%     plot(tt,q2dot2)
%     hold on
%     plot([tt(1) tt(end)],[minQ2_dot2 minQ2_dot2],'r')
%     plot([tt(1) tt(end)],[maxQ2_dot2 maxQ2_dot2],'r')
%     ylabel('acceleration [m/s^2]')
%     xlabel('time [s]')
%     sgtitle('Moto giunto q2')

    figure
    subplot(3,1,1)
    plot(tt,q3)
    hold on
    plot([tt(1) tt(end)],[deg2rad(minQ3) deg2rad(minQ3)],'r')
    plot([tt(1) tt(end)],[deg2rad(maxQ3) deg2rad(maxQ3)],'r')
    ylabel('position [rad]')
    xlabel('time [s]')
    subplot(3,1,2)
    plot(tt,q3dot)
    hold on
    plot([tt(1) tt(end)],[minQ3_dot minQ3_dot],'r')
    plot([tt(1) tt(end)],[maxQ3_dot maxQ3_dot],'r')
    ylabel('velocita (rad/s)')
    xlabel('time [s]')
    subplot(3,1,3)
    plot(tt,q3dot2)
    
    hold on
    plot([tt(1) tt(end)],[minQ3_dot2 minQ3_dot2],'r')
    plot([tt(1) tt(end)],[maxQ3_dot2 maxQ3_dot2],'r')
    ylabel('acceleration [rad/s^2]')
    xlabel('time [s]')
    sgtitle('Moto giunto q3')

    figure
    plot(tt,q3dot)
    hold on
    plot([tt(1) tt(end)],[minQ3_dot minQ3_dot],'r')
    plot([tt(1) tt(end)],[maxQ3_dot maxQ3_dot],'r')
    ylabel('velocita (m/s)')
    xlabel('time [s]')
    ylim([2.4 2.6]);
    xlim([1 1.5]);
    
    pause
    
end

%% CON LEGGE CICLOIDALE
% Dati
S_p1 = [1.7500 0.3000 0]; 
S_p2 = [1.6475 -0.9223 0];
Q_p1 = cinematica_inversa_NR2(S_p1,[0 0 0],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
Q_p2 = cinematica_inversa_NR2(S_p2,[0 0 pi],L,J,[minQ1,minQ2],[maxQ1,maxQ2]);
dQ = Q_p2-Q_p1; % (-0.5236,0.2250,3.1416)

%% Giunto 1
T1_cicl1 = 2*abs(dQ(1))/maxQ1_dot;
T2_cicl1 = sqrt(2*pi*dQ(1)/maxQ1_dot2);
Tmin1 = max(T1_cicl1, T2_cicl1); % 0.5236

dT1 = Tmin1/(n-1);   
tt1 = 0:dT1:Tmin1; 
for i=1:n
    [q1_cicl(i),dq1_cicl(i),ddq1_cicl(i)] = cicloidale(tt1(i),Tmin1,Q_p1(1),dQ(1));
end

figure
subplot(3,1,1)
plot(tt1,q1_cicl)
hold on
plot([tt1(1) tt1(end)],[deg2rad(minQ1) deg2rad(minQ1)],'r')
plot([tt1(1) tt1(end)],[deg2rad(maxQ1) deg2rad(maxQ1)],'r')
ylabel('position [rad]')
xlabel('time [s]')
subplot(3,1,2)
plot(tt1,dq1_cicl)
hold on
plot([tt1(1) tt1(end)],[minQ1_dot minQ1_dot],'r')
plot([tt1(1) tt1(end)],[maxQ1_dot maxQ1_dot],'r')
ylabel('velocita (rad/s)')
xlabel('time [s]')
subplot(3,1,3)
plot(tt1,ddq1_cicl)
hold on
plot([tt1(1) tt1(end)],[minQ1_dot2 minQ1_dot2],'r')
plot([tt1(1) tt1(end)],[maxQ1_dot2 maxQ1_dot2],'r')
ylabel('acceleration [rad/s^2]')
xlabel('time [s]')
sgtitle('Moto giunto q1')

%% Giunto 2
T1_cicl2 = 2*abs(dQ(2))/maxQ2_dot;
T2_cicl2 = sqrt(2*pi*dQ(2)/maxQ2_dot2);
Tmin2 = max(T1_cicl2, T2_cicl2); % 0.9

dT2 = Tmin2/(n-1);   
tt2 = 0:dT2:Tmin2; 
for i=1:n
    [q2_cicl(i),dq2_cicl(i),ddq2_cicl(i)] = cicloidale(tt2(i),Tmin2,Q_p1(2),dQ(2));
end

figure
subplot(3,1,1)
plot(tt2,q2_cicl)
hold on
plot([tt2(1) tt2(end)],[deg2rad(minQ2) deg2rad(minQ2)],'r')
plot([tt2(1) tt2(end)],[deg2rad(maxQ2) deg2rad(maxQ2)],'r')
ylabel('position [rad]')
xlabel('time [s]')
subplot(3,1,2)
plot(tt2,dq2_cicl)
hold on
plot([tt2(1) tt2(end)],[minQ2_dot minQ2_dot],'r')
plot([tt2(1) tt2(end)],[maxQ2_dot maxQ2_dot],'r')
ylabel('velocita (rad/s)')
xlabel('time [s]')
subplot(3,1,3)
plot(tt2,ddq2_cicl)
hold on
plot([tt2(1) tt2(end)],[minQ2_dot2 minQ2_dot2],'r')
plot([tt2(1) tt2(end)],[maxQ2_dot2 maxQ2_dot2],'r')
ylabel('acceleration [rad/s^2]')
xlabel('time [s]')
sgtitle('Moto giunto q2')


%% Giunto 3
T1_cicl3 = 2*abs(dQ(3))/maxQ3_dot;
T2_cicl3 = sqrt(2*pi*dQ(3)/maxQ3_dot2);
Tmin3 = max(T1_cicl3, T2_cicl3); % 2.5133

dT3 = Tmin3/(n-1);   
tt3 = 0:dT3:Tmin3; 
for i=1:n
    [q3_cicl(i),dq3_cicl(i),ddq3_cicl(i)] = cicloidale(tt3(i),Tmin3,Q_p1(3),dQ(3));
end

figure
subplot(3,1,1)
plot(tt3,q3_cicl)
hold on
plot([tt3(1) tt1(end)],[deg2rad(minQ3) deg2rad(minQ3)],'r')
plot([tt3(1) tt1(end)],[deg2rad(maxQ3) deg2rad(maxQ3)],'r')
ylabel('position [rad]')
xlabel('time [s]')
subplot(3,1,2)
plot(tt3,dq3_cicl)
hold on
plot([tt3(1) tt3(end)],[minQ3_dot minQ3_dot],'r')
plot([tt3(1) tt3(end)],[maxQ3_dot maxQ3_dot],'r')
ylabel('velocita (rad/s)')
xlabel('time [s]')
subplot(3,1,3)
plot(tt3,ddq3_cicl)
hold on
plot([tt3(1) tt3(end)],[minQ3_dot2 minQ3_dot2],'r')
plot([tt3(1) tt3(end)],[maxQ3_dot2 maxQ3_dot2],'r')
ylabel('acceleration [rad/s^2]')
xlabel('time [s]')
sgtitle('Moto giunto q3')

% Calcolo per ogni giunto e scelta del tempo maggiore

% Sbagliato mantenere le stesse proporzioni perchè calcolo tre tratti parte
% da supposizione che accelero al massimo per raggiungere velocità massima
% --> provare col calcoli come libro
