function [W,xstart] = PNRFRead_2014_Doug(sweep)

%The program returns a struct (W) containing all of the waveform and time
%vectors. A single variable xstart provides the number of seconds since
%midnight at the beginning of the data segment. This number can be used to
%relate the times of waveform feature within the segment to other collected
%data. 


%%%%%%%%%%%%%%%%%%
%Perception Channel List 2014

% IIHi =  B1
% IIVL =  B2
% Idot =  B3

% dE1 =   B4
% dE3 =   C1
% dE4 =   C2
% dE5 =   C3
% dE7 =   C4
% dE8 =   D1
% dE9 =   D2
% dE11=   D3
% dE17=   D4
% dE25=   E1
% 
% T1F =   E2
% T3F =   E3
% T4F =   E4
% T5F =   F1
% T7F =   F2
% T8F =   F3
% T9F =   F4
% T11F=   G1
% Labr17 = G2

% PDN 50 m D-dot =      G3
% PDN 50 m B-dot NS =   G4
% ML 50 m B-dot EW =    H1
% ML 50 m B-dot NS =    H2
% ML 50 m B-dot V =     H3
% ML 50 m B-field EW =  H4
% ML 50 m B-field NS =  I1

% ML 100 m D-dot =      I2
% ML 100 m B-field EW = I3
% ML 100 m B-field NS = I4

% ML 200 m D-dot =      J1
% ML 200 m B-field EW = J2
% ML 200 m B-field NS = J3

% ML 300 m D-dot =      J4
% ML 300 m B-field EW = K1
% ML 300 m B-field NS = K2

% ML 400 m D-dot =      K3
% ML 400 m B-field EW = K4
% ML 400 m B-field NS = L1

% ML 500 m D-dot =      L2
% ML 500 m B-field EW = L3
% ML 500 m B-field NS = L4

% V711 Strobe =         M1
% OT APD =              M2


%Establish the Matlab COM server
FromDisk = actxserver('Perception.Loaders.pNRF');

% dir = 'C:\Users\jdhill5\Documents\UF\2014 Data';
% cd(dir);

[filename, pathName, FilterIndex] = uigetfile('*.pnrf','Multiselect','off');
cd(pathName);

%Load the entire recording
Data = FromDisk.LoadRecording(filename);

%Channel Base Current
IIHI = Data.Recorders.Item(1).Channels.Item(1).DataSource(2);
IIVL = Data.Recorders.Item(1).Channels.Item(2).DataSource(2);
IDOT = Data.Recorders.Item(1).Channels.Item(3).DataSource(2);

%Load all ten dE/dt channels from the recording using the sweep mode
dE1 = Data.Recorders.Item(1).Channels.Item(4).DataSource(2);
dE3 = Data.Recorders.Item(2).Channels.Item(1).DataSource(2);
dE4 = Data.Recorders.Item(2).Channels.Item(2).DataSource(2);
dE5 = Data.Recorders.Item(2).Channels.Item(3).DataSource(2);
dE7 = Data.Recorders.Item(2).Channels.Item(4).DataSource(2);
dE8 = Data.Recorders.Item(3).Channels.Item(1).DataSource(2);
dE9 = Data.Recorders.Item(3).Channels.Item(2).DataSource(2);
dE11 = Data.Recorders.Item(3).Channels.Item(3).DataSource(2);
dE17 = Data.Recorders.Item(3).Channels.Item(4).DataSource(2);
dE25 = Data.Recorders.Item(4).Channels.Item(1).DataSource(2);
 
%Load all nine fast x-ray channels
T1F = Data.Recorders.Item(4).Channels.Item(2).DataSource(2);
T3F = Data.Recorders.Item(4).Channels.Item(3).DataSource(2);
T4F = Data.Recorders.Item(4).Channels.Item(4).DataSource(2);
T5F = Data.Recorders.Item(5).Channels.Item(1).DataSource(2);
T7F = Data.Recorders.Item(5).Channels.Item(2).DataSource(2);
T8F = Data.Recorders.Item(5).Channels.Item(3).DataSource(2);
T9F = Data.Recorders.Item(5).Channels.Item(4).DataSource(2);
T11F = Data.Recorders.Item(6).Channels.Item(1).DataSource(2);
T17F = Data.Recorders.Item(6).Channels.Item(2).DataSource(2);

