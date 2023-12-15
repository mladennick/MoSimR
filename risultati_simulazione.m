%% 1) Verifica correttezza modello e calcoli (sim_robot)

% Calcolo
% dinamica_inv_tratti;

% Simscape
% t_sim = out.c1.Time;
% c1_sim = out.c1.Data;
% f2_sim = out.f2.Data;
% c3_sim = out.c3.Data;
% 
% figure
% plot(t_sim,c1_sim,'LineWidth',2)
% hold on
% plot(tt_tot,theta_tot(:,1),'--','LineWidth',2)
% grid on 
% legend('c1_{sim}','c1_{calc}') 
% 
% figure
% plot(t_sim,f2_sim,'LineWidth',2)
% hold on
% plot(tt_tot,theta_tot(:,2),'--','LineWidth',2)
% grid on 
% legend('f2_{sim}','f2_{calc}') 
% 
% figure
% plot(t_sim,c3_sim,'LineWidth',2)
% hold on
% plot(tt_tot,theta_tot(:,3),'--','LineWidth',2)
% grid on 
% legend('c3_{sim}','c3_{calc}') 

%% 2) Controllo

% Giunto 1
t_sim = out.pos1_m.Time;
pos1_m_sim = out.pos1_m.Data;
vel1_m_sim = out.vel1_m.Data;
acc1_m_sim = out.acc1_m.Data;

figure
plot(t_sim,pos1_m_sim,'LineWidth',1.6)
hold on
plot(tt_tot,Q_tot(1,:),'--','LineWidth',1.6)
% plot([tt_tot(1) tt_tot(end)], [deg2rad(minQ1) deg2rad(minQ1)],'r--',[tt_tot(1) tt_tot(end)],[deg2rad(maxQ1) deg2rad(maxQ1)],'r--');
grid on
xlim([0 T_tot])
ylim([-1 1])
xlabel('tempo [s]');
ylabel('posizione [rad]')
legend('q1_{misurata}','q1_{calcolata}')
title('Posizione giunto 1')

figure
plot(t_sim,vel1_m_sim,'LineWidth',1.6)
hold on
plot(tt_tot,Q_dot_tot(1,:),'--','LineWidth',1.6)
% plot([tt_tot(1) tt_tot(end)], [minQ1_dot minQ1_dot],'r--',[tt_tot(1) tt_tot(end)],[maxQ1_dot maxQ1_dot],'r--');
grid on
xlim([0 T_tot])
ylim([-1 1])
xlabel('tempo [s]');
ylabel('velocità [rad/s]')
legend('q1dot_{misurata}','q1dot_{calcolata}')
title('Velocità giunto 1')

figure
plot(t_sim,acc1_m_sim,'LineWidth',1.6)
hold on
plot(tt_tot,Q_dot2_tot(1,:),'--','LineWidth',1.6)
% plot([tt_tot(1) tt_tot(end)], [minQ1_dot2 minQ1_dot2],'r--',[tt_tot(1) tt_tot(end)],[maxQ1_dot2 maxQ1_dot2],'r--');
grid on
xlim([0 T_tot])
ylim([-5 5])
xlabel('tempo [s]');
ylabel('accelerazione [rad/s^2]')
legend('q1dot2_{misurata}','q1dot2_{calcolata}')
title('Accelerazione giunto 1')

figure
plot(t_sim,out.err_pos1,'LineWidth',1.6)
grid on
xlim([0 T_tot])
ylim([-0.03 0.03])
xlabel('tempo [s]');
ylabel('errore posizione [rad]')
title('Errore di posizione giunto 1')

figure
plot(t_sim,out.c1_PI,'LineWidth',1.6)
grid on
xlim([0 T_tot])
% ylim([-1 1])
xlabel('tempo [s]');
ylabel('coppia [N*m]')
title('Azione di controllo giunto 1')
%%
% Giunto 2
pos2_m_sim = out.pos2_m.Data;
vel2_m_sim = out.vel2_m.Data;
acc2_m_sim = out.acc2_m.Data;

figure
plot(t_sim,pos2_m_sim,'LineWidth',1.6)
hold on
plot(tt_tot,Q_tot(2,:),'--','LineWidth',1.6)
% plot([tt_tot(1) tt_tot(end)], [minQ2 minQ2],'r--',[tt_tot(1) tt_tot(end)],[maxQ2 maxQ2],'r--');
grid on
xlim([0 T_tot])
ylim([-1 1])
xlabel('tempo [s]');
ylabel('posizione [m]')
legend('q2_{misurata}','q2_{calcolata}')
title('Posizione giunto 2')

figure
plot(t_sim,vel2_m_sim,'LineWidth',1.6)
hold on
plot(tt_tot,Q_dot_tot(2,:),'--','LineWidth',1.6)
% plot([tt_tot(1) tt_tot(end)], [minQ2_dot minQ2_dot],'r--',[tt_tot(1) tt_tot(end)],[maxQ2_dot maxQ2_dot],'r--');
grid on
xlim([0 T_tot])
ylim([-1 1])
xlabel('tempo [s]');
ylabel('velocità [m/s]')
legend('q2dot_{misurata}','q2dot_{calcolata}')
title('Velocità giunto 2')

