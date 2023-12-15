function M = calcola_M_num(giunto,q,L)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione per il calcolo delle matrici di posizione numeriche, che
    % permettono di ottenere la posizione assoluta del link selezionato
    % M = calcola_M_num(giunto,q,L)
    %
    % Input:
    %       giunto (float): giunto selezionato 
    %                        (1: link b, 2: link c, 3: link d) 
    %       q (array,float): posizione dei giunti 
    %       L (array, float): descrizione geometrica del robot
    %
    % Return :
    %       M : matrice di posizione desiderata
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    a = L(1);
    b = L(2);
    c = L(3);
    d = L(4);
    
    M_01 = [1 0 0 a; 0 1 0 0; 0 0 1 0; 0 0 0 1];
    M_12 = [cos(q(1)) -sin(q(1)) 0 b*cos(q(1)); sin(q(1)) cos(q(1)) 0 b*sin(q(1));0 0 1 0;0 0 0 1]; 
    M_02 = M_01*M_12;
    M_23 = [1 0 0 c+q(2);0 1 0 0;0 0 1 0;0 0 0 1]; 
    M_03 = M_01*M_12*M_23;
    M_34 = [1 0 0 0;0 cos(q(3)) -sin(q(3)) d*cos(q(3));0 sin(q(3)) cos(q(3)) d*sin(q(3));0 0 0 1];      
    M_04 = M_01*M_12*M_23*M_34;
    
    if giunto == 1
        M = M_02; 
    elseif giunto == 2
        M = M_03;
    else
        M = M_04;      
    end
    
    
end

