function H = calcola_H_num(giunto,q,q_dot,q_dot2,L)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione per il calcolo delle matrici di accelerazione numeriche, che
    % permettono di ottenere l'accelerazione assoluta del link selezionato
    % H = calcola_H_num(giunto,q,q_dot,q_dot2,L)
    %
    % Input:
    %       giunto (float): giunto selezionato 
    %                        (1: link b, 2: link c, 3: link d) 
    %       q (array,float): posizione dei giunti 
    %       q_dot (array,float): velocita' dei giunti 
    %       q_dot2 (array,float): vettore accelerazione dei giunti 
    %       L (array, float): descrizione geometrica del robot
    %
    % Return :
    %       H : matrice di accelerazione desiderata
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Matrici di posizione
    M_01 = [1 0 0 L(1); 0 1 0 0; 0 0 1 0; 0 0 0 1];
    M_02 = calcola_M_num(1,q,L);
    M_03 = calcola_M_num(2,q,L);
    
    [L_12_1,L_23_2,L_34_3] = calcola_L;
    
    % Matrici di velocita'
    W_01_0 = zeros(4);
        
    W_12_1 = L_12_1*q_dot(1);
    W_12_0 = M_01*W_12_1*inv(M_01);
    W_02_0 = W_01_0 + W_12_0;
    
    W_23_2 = L_23_2*q_dot(2); 
    W_23_0 = M_02*W_23_2*inv(M_02);
    W_03_0 = W_01_0 + W_12_0 + W_23_0; 
    
    W_34_3 = L_34_3*q_dot(3);
    W_34_0 = M_03*W_34_3*inv(M_03);
    
    % Matrici di accelerazione
    H_12_1 = (L_12_1^2)*(q_dot(1)^2)+L_12_1*q_dot2(1);
    H_23_2 = (L_23_2^2)*(q_dot(2)^2)+L_23_2*q_dot2(2);
    H_34_3 = (L_34_3^2)*(q_dot(3)^2)+L_34_3*q_dot2(3);
    
    H_12_0 = M_01*H_12_1*inv(M_01);
    H_23_0 = M_02*H_23_2*inv(M_02);
    H_34_0 = M_03*H_34_3*inv(M_03);
    
    H_01_0 = zeros(4);
    H_02_0 = H_01_0+H_12_0+2*W_01_0*W_12_0;
    H_03_0 = H_02_0+H_23_0+2*W_02_0*W_23_0;
    H_04_0 = H_03_0+H_34_0+2*W_03_0*W_34_0;
    
    if giunto == 1
        H = H_02_0;
    elseif giunto == 2
        H = H_03_0;
    else
        H = H_04_0;
    end
    
    
end




