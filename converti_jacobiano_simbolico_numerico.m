function V = converti_jacobiano_simbolico_numerico(V,Q,Q_dot,L,scelta)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Converte lo Jacobiano da simbolico a numerico
    %
    % V = converti_jacobiano_simbolico_numerico(V,Q,Q_dot,L,scelta)
    %
    % Input : 
    %       V (array, simb) : Matrice simbolico
    %       Q (array, float) : vettore di valori numerici giunti da 
    %       sostituire a q1,q2,q3
    %       L (array, float) : descrizione geometrica del robot
    %       scelta (int) : selezione tra Jacobiano e Jacobiano derivato
    %       dove 1 --> Jacobiano e 2 --> Jacobiano derivato
    %       Q_dot (array, float) : vettore di valori numerici giunti da 
    %       sostituire a q1_dot,q2_dot,q3_dot
    
    % Return : 
    %       J_numerico (array, float) : Jacobiano convertito in numerico 
    %       con valori dei giunti e della descrizione geometrica del robot
    %       sostituiti al posto delle variabili simboliche
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    syms a b c d t q1(t) q2(t) q3(t) q1_dot(t) q2_dot(t) q3_dot(t)
    
    if scelta == 1
        V = subs(V, [q1(t),q2(t),q3(t),a,b,c,d], [Q(1),Q(2),Q(3),L(1),L(2),L(3),L(4)]);
%         V_numerico = vpa(V);
%         V_numerico = double(V_numerico);
    else
        V = subs(V, [q1(t),q2(t),q3(t),q1_dot(t),q2_dot(t),q3_dot(t),a,b,c,d], [Q(1),Q(2),Q(3),Q_dot(1),Q_dot(2),Q_dot(3),L(1),L(2),L(3),L(4)]);
%         V_numerico = vpa(V);
%         V_numerico = double(V_numerico);
    end

end