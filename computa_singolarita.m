function Q_sing = computa_singolarita(minQ1,maxQ1,minQ2,maxQ2,minQ3,maxQ3,L,n,J)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione adibita alla computazione delle singolarita' tramite
    % procedura iterativa
    %
    % [Q_sing] = computa_singolarita(minQ1,maxQ1,minQ2,maxQ2,minQ3,maxQ3,L,n,J)
    %
    % Input : 
    %       minQ1,maxQ1,minQ2,maxQ2,minQ3,maxQ3 (float) : valori limite 
    %       delle coordinate dei giunti
    %       L (array,float) : vettore contenente la descrizione geometrica  
    %       del robot
    %       n (int) : numero punti di campionamento (default 50)
    %       J (array, simb) : Jacobiano simbolico
    %
    % Return:
    %       X,Y,Z (array,float) : terna contenente in ogni posizione un 
    %       valore di una possibile posizione del gripper
    %
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
    detJ = det(J);
    syms a b c d t q1(t) q2(t) q3(t) 
    
    % Indice terna i-esima
    m = 1;
    for i = minQ1:passo_q1:maxQ1
        i_q1 = deg2rad(i);
        for j = minQ2:passo_q2:maxQ2
            j_q2 = j;
            for k = minQ3:passo_q3:maxQ3
                k_q3 = deg2rad(k);
                
                
                
                detJ_sostiuito = subs(detJ,[q1(t),q2(t),q3(t),a,b,c,d], [i_q1,j_q2,k_q3,L(1),L(2),L(3),L(4)]);
                detJ_sostiuito_numerico = vpa(detJ_sostiuito);
                detJ_sostiuito_numerico = double(detJ_sostiuito_numerico);
                
%                 fprintf('Computando: %f %f %f \n',i,j,k);
                
                
                if(abs(detJ_sostiuito_numerico)< 10^(-17))
                    fprintf('Trovata configurazione singolare: %f %f %f \n',i,j, k);
                    
                    Q_sing(m,:) = [i_q1,j_q2,k_q3];
                    
                    % Incremento indice
                    m = m + 1;
                    
                    
                end
                
                
            end
        end
    end
end