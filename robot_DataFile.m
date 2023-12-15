% Simscape(TM) Multibody(TM) version: 7.0

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(7).translation = [0.0 0.0 0.0];
smiData.RigidTransform(7).angle = 0.0;
smiData.RigidTransform(7).axis = [0.0 0.0 0.0];
smiData.RigidTransform(7).ID = '';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(1).translation = [668.7384981024112 0 -25.000000000000021];  % mm
smiData.RigidTransform(1).angle = 0;  % rad
smiData.RigidTransform(1).axis = [0 0 0];
smiData.RigidTransform(1).ID = 'B[Parte_a-1:-:Parte_b-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [-100.00000000000074 -4.6851411639181606e-14 -25.000000000000142];  % mm
smiData.RigidTransform(2).angle = 2.9397214783836431e-16;  % rad
smiData.RigidTransform(2).axis = [-0.0076006929058279587 -0.99997111431648433 1.1171637383226824e-18];
smiData.RigidTransform(2).ID = 'F[Parte_a-1:-:Parte_b-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [0 0 0];  % mm
smiData.RigidTransform(3).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(3).axis = [0.57735026918962584 0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(3).ID = 'B[Parte_b-1:-:Parte_c-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
% smiData.RigidTransform(4).translation = [-3.2085022476126257 -2.6728619317850644e-14 -9.431830518007615e-16];  % mm
smiData.RigidTransform(4).translation = [0 -2.6728619317850644e-14 -9.431830518007615e-16];
smiData.RigidTransform(4).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(4).axis = [0.57735026918962573 0.57735026918962573 0.57735026918962573];
smiData.RigidTransform(4).ID = 'F[Parte_b-1:-:Parte_c-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [980.00000000000034 0 0];  % mm
smiData.RigidTransform(5).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(5).axis = [-0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(5).ID = 'B[Parte_c-1:-:Parte_d-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [-5.6839551342202918e-12 6.754196230408255e-14 -1.1434611836336245e-13];  % mm
smiData.RigidTransform(6).angle = 2.0943951023931957;  % rad
smiData.RigidTransform(6).axis = [-0.57735026918962584 -0.57735026918962573 0.57735026918962573];
smiData.RigidTransform(6).ID = 'F[Parte_c-1:-:Parte_d-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [-706.56548933514875 -3.5533678450844133 740.36000000000001];  % mm
smiData.RigidTransform(7).angle = 0;  % rad
smiData.RigidTransform(7).axis = [0 0 0];
smiData.RigidTransform(7).ID = 'RootGround[Parte_a-1]';


%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(4).mass = 0.0;
smiData.Solid(4).CoM = [0.0 0.0 0.0];
smiData.Solid(4).MoI = [0.0 0.0 0.0];
smiData.Solid(4).PoI = [0.0 0.0 0.0];
smiData.Solid(4).color = [0.0 0.0 0.0];
smiData.Solid(4).opacity = 0.0;
smiData.Solid(4).ID = '';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(1).mass = 4.1426282582420129;  % kg
smiData.Solid(1).CoM = [0.066545858852778056 126.97711868146824 0];  % mm
smiData.Solid(1).MoI = [49792.68134088115 6152.7464220403681 47827.169430333095];  % kg*mm^2
smiData.Solid(1).PoI = [0 0 35.00438612787935];  % kg*mm^2
smiData.Solid(1).color = [0.52941176470588236 0.5490196078431373 0.5490196078431373];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = 'Parte_d*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 18.435201057446516;  % kg
smiData.Solid(2).CoM = [457.90815749040854 -0.56372494232552972 -1.0934793215993329e-09];  % mm
smiData.Solid(2).MoI = [93432.590053295149 1632961.7288452999 1633630.9189905212];  % kg*mm^2
smiData.Solid(2).PoI = [-9.9421060883421574e-07 1.7103657557651673e-08 -2396.2784323933902];  % kg*mm^2
smiData.Solid(2).color = [0.52941176470588236 0.5490196078431373 0.5490196078431373];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = 'Parte_c*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(3).mass = 21.553715158063781;  % kg
smiData.Solid(3).CoM = [109.56332013354361 -0.62425432930366931 0];  % mm
smiData.Solid(3).MoI = [114580.50430817029 629242.5628930215 641754.46260792809];  % kg*mm^2
smiData.Solid(3).PoI = [-0.0033477450166427103 0 1580.1105276031581];  % kg*mm^2
smiData.Solid(3).color = [0.52941176470588236 0.5490196078431373 0.5490196078431373];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = 'Parte_b*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(4).mass = 40.015532994254912;  % kg
smiData.Solid(4).CoM = [370.64787207923337 0 -1.3358006870434401e-12];  % mm
smiData.Solid(4).MoI = [302565.13895194524 2146586.401655667 2142856.8160225893];  % kg*mm^2
smiData.Solid(4).PoI = [0.4827148651905952 7.4402143036473698e-09 1.073682921836747e-08];  % kg*mm^2
smiData.Solid(4).color = [0.52941176470588236 0.5490196078431373 0.5490196078431373];
smiData.Solid(4).opacity = 1;
smiData.Solid(4).ID = 'Parte_a*:*Default';


%============= Joint =============%
%X Revolute Primitive (Rx) %Y Revolute Primitive (Ry) %Z Revolute Primitive (Rz)
%X Prismatic Primitive (Px) %Y Prismatic Primitive (Py) %Z Prismatic Primitive (Pz) %Spherical Primitive (S)
%Constant Velocity Primitive (CV) %Lead Screw Primitive (LS)
%Position Target (Pos)

%Initialize the PrismaticJoint structure array by filling in null values.
smiData.PrismaticJoint(1).Pz.Pos = 0.0;
smiData.PrismaticJoint(1).ID = '';

smiData.PrismaticJoint(1).Pz.Pos = 0;  % m
smiData.PrismaticJoint(1).ID = '[Parte_b-1:-:Parte_c-1]';


%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(2).Rz.Pos = 0.0;
smiData.RevoluteJoint(2).ID = '';

smiData.RevoluteJoint(1).Rz.Pos = 0;  % deg
smiData.RevoluteJoint(1).ID = '[Parte_a-1:-:Parte_b-1]';

smiData.RevoluteJoint(2).Rz.Pos = 0;  % deg
smiData.RevoluteJoint(2).ID = '[Parte_c-1:-:Parte_d-1]';

