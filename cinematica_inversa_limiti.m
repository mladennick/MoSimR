function Q = cinematica_inversa_limiti(S,L,limiti_min,limiti_max)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione per il calcolo della cinematica inversa analitica
    % Q = cinematica_inversa(S,L)
    %
    % Input:
    %       S (array, float) : posizone del gripper
    %       L (array,float) : vettore contenente la descrizione geometrica 
    %
    % Return :
    %       Q : Posizioni dei giunti calcolate mediante N.R.
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    a = L(1);
    b = L(2);
    c = L(3);
    d = L(4);

    x = S(1);
    y = S(2);
    z = S(3);
    minQ1 = limiti_min(1);
    minQ2 = limiti_min(2);
    maxQ1 = limiti_max(1);
    maxQ2 = limiti_max(2);
    
    
    h = sqrt((x-a)^2+y^2);
    
    Q(3) = asin(z/d);
    Q(1) = asin(y/h)-asin((d*cos(asin(z/d)))/h);
    Q(2) = sqrt((x-a)^2+y^2-d^2*(cos(asin(z/d)))^2)-b-c;
    
    if(Q(1) < deg2rad(minQ1) || Q(1) > deg2rad(maxQ1) || Q(2) < minQ2 || Q(2) > maxQ2)
        warning("Attenzione potrebbero esserci degli errori nel calcolo del valore dei giunti secondo i limiti imposti");
    end
    
end

