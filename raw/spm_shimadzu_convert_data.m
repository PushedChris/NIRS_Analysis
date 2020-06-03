clear 
clc

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%输入为“.txt”的LABNIRS原始数据。输出为“.mat”,包含onset信息
%优化了数据载入步奏。
% 包含cut，掐头去尾
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(['convert the data '])
%
tic
%
% filePath = 'G:\心理所-NIRS\sample data\rawdata.txt';
outfilePath = 'D:\project\raw\convert.mat';

[filen, pathn] = uigetfile('*.txt','Select File to Read...');
%         path_file_n = [pathn filen];
%         load(path_file_n);
        
ChannelNum = 57;
N = ChannelNum;
subName = {''};
system = 'SHIMADZU LABNIRS';
probeSet = {''};

%       initial data matrix to save time
        nirs_data.oxyData = zeros(200000,N);
        nirs_data.dxyData = zeros(200000,N);
        nirs_data.tHbData = zeros(200000,N);
        nirs_data.vector_onset = zeros(200000,1);
% filepath
        path_file_n = [pathn filen];
        %
        fid = fopen(path_file_n);
        
        h_wait = waitbar(0, 'Data loading... ');
        while 1
            tline = fgetl(fid);                       %取每一行
            nindex = find(tline == ',');              
            tline(nindex) = ' ';                      %将“，”替换为“ ”
            [token, remain] = strtok(tline);          %取出每行的“空格之前“的第一个元素
            if strncmp(tline, 'Time Range',10) == 1   %进入到32行，取出运行时间
                [token remain] = strtok(remain);
                [token remain] = strtok(remain);
                stt = str2num(token);                 %开始时间
                [token remain] = strtok(remain);
                stp = str2num(token);                 %结束时间，用于表示 waitbar 的进度
            end
            %%%%'Time(sec)'
            if strcmp(token, 'Time(sec)') == 1        %进入到35行
                index = 1;                            %储存矩阵中的行值。
                while 1
                    tline2 = fgetl(fid);              %进入到36行（全数据，开始行，全”0“），取出数据
                    if ischar(tline2) == 0, break, end, %确定格式是‘字符串’，用于结束该循环
                    newlabel = strrep(tline2, 'Z', ''); %将36行中的Mark的值”Z“换为‘’
                    nindex = find(newlabel == ',');
                    newlabel = str2num(newlabel);       %str2num，方便读取数据。
                    nirs_data.oxyData(index, :) = newlabel(1,5:3:end-2);   %取oxy数据
                    nirs_data.dxyData(index, :) = newlabel(1,6:3:end-1);   %取dxy数据
                    nirs_data.tHbData(index, :) = newlabel(1,7:3:end);     %取tHb数据
                    waitbar((newlabel(1,1)-stt)/(stp-stt), h_wait);
                    time(index,1) = newlabel(1,1);                         %取时间
                    %将mark项提取出来，数据中”TASK“项
                    vector_onset(index, 1) = newlabel(1,2);
                    %
                    index = index + 1;
                end
                break
            end
        end
        close(h_wait);
        fclose(fid);
        fs = 1./(mean(diff(time)));
        nirs_data.fs = fs;                                                 %频率
%         set(handles.edit_fs, 'string', num2str(fs));
        nirs_data.nch = size(nirs_data.oxyData,2);                         %channel的数量
%       
        %
        %  Check if the "mark" is correct......Sepecify for Shimadzu
        temp = find(vector_onset>0);
        num = size(temp,1);
        temp1 = mod(num,2);
        if temp1
            if temp(1)==1
                vector_onset( temp(1) ) = 0;
                disp('The total number of mark is (odd)...Please check to confirm...')
                disp('The mark has been correct...');
            else
%                 vector_onset( temp(1) ) = 0;
                disp('The total number of mark is (odd)...Please check to confirm...')
                disp('Check the mark soon!!!!...')
            end
        end
        %
        nirs_data.vector_onset = vector_onset;
        %
        nirs_data.oxyData = nirs_data.oxyData(1:index-1,:);
        nirs_data.dxyData = nirs_data.dxyData(1:index-1,:);
        nirs_data.tHbData = nirs_data.tHbData(1:index-1,:);
        nirs_data.vector_onset = nirs_data.vector_onset(1:index-1,:);
        %
%         

        % 转换成nirs_spm的数据格式
        nirs_data.oxyData = nirs_data.oxyData;
        nirs_data.dxyData = nirs_data.dxyData;
        nirs_data.tHbData = nirs_data.tHbData;
        nirs_data.vector_onset = nirs_data.vector_onset;
        nirs_data.nch = nirs_data.nch;
        nirs_data.fs = nirs_data.fs;
        nirs_data.T = 1/nirs_data.fs;
        nirs_data.subject = subName;
        nirs_data.system = system;
        nirs_data.probeSet = probeSet;
% % 

% % cut
% mark1 = find(nirs_data.vector_onset);
% st=mark1(1)-nirs_data.fs;
% ed=mark1(end)+ nirs_data.fs * 23; % 最后一个mark后+rest（15s）+ 8s
% nirs_data.oxyData = nirs_data.oxyData(st:ed,:);
%         nirs_data.dxyData = nirs_data.dxyData(st:ed,:);
%         nirs_data.tHbData = nirs_data.tHbData(st:ed,:);
%         nirs_data.vector_onset = nirs_data.vector_onset(st:ed);

 save(outfilePath,'nirs_data');
% %%
%
toc
%

        