%50 m Station
PDNDdot50 = Data.Recorders.Item(6).Channels.Item(3).DataSource(2);
PDNBdot50NS = Data.Recorders.Item(6).Channels.Item(4).DataSource(2);
MLBdot50EW = Data.Recorders.Item(7).Channels.Item(1).DataSource(2);
MLBdot50NS = Data.Recorders.Item(7).Channels.Item(2).DataSource(2);
MLBdot50V = Data.Recorders.Item(7).Channels.Item(3).DataSource(2);
MLBfield50EW = Data.Recorders.Item(7).Channels.Item(4).DataSource(2);
MLBfield50NS = Data.Recorders.Item(8).Channels.Item(1).DataSource(2);

%100 m Station
PDNDdot100 = Data.Recorders.Item(8).Channels.Item(2).DataSource(2);
Bfield100EW = Data.Recorders.Item(8).Channels.Item(3).DataSource(2);
Bfield100NS = Data.Recorders.Item(8).Channels.Item(4).DataSource(2);

%200 m Station
PDNDdot200 = Data.Recorders.Item(9).Channels.Item(1).DataSource(2);
Bfield200EW = Data.Recorders.Item(9).Channels.Item(2).DataSource(2);
Bfield200NS = Data.Recorders.Item(9).Channels.Item(3).DataSource(2);

%300 m Station
PDNDdot300 = Data.Recorders.Item(9).Channels.Item(4).DataSource(2);
Bfield300EW = Data.Recorders.Item(10).Channels.Item(1).DataSource(2);
Bfield300NS = Data.Recorders.Item(10).Channels.Item(2).DataSource(2);

%400 m Station
PDNDdot400 = Data.Recorders.Item(10).Channels.Item(3).DataSource(2);
Bfield400EW = Data.Recorders.Item(10).Channels.Item(4).DataSource(2);
Bfield400NS = Data.Recorders.Item(11).Channels.Item(1).DataSource(2);

%500 m Station
PDNDdot500 = Data.Recorders.Item(11).Channels.Item(2).DataSource(2);
Bfield500EW = Data.Recorders.Item(11).Channels.Item(3).DataSource(2);
%Bfield500NS = Data.Recorders.Item(11).Channels.Item(4).DataSource(2);

%Extra
V711Strobe = Data.Recorders.Item(12).Channels.Item(1).DataSource(2);
APD = Data.Recorders.Item(12).Channels.Item(2).DataSource(2);

%Get sweep time info
timeinfo = IIHI.Sweeps.Item(sweep).get;
start = timeinfo.StartTime;
stop = timeinfo.EndTime;

%Load the actual segment of data for all channel base curret channels 
IIHI = IIHI.Data(start, stop);
IIVL = IIVL.Data(start, stop);
IDOT = IDOT.Data(start, stop);

%Load the actual segment of data for all ten dE/dt channels 
dE1 = dE1.Data(start, stop);
dE3 = dE3.Data(start, stop);
dE4 = dE4.Data(start, stop);
dE5 = dE5.Data(start, stop);
dE7 = dE7.Data(start, stop);
dE8 = dE8.Data(start, stop);
dE9 = dE9.Data(start, stop);
dE11 = dE11.Data(start, stop);
dE17 = dE17.Data(start, stop);
dE25 = dE25.Data(start, stop);

%Load the actual segment of data for all nine fast x-ray channels 
T1F = T1F.Data(start, stop);
T3F = T3F.Data(start, stop);
T4F = T4F.Data(start, stop);
T5F = T5F.Data(start, stop);
T7F = T7F.Data(start, stop);
T8F = T8F.Data(start, stop);
T9F = T9F.Data(start, stop);
T11F = T11F.Data(start, stop);
T17F = T17F.Data(start, stop);

%Load the actual segment of data for all nine fast x-ray channels 
PDNDdot50 = PDNDdot50.Data(start, stop);
PDNBdot50NS = PDNBdot50NS.Data(start, stop);
MLBdot50EW = MLBdot50EW.Data(start, stop);
MLBdot50NS = MLBdot50NS.Data(start, stop);
MLBdot50V = MLBdot50V.Data(start, stop);
MLBfield50EW = MLBfield50EW.Data(start, stop);
MLBfield50NS = MLBfield50NS.Data(start, stop);

%100 m Station
PDNDdot100 = PDNDdot100.Data(start, stop);
Bfield100EW = Bfield100EW.Data(start, stop);
Bfield100NS = Bfield100NS.Data(start, stop);

