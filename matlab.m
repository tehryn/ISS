%ukol 1
[y,Fs] = audioread('xmatej52.wav');
%Fs vzorkovaci frekvence 16000
N = numel(y);
%N pocet vzorku 16000
t = N ./ Fs;
%t cas 1 s

%ukol 2
freq = linspace(0, Fs/2-1, Fs/2);
ydft = fft(y);
m = abs(ydft);
plot(freq,m(1:Fs/2));
title('Magnitude of Fourier transform');
xlabel 'Frequency [Hz]';

%ukol3
idx = find(m == max(m)); %414 a 15588

%ukol4
b0 = 0.2324;
b1 = -0.4112;
b2 = 0.2324;
a1 = 0.2289;
a2 = 0.4662;
b = [b0 b1 b2];
a = [1.0 a1 a2];
fvtool(b,a,'polezero'); %stabilni

%ukol5
fvtool(b,a,'magnitude'); %horni propust

%ukol6
x = filter(b, a, y);
xdft = fft(x);
xm = abs(xdft);
plot(freq, xm(1:Fs/2));
title('Magnitude of Fourier transform');
xlabel 'Frequency [Hz]';

%ukol7
xidx = find(xm == max(xm)); %5854 a 10148

%ukol8
new_signal = square(0:pi/4:80*pi);
new_signal = new_signal(1:(length(new_signal) - 1));
plot(xcorr(y, new_signal));

%ukol9
[R, lag] = xcorr(y, 'biased');
plot(lag, R);
title('Correlation');
xlim([-50 50]);

% ukol 10
ridx = find(R == max(R)); % nalezneme R(0) v grafu
R10 = R(ridx + 10); % - 0.0054

%ukol 11
graph = zeros(20);
mat = zeros(10, 1);
y_x = cat(1, mat, y) * 10;
y_y = cat(1, y, mat) * 10;
vec_x = 0;
vec_y = 0;
for i = 1:(N+10)
  vec_x = round(y_x(i)) + 11;
  vec_y = round(y_y(i)) + 11;
  graph(vec_y, vec_x) = graph(vec_y, vec_x) + 1;
end
graph = graph/(N+10);
surf(-1:0.1:0.9, -1:0.1:0.9, graph);

%ukol 12
check = sum(sum(graph, 2)); %1

%ukol 13
[x_matrix, y_matrix] = meshgrid(-1:0.1:0.9, -1:0.1:0.9);
check = sum(sum(graph .* (x_matrix .* y_matrix), 2)); % -0.0056
