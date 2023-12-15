function [theta,Ek,Ep,W_tot] = dinamica_inv(Q, Q_dot, Q_dot2, l, n_link,n,phi_ext,I,Hg)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [outputArg1,outputArg2] = dinamica_inv(Q, Q_dot, Q_dot2, I, L, n_link)
% phi = azioni esterne sulla mano RIFERITE ALLA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione per il calcolo della cinematica inversa. 
    %
    % Q = cinematica_inversa_NR2(S0,Q0,L,J,limiti_inf,limiti_sup)
    % 
    % Input : 
    %       Q (array, float) : posizioni giunti
    %       Q_dot (array,float) : velocita' giunti
    %       Q_dot2 (array,float) : accelerazioni giunti
    %       l (array, float) : vettore contenente la descrizione geometrica 
    %       del robot
    %       n_link (int) : numero di link del robot
    %       n (int) : numero di passi per la computazione
    %       phi_ext (array, float): azioni esterne sulla mano 
    %       I (array, float) : pseudo tensori di inerzia concatenati in un
    %       array a 3 dimensioni
    %       Hg (array, float) : matrice gravita'
    %
    % Return : 
    %       theta (array, float) : risultato dinamica inversa
    %       Ek,Ep,W_tot (array, float) : energia cinetica, potenziale e
    %       potenza totale
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    L=[];
    [L_12_1,L_23_2,L_34_3] = calcola_L;
           
    phi = [];
    J_0 = [];
    phi_star = [];
    
    for t=1:n
        
%         CINEMATICA
%         M = calcola_M_num(n_link-1,Q(:,t),l);
%         W = calcola_W_num(n_link-1,Q(:,t),Q_dot(:,t),l);
%         P(:,t) = M(:,4);
%         P_dot(:,t) = W*P(:,t);
%         P_dot2(:,t) = H(:,:,n_link-1)*P(:,t);

        M_01 = [1 0 0 l(1); 0 1 0 0; 0 0 1 0; 0 0 0 1];
        M_12 = [cos(Q(1,t)) -sin(Q(1,t)) 0 l(2)*cos(Q(1,t)); sin(Q(1,t)) cos(Q(1,t)) 0 l(2)*sin(Q(1,t));0 0 1 0;0 0 0 1]; 
        M_02 = M_01*M_12;
        M_23 = [1 0 0 l(3)+Q(2,t);0 1 0 0;0 0 1 0;0 0 0 1]; 
        M_03 = M_01*M_12*M_23;

        L(:,:,1) = M_01*L_12_1*inv(M_01);
        L(:,:,2) = M_02*L_23_2*inv(M_02);
        L(:,:,3) = M_03*L_34_3*inv(M_03);
        
        % DINAMICA
        phi_star = [];
        M_04 = calcola_M_num(3,Q(:,t),l);
        M_0A = [eye(3); 0 0 0];
        M_0A = [M_0A,M_04(:,4)];
        phi_star(:,:,n_link) = M_0A*phi_ext*M_0A';

        phi = [];
        
        for i = n_link-1:-1:1
            H_0i = calcola_H_num(i,Q(:,t),Q_dot(:,t), Q_dot2(:,t),l);
            W_0i(:,:,i) = calcola_W_num(i,Q(:,t),Q_dot(:,t),l);
            M_0i = calcola_M_num(i,Q(:,t),l);
            J_0(:,:,i) = M_0i*I(:,:,i)*M_0i';
            
            % Calcolo forze d'inerzia e peso link i
            phi(:,:,i) = -skew((H_0i*J_0(:,:,i)))+skew((Hg*J_0(:,:,i)));
            
            % Calcolo azioni motrici e vincolari sul link i
            phi_star(:,:,i) = phi(:,:,i)+phi_star(:,:,i+1);
            theta(t,i) = -pseudo_scalar_product(phi_star(:,:,i),L(:,:,i));
            
            % Quantita' per debug
            Ek_i(t,i) = 0.5*trace(W_0i(:,:,i)*J_0(:,:,i)*W_0i(:,:,i)'); % Energia cinetica
            Ep_i(t,i) = -trace(Hg*J_0(:,:,i)); % Energia potenziale
            
        end
        
        Ek(t) = Ek_i(t,1)+Ek_i(t,2)+Ek_i(t,3);
        Ep(t) = Ep_i(t,1)+Ep_i(t,2)+Ep_i(t,3);
        
        ww1(t) = -pseudo_scalar_product(phi_star(:,:,3),(W_0i(:,:,3)-W_0i(:,:,2)));
        ww2(t) = -pseudo_scalar_product(phi_star(:,:,2),(W_0i(:,:,2)-W_0i(:,:,1)));
        ww3(t) = -pseudo_scalar_product(phi_star(:,:,1),(W_0i(:,:,1)));
        ww4(t) = -pseudo_scalar_product(phi_star(:,:,n_link),(W_0i(:,:,3)));
        W_tot(t) = ww1(t)+ww2(t)+ww3(t)+ww4(t);

        
    end
end

