function plot_da_coordinateXYZ(X,Y,Z)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione adibita al plot del working space in 3D
    %
    % Input : 
    %       X,Y,Z (array, float) : terne di valori da plottare
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    scatter3(X,Z,Y,'.');
    xlabel('x');
    ylabel('z');
    zlabel('y');
end