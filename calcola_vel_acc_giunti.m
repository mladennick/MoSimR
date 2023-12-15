function [Q_dot,Q_dot2] = calcola_vel_acc_giunti(S0_dot,S0_dot2,Q,L,J,J_dot)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione che calcola velocita' e accelerazione dei giunti
    % [Q_dot,Q_dot2] = calcola_vel_acc_giunti(S0_dot,S0_dot2,Q,L,J,J_dot)
    %
    % Input:
    %       S0_dot (array, float): velocita' del gripper
    %       S0_dot2 (array, float): accelerazione' del gripper
    %       Q (array,float):  posizione dei giunti
    %
    % Return:
    %       Q_dot: Velocita' dei giunti 
    %       Q_dot2: Accelerazioni dei giunti 
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Calcolo Jacobiano numerico da simbolico 
    Jac = converti_jacobiano_simbolico_numerico(J,Q(1:3, 1),[0;0;0],L,1);
    
    % Calcolo velocita' giunti
    Q_dot = Jac\S0_dot';
    Q_dot = double(Q_dot);
    
    % Calcolo derivata Jabiano numerico da simbolico 
    Jac_dot = converti_jacobiano_simbolico_numerico(J_dot,Q(1:3, 1),Q_dot,L,2);
    
    % Calcolo accelerazione giunti
    Q_dot2 = Jac\(S0_dot2' - Jac_dot * Q_dot);
    Q_dot2 = double(Q_dot2);
    
end