%200 m Station
PDNDdot200 = PDNDdot200.Data(start, stop);
Bfield200EW = Bfield200EW.Data(start, stop);
Bfield200NS = Bfield200NS.Data(start, stop);

%300 m Station
PDNDdot300 = PDNDdot300.Data(start, stop);
Bfield300EW = Bfield300EW.Data(start, stop);
Bfield300NS = Bfield300NS.Data(start, stop);

%400 m Station
PDNDdot400 = PDNDdot400.Data(start, stop);
Bfield400EW = Bfield400EW.Data(start, stop);
Bfield400NS = Bfield400NS.Data(start, stop);

%500 m Station
PDNDdot500 = PDNDdot500.Data(start, stop);
Bfield500EW = Bfield500EW.Data(start, stop);
%Bfield500NS = Bfield500NS.Data(start, stop);

%Extra
V711Strobe = V711Strobe.Data(start,stop);
APD = APD.Data(start, stop);

[xstart, xstop, seglength, numsamples] = IIHI.Item(1).XRange;

%Get waveform data from current measurements
W.IIHIData = IIHI.Item(1).Waveform(4, 1, 2E6, 1);
W.IIVLData = IIVL.Item(1).Waveform(4, 1, 2E6, 1);
W.IDOTData = IDOT.Item(1).Waveform(4, 1, 2E6, 1);

% Get waveform data Waveform(4 = floating point, starting data index, number
% of data points, reduction factor) 
W.dE1Data = dE1.Item(1).Waveform(4, 1, 2E6, 1);
W.dE3Data = dE3.Item(1).Waveform(4, 1, 2E6, 1);
W.dE4Data = dE4.Item(1).Waveform(4, 1, 2E6, 1);
W.dE5Data = dE5.Item(1).Waveform(4, 1, 2E6, 1);
W.dE7Data = dE7.Item(1).Waveform(4, 1, 2E6, 1);
W.dE8Data = dE8.Item(1).Waveform(4, 1, 2E6, 1);
W.dE9Data = dE9.Item(1).Waveform(4, 1, 2E6, 1);
W.dE11Data = dE11.Item(1).Waveform(4, 1, 2E6, 1);
W.dE17Data = dE17.Item(1).Waveform(4, 1, 2E6, 1);
W.dE25Data = dE25.Item(1).Waveform(4, 1, 2E6, 1);

W.T1FData = T1F.Item(1).Waveform(4, 1, 2E6, 1);
W.T3FData = T3F.Item(1).Waveform(4, 1, 2E6, 1);
W.T4FData = T4F.Item(1).Waveform(4, 1, 2E6, 1);
W.T5FData = T5F.Item(1).Waveform(4, 1, 2E6, 1);
W.T7FData = T7F.Item(1).Waveform(4, 1, 2E6, 1);
W.T8FData = T8F.Item(1).Waveform(4, 1, 2E6, 1);
W.T9FData = T9F.Item(1).Waveform(4, 1, 2E6, 1);
W.T11FData = T11F.Item(1).Waveform(4, 1, 2E6, 1);
W.T17FData = T17F.Item(1).Waveform(4, 1, 2E6, 1);

W.PDNDdot50Data = PDNDdot50.Item(1).Waveform(4, 1, 2E6, 1);
W.PDNBdot50NSData = PDNBdot50NS.Item(1).Waveform(4, 1, 2E6, 1);
W.MLBdot50EWData= MLBdot50EW.Item(1).Waveform(4, 1, 2E6, 1);
W.MLBdot50NSData = MLBdot50NS.Item(1).Waveform(4, 1, 2E6, 1);
W.MLBdot50VData = MLBdot50V.Item(1).Waveform(4, 1, 2E6, 1);
W.MLBfield50EWData = MLBfield50EW.Item(1).Waveform(4, 1, 2E6, 1);
W.MLBfield50NSData = MLBfield50NS.Item(1).Waveform(4, 1, 2E6, 1);

W.PDNDdot100Data = PDNDdot100.Item(1).Waveform(4, 1, 2E6, 1);
W.Bfield100EWData = Bfield100EW.Item(1).Waveform(4, 1, 2E6, 1);
W.Bfield100NSData = Bfield100NS.Item(1).Waveform(4, 1, 2E6, 1);
 
