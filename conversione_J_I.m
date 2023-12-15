function I = conversione_J_I(J,m,G)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione che calcola velocita' e accelerazione dei giunti
    %
    % [Q_dot,Q_dot2] = calcola_vel_acc_giunti(S0_dot,S0_dot2,Q,L,J,J_dot)
    %
    %       S0_dot (array, float) : velocita' del gripper
    %       S0_dot2 (array, float) : accelerazione' del gripper
    %       Q (array,float) :  coordinate dei giunti
    %
    % Return :
    %       Q_dot : Velocita' dei giunti 
    %       Q_dot2 : Accelerazioni dei giunti calcolate mediante N.R.
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Commento
    % I: pseudo-tensore di inerzia
    % G: vettore contenente coordinate baricentro (xg,yg,zg)
    %%%%%%%%%%
    
    I = zeros(4,4);
    
    I(1,1) = (-J(1,1)+J(2,2)+J(3,3))/2;
    I(2,2) = (-J(2,2)+J(3,3)+J(1,1))/2;
    I(3,3) = (-J(3,3)+J(1,1)+J(2,2))/2;
    
    I(1,2) = -J(1,2);
    I(2,1) = I(1,2);
    I(2,3) = -J(2,3);
    I(3,2) = I(2,3);
    I(3,1) = -J(3,1);
    I(1,3) = I(3,1);
    
    I(4,1) = m*G(1);
    I(1,4) = I(4,1);
    I(4,2) = m*G(2);
    I(2,4) = I(4,2);
    I(4,3) = m*G(3);
    I(3,4) = I(4,3);
    
    I(4,4) = m;
    
    
    
end

