
%%
%  ���������onset����duration����nirs_spm����ο���;�����ʾ��command����
%%
% ������1������������2����������
%%
[filen, pathn] = uigetfile('*.mat','Select File to Read...');
        path_file_n = [pathn filen];
        load(path_file_n);
            outfile='D:\project\raw1.txt';

        %%
           mark = nirs_data.vector_onset;
    % neutral
            temp1 = find(mark==1);
            neutral_onset = temp1(1:2:end);
            neutral_offset = temp1(2:2:end);
            neutral_dur = neutral_offset - neutral_onset;
            % positive
%           %  temp1 = find(mark==3);
%            % positive_onset = temp1(1:2:end);
%             %positive_offset = temp1(2:2:end);
%             positive_dur = positive_offset - positive_onset;
            % negative
            temp1 = find(mark==2);
            negative_onset = temp1(1:2:end);
            negative_offset = temp1(2:2:end);
            negative_dur = negative_offset - negative_onset;
    

    % save txt
    fid=fopen(outfile,'wt');
    
    fprintf(fid,'%s\n','neutral_onset:  ');
    fprintf(fid,'%g\n',neutral_onset);
    fprintf(fid,'%s\n','  ');
    fprintf(fid,'%s\n','neutral_dur:  ');
    fprintf(fid,'%g\n', neutral_dur);    
    fprintf(fid,'%s\n','  ');
    fprintf(fid,'%s\n','negative_onset:  ');
    fprintf(fid,'%g\n', negative_onset);   
    fprintf(fid,'%s\n','  ');
    fprintf(fid,'%s\n','negative_dur:  ');
    fprintf(fid,'%g\n', negative_dur);