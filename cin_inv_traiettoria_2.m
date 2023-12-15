function [Q, Q_dot, Q_dot2] = cin_inv_traiettoria_2(S,S_dot,S_dot2,J,J_dot,init,L,limiti_min,limiti_max)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione che calcola la cinematica inversa relativa a una traiettoria
    %
    % [Q, Q_dot, Q_dot2] = cin_inv_traiettoria_2(S,S_dot,S_dot2,J,J_dot,init,L,limiti_min,limiti_max)
    %
    % Input :
    %       S (array, float) = posizione del gripper nello spazio di lavoro
    %                          [x,y,z]
    %       S_dot (array, float) : velocita' del gripper nello spazio di lavoro
    %                              [v_x,v_y,v_z]
    %       S_dot2 (array, float) : accelerazione del gripper nello spazio di lavoro
    %                              [a_x,a_y,a_z]
    %       J (array, symb) : jacobiano simbolico
    %       J_dot (array, symb): derivata temporale jacobiano simbolico
    %       init : condizione iniziale di  per la computazione numerica
    %       L (array, float) : descrizione geometrica del robot
    %       limiti_min (array,float): limiti posizioni minime
    %       limiti_max (array,float): limiti posizioni massime
    %
    % Return :
    %       Q (array, float) : posizioni dei giunti
    %       Q_dot (array, float) : velocita' dei giunti
    %       Q_dot2 : accelerazioni dei giunti
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    n = size(S,2);
    
    % Inizializzazione vettori
    Q = zeros(3,n);
    Q_dot = zeros(3,n);
    Q_dot2 = zeros(3,n);
    
    l = 0;
    % Posizione
    for i=n:-1:1      
        fprintf("Iterazione %d \n",i);
        if l == 0
            Q(:,i) = cinematica_inversa_NR2(S(:,i),init,L,J,limiti_min,limiti_max);
            l = 1;
        else
            init = Q(:,i+1)';
            Q(:,i) = cinematica_inversa_NR2(S(:,i),init,L,J,limiti_min,limiti_max);
        end
        [Q_dot(:,i),Q_dot2(:,i)] = calcola_vel_acc_giunti(S_dot(:,i)',S_dot2(:,i)',Q(:,i),L,J,J_dot);
    end
    
end