figure
plot(t_sim,acc2_m_sim,'LineWidth',1.6)
hold on
plot(tt_tot,Q_dot2_tot(2,:),'--','LineWidth',1.6)
% plot([tt_tot(1) tt_tot(end)], [minQ2_dot2 minQ2_dot2],'r--',[tt_tot(1) tt_tot(end)],[maxQ2_dot2 maxQ2_dot2],'r--');
grid on
xlim([0 T_tot])
ylim([-2 2])
xlabel('tempo [s]');
ylabel('accelerazione [m/s^2]')
legend('q2dot2_{misurata}','q2dot2_{calcolata}')
title('Accelerazione giunto 2')

figure
plot(t_sim,out.err_pos2,'LineWidth',1.6)
grid on
xlim([0 T_tot])
ylim([-0.02 0.02])
xlabel('tempo [s]');
ylabel('posizione [m]')
title('Errore di posizione giunto 2')

figure
plot(t_sim,out.f2_PI,'LineWidth',1.6)
grid on
xlim([0 T_tot])
% ylim([-1 1])
xlabel('tempo [s]');
ylabel('forza [N]')
title('Azione di controllo giunto 2')
%%
% Giunto 3
pos3_m_sim = out.pos3_m.Data;
vel3_m_sim = out.vel3_m.Data;
acc3_m_sim = out.acc3_m.Data;

figure
plot(t_sim,pos3_m_sim,'LineWidth',1.6)
hold on
plot(tt_tot,Q_tot(3,:),'--','LineWidth',1.6)
% plot([tt_tot(1) tt_tot(end)], [deg2rad(minQ3) deg2rad(minQ3)],'r--',[tt_tot(1) tt_tot(end)],[deg2rad(maxQ3) deg2rad(maxQ3)],'r--');
grid on
xlim([0 T_tot])
ylim([-5 5])
xlabel('tempo [s]');
ylabel('posizione [rad]')
legend('q3_{misurata}','q3_{calcolata}')
title('Posizione giunto 3')

figure
plot(t_sim,vel3_m_sim,'LineWidth',1.6)
hold on
plot(tt_tot,Q_dot_tot(3,:),'--','LineWidth',1.6)
% plot([tt_tot(1) tt_tot(end)], [minQ3_dot minQ3_dot],'r--',[tt_tot(1) tt_tot(end)],[maxQ3_dot maxQ3_dot],'r--');
grid on
xlim([0 T_tot])
ylim([-4 4])
xlabel('tempo [s]');
ylabel('velocità [rad/s]')
legend('q3dot_{misurata}','q3dot_{calcolata}')
title('Velocità giunto 3')

figure
plot(t_sim,acc3_m_sim,'LineWidth',1.6)
hold on
plot(tt_tot,Q_dot2_tot(3,:),'--','LineWidth',1.6)
% plot([tt_tot(1) tt_tot(end)], [minQ3_dot2 minQ3_dot2],'r--',[tt_tot(1) tt_tot(end)],[maxQ3_dot2 maxQ3_dot2],'r--')
grid on
xlim([0 T_tot])
ylim([-20 20])
xlabel('tempo [s]');
ylabel('accelerazione [rad/s^2]')
legend('q3dot2_{misurata}','q3dot2_{calcolata}')
title('Accelerazione giunto 3')

figure
plot(t_sim,out.err_pos3,'LineWidth',1.6)
grid on
xlim([0 T_tot])
ylim([-1 1])
xlabel('tempo [s]');
ylabel('posizione [rad]')
title('Errore di posizione giunto 3')

figure
plot(t_sim,out.c3_PI,'LineWidth',1.6)
grid on
xlim([0 T_tot])
% ylim([-1 1])
xlabel('tempo [s]');
ylabel('coppia [N*m]')
title('Azione di controllo giunto 3')

%%
% Traiettoria
t_sim = out.x_m.Time;
x_sim = out.x_m.Data;
y_sim = out.y_m.Data;
z_sim = out.z_m.Data;

figure
grid on
plot3(x_sim,z_sim,y_sim,'LineWidth',1.6)
hold on
plot3(x_tot,z_tot,y_tot,'LineWidth',1.6)
lgd = legend('Traiettoria misurata','Traiettoria calcolata')
ax = gca;
ax.YAxis.Direction = 'reverse';
grid on
xlabel('x [m]');
ylabel('z [m]')
zlabel('y [m]');
lgd.FontSize = 11;
lgd.FontWeight = 'bold';
lgd.LineWidth = 1;

%%
figure
plot(t_sim,x_sim)
grid on
hold on
plot(tt_tot,x_tot)
xlabel('tempo [s]');
ylabel('spostamento [m]');
legend('x_{mis}','x_{calc}')
title('Spostamento x')

figure
plot(t_sim,y_sim)
xlabel('tempo [s]');
ylabel('spostamento [m]');
grid on
hold on
plot(tt_tot,y_tot)
legend('y_{mis}','y_{calc}')
title('Spostamento y')

figure
plot(t_sim,z_sim)
xlabel('tempo [s]');
ylabel('spostamento [m]');
grid on
hold on
plot(tt_tot,z_tot)
legend('z_{mis}','z_{calc}')
title('Spostamento z')





