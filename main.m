
%% Menu di scelta
% 
clear
clc
caricamento_dati;
clc
%%
exit = 0;
while(exit == 0)
    clc
    fprintf('1 - display configurazione robot\n');
    fprintf('2 - plot workspace\n');
    fprintf('3 - pianificazione traiettoria task\n');
    fprintf('4 - dinamica inversa task\n');
    fprintf('5 - simulazione in Simscape\n');
    fprintf('9 - chiudi tutti i grafici\n');
    fprintf('0 - esci\n');


    valore_scelta = input('Enter a value: ');
    switch valore_scelta
        case 1
            clc
            close all
            disp('--- Configurazione attuale ---')
            prompt = 'Inserire nuove coordinate nello spazio dei giunti? y/n: ';
            str = input(prompt,'s');
            if str == 'y'
                while 1
                    q1 = input('giunto 1 [rad]: ');
                    if q1 < deg2rad(maxQ1) && q1 > deg2rad(minQ1)
                        break;
                    else
                        warning('Valore di q1 fuori dai limiti');
                    end
                end
                
                while 1
                    q2 = input('giunto 2 [m]: ');
                    if q2 > 0 && q2 < maxQ2
                        break;
                    else
                        warning('Valore di q2 fuori dai limiti');
                    end
                end
                q3 = input('giunto 3 [rad]: ');
                plot_robot_main([q1;q2;q3],L,'r');
            else
                fprintf('In uso la configurazione di default (0,0,0) con robot a riposo \n');
                plot_robot_main([q1;q2;q3],L,'r');
            end
        case 2
            clc
            close all
            disp('--- Workspace ---')
            plot_ws;
        case 3
            close all
            disp('--- Traiettoria ---')
            pianificazione_traiettoria_grafici
        case 4
            clc
            close all
            disp('--- Dinamica inversa ---')
            grafica = 1;
            dinamica_inv_tratti;
            risultati_dinamica;
            clear grafica;
        case 5
            disp('--- Simulink ---')
            sim_robot_control;
        case 0
            clear;
            exit = 1;
        case 9
            close all
            clc
        otherwise
            disp('Scelta non valida, reinserire')
            clc;
    end
end



