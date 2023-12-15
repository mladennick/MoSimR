function c = pseudo_scalar_product(A,B)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % Funzione che calcola lo pseudo prodotto scalare tra due matrici A e B
    % in ingresso
    % c = pseudo_scalar_product(A,B)
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    c = 0;
    c = A(1,4)*B(1,4) + A(2,4)*B(2,4) + A(3,4)*B(3,4) + A(3,2)*B(3,2) + A(1,3)*B(1,3) + A(2,1)*B(2,1);
end

