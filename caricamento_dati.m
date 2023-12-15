% Dichiarazione parametri robot 
tr6_data;
tensore_inerzia_acciaio;

% Calcolo Jacobiano e derivata prima simbolici
[J,J_dot] = jacobiano;

Q_tot = load('dati/Q_tot.mat');
Q_tot = Q_tot.Q_tot;
Q_dot_tot =  load('dati/Q_dot_tot.mat');
Q_dot_tot = Q_dot_tot.Q_dot_tot;
Q_dot2_tot =  load('dati/Q_dot2_tot.mat');
Q_dot2_tot = Q_dot2_tot.Q_dot2_tot;
tt_tot = load('dati/tt_tot.mat');
tt_tot = tt_tot.tt_tot;
T_tot = tt_tot(end);

x_tot = load('dati/x_tot.mat');
x_tot = x_tot.x_tot;
y_tot = load('dati/y_tot.mat');
y_tot = y_tot.y_tot;
z_tot = load('dati/z_tot.mat');
z_tot = z_tot.z_tot;

% Ingressi Simulink
pos1 = timeseries(Q_tot(1,:),tt_tot);
vel1 = timeseries(Q_dot_tot(1,:),tt_tot);
acc1 = timeseries(Q_dot2_tot(1,:),tt_tot);

pos2 = timeseries(Q_tot(2,:),tt_tot);
vel2 = timeseries(Q_dot_tot(2,:),tt_tot);
acc2 = timeseries(Q_dot2_tot(2,:),tt_tot);

pos3 = timeseries(Q_tot(3,:),tt_tot);
vel3 = timeseries(Q_dot_tot(3,:),tt_tot);
acc3 = timeseries(Q_dot2_tot(3,:),tt_tot);  


%% Configurazione base robot
q1 = 0;
q2 = 0;
q3 = pi/2;
