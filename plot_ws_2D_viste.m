function [X,Y,Z] = plot_ws_2D_viste(minQ1,maxQ1,minQ2,maxQ2,minQ3,maxQ3,L,n,vista)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione adibita alla computazione del working space in 2D 
    %
    % Input : 
    %       minQ1,maxQ1,minQ2,maxQ2,minQ3,maxQ3 (float) : valori limite 
    %       delle coordinate dei giunti
    %       L (array,float) : vettore contenente la descrizione geometrica  
    %       del robot
    %       n (int) : numero punti di campionamento (default 50)
    %       vista (int) : parametro relativo alla vista da computare dove
    %       vista = 1 ==> xy
    %
    % Return:
    %       X,Y,Z (array,float) : terna contenente in ogni posizione un 
    %       valore di una possibile posizione del gripper
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    minQ3 = -180;
    maxQ3 = 180;
    
    % Calcolo passi
    n_punti = n*n;
    passo_q1 = abs(maxQ1 - minQ1)/n_punti;
    passo_q2 = abs(maxQ2 - minQ2)/n_punti;
    passo_q3 = abs(maxQ3 - minQ3)/n_punti;

    % Calcolo struttura relativa ai limiti 
    % [q1,q2,q3] = ndgrid(minQ1:passo_q1:maxQ1,minQ2:passo_q2:maxQ2,minQ3:passo_q3:maxQ3)

    % Inizializzazione vettori 
    X = [];
    Y = [];
    Z = [];

    m = 1;
    % vista xz
    if(vista == 1)
        % Indice terna m-esima
       
        % Temporaneamente q1 da 0-->90 per disegnare mezzo ws


        q2 = maxQ2;

        for i = minQ1:passo_q1:maxQ1 
            q1 = deg2rad(i);
            q3 = pi;
            % Calcolo cinematica diretta
            [x,y,z] = cinematica_diretta(q1,q2,q3,L);
            % Inserimento terna calcolata
            X(m) = x;
            Y(m) = y;
            Z(m) = z;
            % Incremento indice
            m = m + 1; 
        end
        for i = 68.0918:passo_q1:maxQ1
            q1 = deg2rad(i);
            q3 = 0;
            % Calcolo cinematica diretta
            [x,y,z] = cinematica_diretta(q1,q2,q3,L);
            % Inserimento terna calcolata
            X(m) = x;
            Y(m) = y;
            Z(m) = z;
            % Incremento indice
            m = m + 1; 
        end
        X(m) = X(m-1);
        Y(m) = Y(m-1) - 0.45;
        Z(m) = Z(m-1);

        q2 = minQ2;
        for i = maxQ1:-passo_q1:minQ1 
            q1 = deg2rad(i);
            q3 = 0;
            % Calcolo cinematica diretta
            [x,y,z] = cinematica_diretta(q1,q2,q3,L);
            % Inserimento terna calcolata
            X(m) = x;
            Y(m) = y;
            Z(m) = z;
            % Incremento indice
            m = m + 1; 
        end
        for i = -59.4898:-passo_q1:minQ1
            q1 = deg2rad(i);
            q3 = pi;
            % Calcolo cinematica diretta
            [x,y,z] = cinematica_diretta(q1,q2,q3,L);
            % Inserimento terna calcolata
            X(m) = x;
            Y(m) = y;
            Z(m) = z;
            % Incremento indice
            m = m + 1; 
        end
        X(m) = 0.35;
        Y(m) = -1.55;
        Z(m) = Z(m-1);
     
    elseif(vista==2)       
        
        q2 = maxQ2;
        q1 = deg2rad(79.1979);
        for k = minQ3/2:passo_q3:maxQ3/2 % alto ext, in basso int
            q3 = deg2rad(k);
            % Calcolo cinematica diretta
            [x,y,z] = cinematica_diretta(q1,q2,q3,L);
            % Inserimento terna calcolata
            X(m) = x;
            Y(m) = y;
            Z(m) = z;
            % Incremento indice
            m = m + 1;
        end
        
        X(m) = 0.2976;
        Y(m) = 1.088;
        Z(m) = Z(m-1);
        q2 = minQ2;
        q1 = deg2rad(79.1979);
        for k = 90:passo_q3:270 % alto ext, in basso int
            q3 = deg2rad(k);
            % Calcolo cinematica diretta
            [x,y,z] = cinematica_diretta(q1,q2,q3,L);
            % Inserimento terna calcolata
            X(m) = x;
            Y(m) = y;
            Z(m) = z;
            % Incremento indice
            m = m + 1;
        end
        X(m) = X(1);
        Y(m) = Y(1);
        Z(m) = Z(1);
        
        X(m) = -0.3;
        Y(m) = -Y(1);
        Z(m) = Z(1);
        
        q2 = maxQ2;
        q1 = deg2rad(-79.1979);
        for k = 270:-passo_q3:90
            q3 = deg2rad(k);
            % Calcolo cinematica diretta
            [x,y,z] = cinematica_diretta(q1,q2,q3,L);
            % Inserimento terna calcolata
            X(m) = x;
            Y(m) = y;
            Z(m) = z;
            % Incremento indice
            m = m + 1;
        end
        X(m) = X(m-1);
        Y(m) = 1.081;
        Z(m) = Z(m-1);
        m = m + 1;
        X(m) = X(m-1);
        Y(m) = -1.081;
        Z(m) = Z(m-1);
        q2 = minQ2;
        
        for k = maxQ3/2:-passo_q3:minQ3/2
            q3 = deg2rad(k);
            % Calcolo cinematica diretta
            [x,y,z] = cinematica_diretta(q1,q2,q3,L);
            % Inserimento terna calcolata
            X(m) = x;
            Y(m) = y;
            Z(m) = z;
            % Incremento indice
            m = m + 1;
        end
        X(m) = X(m-1);
        Y(m) = 1.523;
        Z(m) = Z(m-1);
        
    else 
        q2 = maxQ2;
