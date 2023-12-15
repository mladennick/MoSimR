function [L_12_1,L_23_2,L_34_3] = calcola_L
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione che ritorna le matrici L, utilizzate per il calcolo delle
    % matrici di velocita' e accelerazione
    % [L_12_1,L_23_2,L_34_3] = calcola_L
    %
    % Return :
    %       [L_12_1,L_23_2,L_34_3]: matrici L per ciascun link
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    L_12_1 = [0 -1 0 0 ;1 0 0 0;0 0 0 0;0 0 0 0];
    L_23_2 = [0 0 0 1;0 0 0 0;0 0 0 0;0 0 0 0];
    L_34_3 = [0 0 0 0;0 0 -1 0;0 1 0 0;0 0 0 0];
end