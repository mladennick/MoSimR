function plot_traiettoria_ws(Q_i,Q_f,L,fresa,x,y,z,dimensione,titolo,p1_cubo,p2_cubo,leg)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione per graficare nello spazio di lavoro il robot nelle
    % configurazioni iniziale e finale e la traiettoria percorsa
    %
    % plot_traiettoria_ws(Q_i,Q_f,L,fresa,x,y,z,dimensione,titolo,p1_cubo,p2_cubo,leg)
    % 
    % Input : 
    %       Q_i (array, float): punto iniziale (nello spazio dei giunti)
    %       Q_f (array, float) : punto finale (nello spazio dei giunti)
    %       L (array, float): descrizione geometrica del robot
    %       fresa (struct) : struttura contenente la descrizione del cilindro 
    %       che rappresenta la fresatrice [r,cnt,height,nSides,color]
    %       x,y,z (array, float): traiettoria nello spazio di lavoro
    %       dimensione (float) : dimensione della linea relativa alla
    %       traiettoria
    %       titolo (str): titolo del grafico
    %       p1_cubo,p2_cubo (bool): 'true' per plot con cubo, 'false' per
    %       plot senza cubo
    %       leg (bool) : true per mostrare legenda
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    r = fresa.r;
    cnt = fresa.cnt;
    height = fresa.height;
    nSides = fresa.nSides;
    color = fresa.color;
    
    figure  
    grid on
    xlabel('x [m]');
    ylabel('z [m]');
    zlabel('y [m]');
    hold on
    if p1_cubo == true
        plotRPR_cubo(Q_i,L,'r');
    else 
        plotRPR(Q_i,L,'r');
    end
    if p2_cubo == true
        plotRPR_cubo(Q_f,L,'g');
    else 
        plotRPR(Q_f,L,'g');
    end
    plotCylinderWithCaps(r,cnt,height,nSides,color);
    plotCylinderWithCaps(r,cnt,-r,nSides,color);
    xlim([-2 3])
    ylim([-2 3])
    zlim([-2 3])
    plot3(x,z,y,'k','LineWidth',dimensione);
    
    % Definizione legenda slegata dagli item plottati nel grafico
    if leg == true
        h = zeros(4, 1);
        h(1) = plot(NaN,NaN,'-r');
        h(2) = plot(NaN,NaN,'-g');
        h(3) = plot(NaN,NaN,'-k');
        h(4) = plot(NaN,NaN,'-b');
        lgd = legend(h, 'Configurazione iniziale','Configurazione finale','Traiettoria','Fresatrice');
        lgd.FontSize = 11;
        lgd.FontWeight = 'bold';
        lgd.LineWidth = 1;
%         lgd.Location = 'southwest';
        lgd.Location = 'northwest';
    end
    
    title(titolo)
    hold off
    
end

