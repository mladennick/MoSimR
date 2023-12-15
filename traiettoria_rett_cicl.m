function [x,y,z,v_x,v_y,v_z,a_x,a_y,a_z] = traiettoria_rett_cicl(S_i,S_f,T,n)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione per il calcolo di posizione, velocita' e accelerazione del
    % gripper nel working space con traiettoria rettilinea e legge di moto
    % cicloidale
    %
    % [x,y,z,v_x,v_y,v_z,a_x,a_y,a_z] = traiettoria_rett_cicl(S_i,S_f,T,n)
    %
    % Input:
    %       S_i (array,float) : punto iniziale (nel working space)
    %       S_f (array,float) : punto finale (nel working space)
    %       T (float) : tempo di attuazione
    %       n (int): numero di punti della legge di moto
    % Return:
    %       x,y,z (array,float): posizione del gripper nel working space
    %       v_x, v_y, v_z (array,float): velocita' del gripper nel working 
    %       space
    %       a_x, a_y, a_z (array,float): accelerazione del gripper nel 
    %       working space
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Inizializzazione vettori tramite preallocazione per ottimizzare i 
    % tempi di calcolo
    
    x = zeros(1,n);
    v_x =  zeros(1,n);
    a_x =  zeros(1,n);
    y = zeros(1,n);
    v_y =  zeros(1,n);
    a_y =  zeros(1,n);
    z = zeros(1,n);
    v_z =  zeros(1,n);
    a_z =  zeros(1,n);
    
    % Passo temporale e vettore tempo
    dT = T/(n-1);   
    tt = 0:dT:T; 
    
    % Moto lungo x
    xi = S_i(1);  
    xf = S_f(1); 
    dx = xf-xi; % moto totale
    
    % Moto lungo y
    yi = S_i(2);  
    yf = S_f(2); 
    dy = yf-yi; % moto totale
    
    % Moto lungo z
    zi = S_i(3);  
    zf = S_f(3); 
    dz = zf-zi; % moto totale

    % Calcolo legge
    for i=1:n
        [x(i),v_x(i),a_x(i)] = cicloidale(tt(i),T,xi,dx);
        [y(i),v_y(i),a_y(i)] = cicloidale(tt(i),T,yi,dy);
        [z(i),v_z(i),a_z(i)] = cicloidale(tt(i),T,zi,dz);
    end
end