%         q1 = deg2rad(68.0919);
        q1 = pi/2;
        for k = minQ3/2:passo_q3:maxQ3/2 
            q3 = deg2rad(k);
            % Calcolo cinematica diretta
            [x,y,z] = cinematica_diretta(q1,q2,q3,L);
            % Inserimento terna calcolata
            X(m) = x;
            Y(m) = y;
            Z(m) = z;
            % Incremento indice
            m = m + 1;
        end
        
        for i = maxQ1:-passo_q1:0 
            q1 = deg2rad(i);
            q3 = 1.5075;
            q2 = maxQ2;
            % Calcolo cinematica diretta
            [x,y,z] = cinematica_diretta(q1,q2,q3,L);
            % Inserimento terna calcolata
            X(m) = x;
            Y(m) = y;
            Z(m) = z;
            % Incremento indice
            m = m + 1; 
        end
        
        X_tratto3 = [2.2028, 2.2079, 2.2117, 2.2152, 2.2218, 2.2248, 2.2270, 2.2283, 2.2288, 2.2283, 2.2270, 2.2248, 2.2180, 2.2117, 2.2079, 2.2028];
        Y_tratto3 = [-0.0048, -0.0348, -0.0045, 0.0227, -0.0322, -0.0164, -0.0050, 0.0019, 0.0042, 0.0019, -0.0050, -0.0164, -0.0520, -0.0045, -0.0348, -0.0048];
        Z_tratto3 = [-0.2853, -0.2533, -0.2312, -0.2054, -0.1445, -0.1104, -0.0746, -0.0376, 0, 0.0376,  0.0746, 0.1104, 0.1763, 0.2312, 0.2533, 0.2853];

        for i=0:15        
            X(m) = X_tratto3(end-i);
            Y(m) = Y_tratto3(end-i);
            Z(m) = Z_tratto3(end-i);
            m = m+1;
        end
            
                          
        for i = 0:passo_q1:maxQ1
            q1 = deg2rad(i);
            q3 = -1.5075;
            q2 = maxQ2;
            % Calcolo cinematica diretta
            [x,y,z] = cinematica_diretta(q1,q2,q3,L);
            % Inserimento terna calcolata
            X(m) = x;
            Y(m) = y;
            Z(m) = z;
            % Incremento indice
            m = m + 1; 
        end
        
        
        
        
        
        
    end



end