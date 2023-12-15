function W = calcola_W_num(giunto,q,q_dot,L)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione per il calcolo delle matrici di velocit� numeriche, che
    % permettono di ottenere la velocita' assoluta del link selezionato
    % W = calcola_W_num(giunto,q,L)
    %
    % Input:
    %       giunto (float): giunto selezionato 
    %                        (1: link b, 2: link c, 3: link d) 
    %       q (array,float): posizione dei giunti 
    %       q_dot (array,float): velocita' dei giunti
    %       L (array, float): descrizione geometrica del robot
    %
    % Return :
    %       W : matrice di posizione desiderata
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    M_01 = [1 0 0 L(1); 0 1 0 0; 0 0 1 0; 0 0 0 1];
    M_02 = calcola_M_num(1,q,L);
    M_03 = calcola_M_num(2,q,L);
    
    [L_12_1,L_23_2,L_34_3] = calcola_L;
    
    W_01_0 = zeros(4);
        
    W_12_1 = L_12_1*q_dot(1);
    W_12_0 = M_01*W_12_1*inv(M_01);
    W_02_0 = W_01_0 + W_12_0;
    
    W_23_2 = L_23_2*q_dot(2); 
    W_23_0 = M_02*W_23_2*inv(M_02);
    W_03_0 = W_01_0 + W_12_0 + W_23_0; 
    
    % End-effector
    W_34_3 = L_34_3*q_dot(3);
    W_34_0 = M_03*W_34_3*inv(M_03);
    W_04_0 = W_01_0 + W_12_0 + W_23_0+W_34_0;
    
    if giunto == 1
        W = W_02_0;
    elseif giunto == 2
        W = W_03_0;
    else
        W = W_04_0;        
    end
    
end




