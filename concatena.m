function [T_tot,tt_tot] = concatena(tt_concat,T_concat)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione per la concatenazione degli istanti di tempo utilizzati per
    % formare il vettore totale dei tempi
    %
    % [T_tot,tt_tot] = concatena(tt_concat,T_concat)
    %
    % Input:
    %       tt_concat (array, float) : vettore contenente per ogni
    %       posizione un vettore di tempo
    %       T_concat (array, float) : vettore di tempi
    %
    % Return:
    %       tt_tot (array, float) : vettore di tempi concatenati
    %       T_tot (float) : durata di tt_tot
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    tt_tot = [];
    T_tot = T_concat(1);
    tt_tot = tt_concat(1,:);
    for i = 2:size(tt_concat,1)
        tt_tot = [tt_tot tt_concat(i,2:end)+T_tot];
        T_tot = T_tot + T_concat(i);
    end
end