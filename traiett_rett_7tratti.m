function [x,y,z,v_x,v_y,v_z,a_x,a_y,a_z] = traiett_rett_7tratti(S_i,S_f,T,n,v0,vf,a0,af,K)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione per il calcolo di posizione, velocita' e accelerazione del
    % gripper nel working space con traiettoria rettilinea e legge di moto
    % 7 tratti
    %
    % [x,y,z,v_x,v_y,v_z,a_x,a_y,a_z] = traiett_rett_7tratti(S_i,S_f,T,v_0,v_f,a_0,a_f,K)
    %
    % Input:
    %       S_i (array,float) : punto iniziale (nel working space)
    %       S_f (array,float) : punto finale (nel working space)
    %       T (float) : tempo di attuazione
    %       n (int): numero di punti della legge di moto
    %       v0 (float): velocita' iniziale
    %       vf (float): velocita' finale
    %       a0 (float): accelerazione iniziale
    %       af (float): accelerazione finale
    %       K (array,float): vettore contenente i coefficienti della legge
    %       di moto
    % Return:
    %       x,y,z (array,float): posizione del gripper nel working space
    %       v_x, v_y, v_z (array,float): velocita' del gripper nel working 
    %       space
    %       a_x, a_y, a_z (array,float): accelerazione del gripper nel 
    %       working space
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Calcolo dei coefficienti L della legge di moto
    somma_K = 0;
    for i=1:7
        somma_K = somma_K+K(i);
    end
    
    L1=K(1)*T/somma_K;
    L2=K(2)*T/somma_K;
    L3=K(3)*T/somma_K;
    L4=K(4)*T/somma_K;
    L5=K(5)*T/somma_K;
    L6=K(6)*T/somma_K;
    L7=K(7)*T/somma_K;
    
    % 
    dS = S_f-S_i;
    [sc_x,vc_x,A_x,D_x] = settetratti_generica_coeff(T,S_i(1),dS(1),v0(1),vf(1),a0(1),af(1),L1,L2,L3,L4,L5,L6,L7);
    [sc_y,vc_y,A_y,D_y] = settetratti_generica_coeff(T,S_i(2),dS(2),v0(2),vf(2),a0(2),af(2),L1,L2,L3,L4,L5,L6,L7);
    [sc_z,vc_z,A_z,D_z] = settetratti_generica_coeff(T,S_i(3),dS(3),v0(3),vf(3),a0(3),af(3),L1,L2,L3,L4,L5,L6,L7);

    %
    dT = T/(n-1);
    tt = [0:dT:T];
    
    for i=1:n
        t=tt(i);
        [x(i),v_x(i),a_x(i)] = settetratti_generica(t,T,S_i(1),dS(1),v0(1),vf(1),a0(1),af(1),L1,L2,L3,L4,L5,L6,L7,sc_x,vc_x,A_x,D_x);
        [y(i),v_y(i),a_y(i)] = settetratti_generica(t,T,S_i(2),dS(2),v0(2),vf(2),a0(2),af(2),L1,L2,L3,L4,L5,L6,L7,sc_y,vc_y,A_y,D_y);
        [z(i),v_z(i),a_z(i)] = settetratti_generica(t,T,S_i(3),dS(3),v0(3),vf(3),a0(3),af(3),L1,L2,L3,L4,L5,L6,L7,sc_z,vc_z,A_z,D_z);
    end
    
    
end

