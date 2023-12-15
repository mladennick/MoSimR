function plot_traiettoria_giunto(giunto,tipo,Q,Q_dot,Q_dot2,tt,limiti_pos,limiti_vel,limiti_acc,modo)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione per graficare posizione, velocita' e accelerazione di un
    % giunto lungo una traiettoria
    %
    % plot_traiettoria_giunto(giunto,tipo,Q,Q_dot,Q_dot,tt,limiti_pos,limiti_vel,limiti_acc)
    % 
    % Input : 
    %       giunto (int): numero corrispondente al giunto di interesse
    %       tipo (str): 'r' o 'p' a seconda che il giunto sia rotoidale o
    %       prismatico
    %       Q (array, float) : posizioni del giunto assunte durante la
    %       percorrenza della traiettoria
    %       Q_dot (array, float) : velocita' del giunto assunte durante la
    %       percorrenza della traiettoria
    %       Q_dot2 (array, float) : accelerazioni del giunto assunte 
    %       durante la percorrenza della traiettoria
    %       tt (array, float): istanti di tempo
    %       limiti_pos (array, float) : limiti posizione (minima e massima)
    %       limiti_vel (array, float) : limiti velocita' (minima e massima)
    %       limiti_acc (array, float) : limiti accelerazione (minima e 
    %       massima)
    %       modo (int): 1 per grafici separati, 2 per grafici subplot
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    minQ = limiti_pos(1);
    maxQ = limiti_pos(2);
    minQ_dot = limiti_vel(1);
    maxQ_dot = limiti_vel(2);
    minQ_dot2 = limiti_acc(1);
    maxQ_dot2 = limiti_acc(2);

    if tipo == 'r'
        minQ = deg2rad(minQ);
        maxQ = deg2rad(maxQ);
    end

    if modo == 1
        figure
        plot(tt,Q)
        hold on
        plot([tt(1) tt(end)], [minQ minQ],'r--',[tt(1) tt(end)],[maxQ maxQ],'r--')
        legend(['q',num2str(giunto)],['q',num2str(giunto),'_{min}'],['q',num2str(giunto),'_{max}']);
        if tipo == 'r'
           ylabel('posizione [rad]')
        else 
           ylabel('posizione [m]')
        end
        xlabel('tempo [s]')
        title(['Posizione giunto  ',num2str(giunto)])
        
        figure
        plot(tt,Q_dot)
        hold on
        plot([tt(1) tt(end)], [minQ_dot minQ_dot],'r--',[tt(1) tt(end)],[maxQ_dot maxQ_dot],'r--');
        legend(['q',num2str(giunto),'dot'],['q',num2str(giunto),'dot_{min}'],['q',num2str(giunto),'dot_{max}']);
        if tipo == 'r'
           ylabel('velocita [rad/s]')
        else 
           ylabel('velocita [m/s]')
        end
        xlabel('tempo [s]')
        title(['Velocita giunto  ',num2str(giunto)])
        
        figure
        plot(tt,Q_dot2)
        hold on
        plot([tt(1) tt(end)], [minQ_dot2 minQ_dot2],'r--',[tt(1) tt(end)],[maxQ_dot2 maxQ_dot2],'r--');
        legend(['q',num2str(giunto),'dot2'],['q',num2str(giunto),'dot2_{min}'],['q',num2str(giunto),'dot2_{max}']);
        if tipo == 'r'
           ylabel('accelerazione [rad/s^2]')
        else 
           ylabel('accelerazione [m/s^2]')
        end
        xlabel('tempo [s]')
        title(['Accelerazione giunto  ',num2str(giunto)])
        
    else
        figure
        subplot(3,1,1)
        plot(tt,Q)
        xlim([0 tt(end)])
        hold on
        plot([tt(1) tt(end)], [minQ minQ],'r--',[tt(1) tt(end)],[maxQ maxQ],'r--')
        % legend('q1','q1_{min}','q1_{max}');
        if tipo == 'r'
           ylabel('posizione [rad]')
        else 
           ylabel('posizione [m]')
        end
        xlabel('tempo [s]')
        if giunto == 1
           ylim([-2 2]);
        elseif giunto == 2
           ylim([-0.5 0.5]);
        else
           ylim([-7 7]);
        end
        subplot(3,1,2)
        plot(tt,Q_dot)
        xlim([0 tt(end)])
        hold on
        plot([tt(1) tt(end)], [minQ_dot minQ_dot],'r--',[tt(1) tt(end)],[maxQ_dot maxQ_dot],'r--');
        % legend('q1dot','q1dot_{min}','q1dot_{max}');
        if tipo == 'r'
           ylabel('velocita [rad/s]')
        else 
           ylabel('velocita [m/s]')
        end
        xlabel('tempo [s]')
        if giunto == 1
           ylim([-3 3]);
        elseif giunto == 2
           ylim([-1 1]);
        else
           ylim([-3 3]);
        end
        subplot(3,1,3)
        plot(tt,Q_dot2)
        xlim([0 tt(end)])
        hold on
        plot([tt(1) tt(end)], [minQ_dot2 minQ_dot2],'r--',[tt(1) tt(end)],[maxQ_dot2 maxQ_dot2],'r--');
        % legend('q1dot2','q1dot2_{min}','q1dot2_{max}');
        if tipo == 'r'
           ylabel('accelerazione [rad/s^2]')
        else 
           ylabel('accelerazione [m/s^2]')
        end
        xlabel('tempo [s]')
        if giunto == 1
           ylim([-22 22]);
        elseif giunto == 2
           ylim([-6 6]);
        else
           ylim([-30 30]);
        end
        sgtitle(['Moto giunto  ',num2str(giunto)])
    end
    
    end

