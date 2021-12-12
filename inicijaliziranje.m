% Skripta za inicijaliziranje serijskog porta za komunikaciju sa mob.
% robotom

global s1
delete(instrfind)
%s1=serial('/dev/ttyS0','BaudRate',9600);
s1=serial('COM7','BaudRate',9600);
s1.InputBufferSize=1;
s1.Terminator='';
s1.Timeout=1;
fopen(s1);

