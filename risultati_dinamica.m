%% Risultati dinamica matriciale
if(exist('dinamica_inv_tratti_check','var') == 0)
        dinamica_inv_tratti;
        close all;
        fprintf("dinamica caricata");
else
    fprintf("Esisteva gia");
end
clc
%%
% Plot delle coppie e forze di tutti i giunti in un unico grafico
figure
plot(tt_tot,theta_tot(:,1),tt_tot,theta_tot(:,2),tt_tot,theta_tot(:,3),'LineWidth',1.6)
grid on 
legend('c_1','f_2','c_3');
xlabel('tempo [s]')
xlim([0 T_tot])
ylabel('Coppia [N*m]/Forza [N]')
title('Coppie e forze di tutti i giunti');
%%
% Plot delle coppie e forze di tutti i giunti in grafici separati
figure
plot(tt_tot,theta_tot(:,1),'LineWidth',1.6)
grid on 
% legend('c_1','f_2','c_3');
xlabel('tempo [s]')
xlim([0 T_tot])
ylabel('Coppia [N*m]')
title('Coppia del primo giunto (rotoidale)');
%%
figure
plot(tt_tot,theta_tot(:,2),'Color',[0.8500 0.3250 0.0980],'LineWidth',1.6)
grid on 
% legend('c_1','f_2','c_3');
xlabel('tempo [s]')
xlim([0 T_tot])
ylabel('Forza [N]')
title('forza del secondo giunto (prismatico)');
%%

figure
plot(tt_tot,theta_tot(:,3),'Color',[0.9290 0.6940 0.1250]	,'LineWidth',1.6)
grid on 
% legend('c_1','f_2','c_3');
xlabel('tempo [s]')
xlim([0 T_tot])
ylabel('Coppia [N*m]')
title('Coppia del terzo giunto (rotoidale)');