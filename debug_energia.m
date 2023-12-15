function debug_energia(Ek,Ep,W,dT,tt)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione per il plot del debug della dinamica inversa
    %
    % debug_energia(Ek,Ep,W,dT,tt)
    %
    % Input:
    %       Ek (array, float) : energia cinetica
    %       Ep (array, float) : energia potenziale
    %       W (array, float) : potenza forze esterne e motori
    %       dT (float) : ampiezza passo temporale
    %       tt (array, float) : tempo totale
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    Etot = Ek+Ep;
    dEtot = diff(Etot)/dT;

    % Grafici
    figure()
    xlabel('tempo [s]')
    ylabel('energia [J]')
    hold on
    plot(tt,Ek,tt,Ep,tt,Etot,'LineWidth',1.2) 
    title('Energia totale')
    legend('Energia cinetica','Energia potenziale','Energia totale','location','southwest')
    grid on

    figure()
    yline(0);
    xlabel('tempo [s]')
    ylabel('energia [J]')
    hold on
    plot(tt,W,'LineWidth',1.2) 
    plot(tt(1:end-1),dEtot, 'LineWidth', 1.2)
    title('Debug: confronto potenza in ingresso-derivata energia totale')
    legend('','Pm+Pe','d(Etot)/dt')
    grid on
end