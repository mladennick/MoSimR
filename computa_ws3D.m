function [X,Y,Z] = computa_ws3D(minQ1,maxQ1,minQ2,maxQ2,minQ3,maxQ3,L,n)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione adibita alla computazione del working space in 3D
    %
    % Input : 
    %       minQ1,maxQ1,minQ2,maxQ2,minQ3,maxQ3 (float) : valori limite 
    %       delle coordinate dei giunti
    %       L (array,float) : vettore contenente la descrizione geometrica  
    %       del robot
    %       n (int) : numero punti di campionamento (default 50)
    %
    % Return:
    %       X,Y,Z (array,float) : terna contenente in ogni posizione un 
    %       valore di una possibile posizione del gripper
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calcolo passi
    n_punti = n;
    passo_q1 = abs(maxQ1 - minQ1)/n_punti;
    passo_q2 = abs(maxQ2 - minQ2)/n_punti;
    passo_q3 = abs(maxQ3 - minQ3)/n_punti;
    
    % Calcolo struttura relativa ai limiti 
    % [q1,q2,q3] = ndgrid(minQ1:passo_q1:maxQ1,minQ2:passo_q2:maxQ2,minQ3:passo_q3:maxQ3)
    
    % Inizializzazione vettori 
    X = [];
    Y = [];
    Z = [];
    
    % Indice terna i-esima
    m = 1;
    for i = minQ1:passo_q1:maxQ1
        q1 = deg2rad(i);
        for j = minQ2:passo_q2:maxQ2
            q2 = j;
            for k = minQ3:passo_q3:maxQ3
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
        end
    end
end