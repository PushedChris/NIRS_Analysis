clear 
clc

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����Ϊ��.txt����LABNIRSԭʼ���ݡ����Ϊ��.mat��,����onset��Ϣ
%�Ż����������벽�ࡣ
% ����cut����ͷȥβ
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(['convert the data '])
%
tic
%
% filePath = 'G:\������-NIRS\sample data\rawdata.txt';
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
            tline = fgetl(fid);                       %ȡÿһ��
            nindex = find(tline == ',');              
            tline(nindex) = ' ';                      %���������滻Ϊ�� ��
            [token, remain] = strtok(tline);          %ȡ��ÿ�еġ��ո�֮ǰ���ĵ�һ��Ԫ��
            if strncmp(tline, 'Time Range',10) == 1   %���뵽32�У�ȡ������ʱ��
                [token remain] = strtok(remain);
                [token remain] = strtok(remain);
                stt = str2num(token);                 %��ʼʱ��
                [token remain] = strtok(remain);
                stp = str2num(token);                 %����ʱ�䣬���ڱ�ʾ waitbar �Ľ���
            end
            %%%%'Time(sec)'
            if strcmp(token, 'Time(sec)') == 1        %���뵽35��
                index = 1;                            %��������е���ֵ��
                while 1
                    tline2 = fgetl(fid);              %���뵽36�У�ȫ���ݣ���ʼ�У�ȫ��0������ȡ������
                    if ischar(tline2) == 0, break, end, %ȷ����ʽ�ǡ��ַ����������ڽ�����ѭ��
                    newlabel = strrep(tline2, 'Z', ''); %��36���е�Mark��ֵ��Z����Ϊ����
                    nindex = find(newlabel == ',');
                    newlabel = str2num(newlabel);       %str2num�������ȡ���ݡ�
                    nirs_data.oxyData(index, :) = newlabel(1,5:3:end-2);   %ȡoxy����
                    nirs_data.dxyData(index, :) = newlabel(1,6:3:end-1);   %ȡdxy����
                    nirs_data.tHbData(index, :) = newlabel(1,7:3:end);     %ȡtHb����
                    waitbar((newlabel(1,1)-stt)/(stp-stt), h_wait);
                    time(index,1) = newlabel(1,1);                         %ȡʱ��
                    %��mark����ȡ�����������С�TASK����
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
        nirs_data.fs = fs;                                                 %Ƶ��
%         set(handles.edit_fs, 'string', num2str(fs));
        nirs_data.nch = size(nirs_data.oxyData,2);                         %channel������
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

        % ת����nirs_spm�����ݸ�ʽ
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
% ed=mark1(end)+ nirs_data.fs * 23; % ���һ��mark��+rest��15s��+ 8s
% nirs_data.oxyData = nirs_data.oxyData(st:ed,:);
%         nirs_data.dxyData = nirs_data.dxyData(st:ed,:);
%         nirs_data.tHbData = nirs_data.tHbData(st:ed,:);
%         nirs_data.vector_onset = nirs_data.vector_onset(st:ed);

 save(outfilePath,'nirs_data');
% %%
%
toc
%

        