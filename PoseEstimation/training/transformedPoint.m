function transPoint = transformedPoint(privit,origPoint,scale,angle,origImg)

% w = 730;
% h = 1738;

% a = size(origImg,1);
% b = size(origImg,2);
a = 1080;
b = 1920;
%rotate = [0,sin(angle);-sin(angle),0];
rotate1 = [cos(angle), sin(angle);-sin(angle), cos(angle)];
rotate2 = [cos(angle), sin(angle);sin(angle), cos(angle)];
transPoint = ((inv(rotate1)*(origPoint'+(privit/2)'-[a/2;b/2]*scale))+[b/2;a/2]*scale)*inv(scale);
%transPoint = ((inv(rotate1)*(origPoint'+(privit/2)'-rotate2*[b/2;a/2]*scale))+[b/2;a/2]*scale)*inv(scale);
% point1 = rotate*(point1'/scale-[a/2;b/2]*scale)+[b/2;a/2]*scale-(privit/2)';
