function crea_subFigure_traiettoria_ws(Q_i,Q_f,L,fresa,x,y,z,dimensione,p1_cubo,p2_cubo,X1,Y1,Z1,X2,Y2,Z2)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione per la creazione di grafici 2D contenenti robot e
    % traiettoria
    %
    % crea_subFigure_traiettoria_ws(Q_i,Q_f,L,fresa,x,y,z,dimensione,p1_cubo,p2_cubo,X1,Y1,Z1,X2,Y2,Z2)
    %
    %
    % Input:
    %       Q_i (array, float) : coordinate giunti (posizione iniziale)
    %       Q_f (array, float) : coordinate giunti (posizione finale)
    %       L (array, float) : descrizione geometrica robot
    %       fresa (struct) : parametri fresatrice
    %       x,y,z (array, float) : traiettoria nello spazio di lavoro
    %       dimensione (float) : spessore linea plot
    %       p1_cubo,p2_cubo (bool) : flag per rappresentare o meno il pezzo
    %       rispettivamente in posizione iniziale e finale
    %       X1,Y1,Z1 (array, float) : ws vista laterale
    %       X2,Y2,Z2 (array, float) : ws vista dall'alto
    %
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    r = fresa.r;
    cnt = fresa.cnt;
    height = fresa.height;
    nSides = fresa.nSides;
    color = fresa.color;
    
    figure
    subplot(1,2,1);   % Vista da davanti
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
        xlim([-2 2.5])
        ylim([-2 2.5])
        zlim([-2 2.5])
        title('Vista laterale') % Vista dall'alto
        plot3(x,z,y,'k','LineWidth',dimensione)
        plot3(X1,Z1,Y1,'m','LineStyle','--','LineWidth',1)
        axis square
        view(-0,0);
        h = zeros(4, 1);
        h(1) = plot(NaN,NaN,'-r');
        h(2) = plot(NaN,NaN,'-g');
        h(3) = plot(NaN,NaN,'-k');
        h(4) = plot(NaN,NaN,'-b');
        h(5) = plot(NaN,NaN,'--m');
        lgd = legend(h, 'Configurazione iniziale','Configurazione finale','Traiettoria','Fresatrice','Workspace');
        lgd.FontSize = 11;
        lgd.FontWeight = 'bold';
        lgd.LineWidth = 1;
        lgd.Location = 'southwest';
        
        subplot(1,2,2);% Vista dall'alto   
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
        xlim([-2 2.5])
        ylim([-2 2.5])
        zlim([-2 2.5])
        title("Vista dall'alto")
        plot3(x,z,y,'k','LineWidth',dimensione)
        plot3(X2,Z2,Y2,'m','LineStyle','--','LineWidth',1)
        axis square
        view(0,90);
        h = zeros(4, 1);
        h(1) = plot(NaN,NaN,'-r');
        h(2) = plot(NaN,NaN,'-g');
        h(3) = plot(NaN,NaN,'-k');
        h(4) = plot(NaN,NaN,'-b');
        h(5) = plot(NaN,NaN,'--m');
        lgd = legend(h, 'Configurazione iniziale','Configurazione finale','Traiettoria','Fresatrice','Workspace');
        lgd.FontSize = 11;
        lgd.FontWeight = 'bold';
        lgd.LineWidth = 1;
        lgd.Location = 'southwest';
    
        

    
end