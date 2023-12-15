function [J,J_dot] = jacobiano
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Funzione che calcola lo jacobiano e la derivata temporale utilizzando
    % variabili simboliche.
    %
    % Input : 
    %       None
    %
    % Return : 
    %       J = Jacobiano
    %       J_dot = derivata temporale dello Jacobiano
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    syms t a b c d  q1(t) q2(t) q3(t) q1_dot(t) q2_dot(t) q3_dot(t)

    % Parte commentata: calcoli precedenti per trovare lo jacobiano J
    %  f1 = (b+c+q2) *cos(q1) - d*cos(q3)*sin(q1) + a;
    %  f2 = (b+c+q2) * sin(q1) + d*cos(q3)*cos(q1);
    %  f3 = d*sin(q3);

    % J = jacobian([f1,f2,f3],[q1,q2,q3]);

    J = [[ - sin(q1(t))*(b + c + q2(t)) - d*cos(q1(t))*cos(q3(t)), cos(q1(t)),  d*sin(q1(t))*sin(q3(t))];...
    [   cos(q1(t))*(b + c + q2(t)) - d*cos(q3(t))*sin(q1(t)), sin(q1(t)), -d*cos(q1(t))*sin(q3(t))];...
    [                                          0,       0,          d*cos(q3(t))]];

    J_dot = diff(J,t);
    J_dot = subs(J_dot, [diff(q1(t), t), diff(q2(t), t), diff(q3(t),t)], [q1_dot(t) q2_dot(t) q3_dot(t)]);
end