W.PDNDdot200Data = PDNDdot200.Item(1).Waveform(4, 1, 2E6, 1);
W.Bfield200EWData = Bfield200EW.Item(1).Waveform(4, 1, 2E6, 1);
W.Bfield200NSData = Bfield200NS.Item(1).Waveform(4, 1, 2E6, 1);
 
W.PDNDdot300Data = PDNDdot300.Item(1).Waveform(4, 1, 2E6, 1);
W.Bfield300EWData = Bfield300EW.Item(1).Waveform(4, 1, 2E6, 1);
W.Bfield300NSData = Bfield300NS.Item(1).Waveform(4, 1, 2E6, 1);
 
W.PDNDdot400Data = PDNDdot400.Item(1).Waveform(4, 1, 2E6, 1);
W.Bfield400EWData = Bfield400EW.Item(1).Waveform(4, 1, 2E6, 1);
W.Bfield400NSData = Bfield400NS.Item(1).Waveform(4, 1, 2E6, 1);
 
W.PDNDdot500Data = PDNDdot500.Item(1).Waveform(4, 1, 2E6, 1);
W.Bfield500EWData = Bfield500EW.Item(1).Waveform(4, 1, 2E6, 1);
%W.Bfield500NSData = Bfield500NS.Item(1).Waveform(4, 1, 2E6, 1);

W.V711StrobeData = V711Strobe.Item(1).Waveform(4, 1, 2E6, 1);
W.APDData = APD.Item(1).Waveform(4, 1, 2E6, 1);


%Create time vectors
W.IIHITime = (1:length(W.IIHIData));
W.IIVLTime = (1:length(W.IIVLData));
W.IDOTTime = (1:length(W.IDOTData));
 
W.dE1Time = (1:length(W.dE1Data));
W.dE3Time = (1:length(W.dE3Data));
W.dE4Time = (1:length(W.dE4Data));
W.dE5Time = (1:length(W.dE5Data));
W.dE7Time = (1:length(W.dE7Data));
W.dE8Time = (1:length(W.dE8Data));
W.dE9Time = (1:length(W.dE9Data));
W.dE11Time = (1:length(W.dE11Data));
W.dE17Time = (1:length(W.dE17Data));
W.dE25Time = (1:length(W.dE25Data));

W.T1FTime = (1:length(W.T1FData));
W.T3FTime = (1:length(W.T3FData));
W.T4FTime = (1:length(W.T4FData));
W.T5FTime = (1:length(W.T5FData));
W.T7FTime = (1:length(W.T7FData));
W.T8FTime = (1:length(W.T8FData));
W.T9FTime = (1:length(W.T9FData));
W.T11FTime = (1:length(W.T11FData));
W.T17FTime = (1:length(W.T17FData));

W.PDNDdot50Time = (1:length(W.PDNDdot50Data));
W.PDNBdot50NSTime = (1:length(W.PDNBdot50NSData));
W.MLBdot50EWTime= (1:length(W.MLBdot50EWData));
W.MLBdot50NSTime = (1:length(W.MLBdot50NSData));
W.MLBdot50VTime = (1:length(W.MLBdot50VData));
W.MLBfield50EWTime = (1:length(W.MLBfield50EWData));
W.MLBfield50NSTime = (1:length(W.MLBfield50NSData));

W.PDNDdot100Time = (1:length(W.PDNDdot100Data));
W.Bfield100EWTime = (1:length(W.Bfield100EWData));
W.Bfield100NSTime = (1:length(W.Bfield100NSData));
 
W.PDNDdot200Time = (1:length(W.PDNDdot200Data));
W.Bfield200EWTime = (1:length(W.Bfield200EWData));
W.Bfield200NSTime = (1:length(W.Bfield200NSData));
 
W.PDNDdot300Time = (1:length(W.PDNDdot300Data));
W.Bfield300EWTime = (1:length(W.Bfield300EWData));
W.Bfield300NSTime = (1:length(W.Bfield300NSData));
 
W.PDNDdot400Time = (1:length(W.PDNDdot400Data));
W.Bfield400EW = (1:length(W.Bfield400EWData));
W.Bfield400NS = (1:length(W.Bfield400NSData));
 
W.PDNDdot500Time = (1:length(W.PDNDdot500Data));
W.Bfield500EWTime = (1:length(W.Bfield500EWData));
%W.Bfield500NSTime = (1:length(W.Bfield500NSData));

W.V711StrobeTime = (1:length(W.V711StrobeData));
W.APDTime = (1:length(W.APDData));


        
    
    
    
    
    
    



