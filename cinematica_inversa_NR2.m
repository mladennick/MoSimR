function Q = cinematica_inversa_NR2(S0,Q0,L,J,limiti_inf,limiti_sup)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione per il calcolo della cinematica inversa. 
    %
    % Q = cinematica_inversa_NR2(S0,Q0,L,J,limiti_inf,limiti_sup)
    % 
    % Input : 
    %       S0 (array, float) : coordinata del gripper
    %       Q0 (array,float) : punto di partenza delle coordinate dei
    %       giunti
    %       L (array, float) : vettore contenente la descrizione geometrica 
    %       del robot
    %       J (array, simb) : Jacobiano simbolico
    %       minQ1,maxQ1,minQ2,maxQ2 (float) : valori limite relativi ai
    %       movimenti dei giunti
    %       limiti_inf (array, float) : vettore contenente i limiti di
    %       movimentazione inferiore dei giunti in ordine 
    %       limiti_sup (array, float) : vettore contenente i limiti di
    %       movimentazione superiore dei giunti in ordine 
    %
    % Return : 
    %       Q : Posizioni dei giunti calcolate mediante N.R.
    %
    % Assegnare i limiti dei giunti in modo consecutivo i.e. 
    % limiti_sup = [maxQ1,maxQ2,....,maxQn].
    % Il vettore ritornato Q e' un vettore colonna, prestare attenzione ad
    % eventuale necessaria trasposizione del risultato a seguito dell'uso
    % di questa funzione.
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Assegnazione numero massimo di iterazioni e variabili di processo
    j = 1;
    jmax = 200;
    
    % Assegnazione coordinate gripper e dati iniziali dei giunti
    x = S0(1);
    y = S0(2);
    z = S0(3);
    Qi(1:3, j) = Q0; 
    
    
    % Set up tolleranza per uscita ciclo
    eps = 0.00001;
    
    % Set up limiti
    minQ1 = limiti_inf(1);
    maxQ1 = limiti_sup(1);
    minQ2 = limiti_inf(2);
    maxQ2 = limiti_sup(2);
    
    % Calcolo iniziale cinematica diretta con posizione iniziale assegnata
    [xs,ys,zs] = cinematica_diretta(Qi(1,j),Qi(2,j),Qi(3,j),L);
    S(1:3, j) = [xs,ys,zs]';
    
    % Ciclo N.R.
    
    
    try
        while(j<jmax) 

           % Calcolo Jacobiano numerico con valori dei giunti calcolati
           % all'iterazione precedente/iniziale
           Jac = converti_jacobiano_simbolico_numerico(J,Qi(1:3, j),[0 0 0],L,1);

           % Calcolo Q_j+1
           Qi(1:3, j+1) = Qi(1:3, j) + Jac^(-1) * ([x; y; z] - S(1:3, j)); % iteration step


           % Verifica di convergenza
           [xs,ys,zs] = cinematica_diretta(Qi(1,j+1),Qi(2,j+1),Qi(3,j+1),L);
           S(1:3, j+1) = [xs,ys,zs]';


           if(norm(S(1:3, j+1) - [x; y; z]) < eps) % condition for convergence
               if ((Qi(1, j+1) <= deg2rad(maxQ1) && Qi(1, j+1) >= deg2rad(minQ1)) && (Qi(2, j+1)>= minQ2 && Qi(2, j+1) <= maxQ2))
                   Q(1:3, 1) = Qi(1:3, j+1); % result
                   return
               end
           end       
           j = j+1;
        end
    catch
        warning('Errore');
    end
    warning('Probabile uscita dal workspace');
    Q = NaN;
    

    
end

