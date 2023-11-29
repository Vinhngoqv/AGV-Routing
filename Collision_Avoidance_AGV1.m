global start_p end_p AGV_IDNumber AGV_ID x y z adj floyd time_in time_in_matrix mission_list;
global time_out time_out_matrix type_mission path AGV_ID2 crossing headon luot_chay time_tam 
global check_headon check_path1 check_headon1 time_0 check_path6 check_path7 check_waiting_time floyd_t
global AGV_number AGV_ID3 headon crossing AAA AGV_dangxet AGV_ID4 check_AGV_IDNumber8 AGV_ID_tam bo_qua_headon
global AGV_ID2_list

safe_time = 1/24/3600;
path = {};
AGV_ID3 = []; %tap luu ID xe bi doi duong
AGV_ID4 = []; %tap luu ID xe da xet nhung b? thay doi thoi gian

% fprintf('time bat dau cua moi qua trinh..........');
% time_bd = time_tam

AGV_ID2_list{size(AGV_ID2_list,1)+1,1} = AGV_ID2;
AGV_ID2_list{size(AGV_ID2_list,1),2} = luot_chay;
%% Lay thoi gian cho nhung AGV vua moi lay duong
if size(AGV_ID2,2) ~= 0
    for kav1 = 1:size(AGV_ID2,2) %check voi moi AGV
        
        AGV_IDNumber{1,kav1}.change = 0;
        
        if AGV_IDNumber{1,AGV_ID2(1,kav1)}.change_time == 0 || size(AGV_IDNumber{1,AGV_ID2(1,kav1)}.path,1) == 5%xet voi nhung xe lay duong  moi
            for kav2 = 1:size(AGV_IDNumber{1,AGV_ID2(1,kav1)}.path,2)
                doi_duong = 0;
                if kav2 == 1
                    if AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(1,kav2) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(1,kav2) > 2223
                        if luot_chay == 1
                            AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(6,kav2) = time_0; %time in
                            AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(7,kav2) = time_0 + 6/24/3600*(kav1-1); %time out
                        else
                            AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(6,kav2) = time_tam + 0.01/24/3600*kav1; %time in
                            AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(7,kav2) = time_tam + 0.1/24/3600*kav1; %time out
                        end
                        [r c] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(1,kav2));                    
                        if time_in(AGV_IDNumber{1,AGV_ID2(1,kav1)}.IDNumber + 1,c) == 0
                            time_in(AGV_IDNumber{1,AGV_ID2(1,kav1)}.IDNumber + 1,c) = AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(6,kav2);
                        end
                        time_out(AGV_IDNumber{1,AGV_ID2(1,kav1)}.IDNumber + 1,c) = AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(7,kav2);
                    else
                        point = mod(AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(1,kav2)-523,425);
                        if luot_chay == 1
                            AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(6,kav2) = time_0 + 0.01/24/3600*kav1; %time in
                            AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(7,kav2) = time_0 + 0.5/24/3600*kav1; %time out
                        else
                            AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(6,kav2) = time_tam + 0.01/24/3600*kav1; %time in
                            AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(7,kav2) = time_tam + 0.5/24/3600*kav1; %time out
                        end
                        [r c] = find(time_in(1,:) == point);
                        if time_in(AGV_IDNumber{1,AGV_ID2(1,kav1)}.IDNumber + 1,c) == 0
                            time_in(AGV_IDNumber{1,AGV_ID2(1,kav1)}.IDNumber + 1,c) = AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(6,kav2);
                        end
                        time_out(AGV_IDNumber{1,AGV_ID2(1,kav1)}.IDNumber + 1,c) = AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(7,kav2);
                    end
                else
                    if AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(1,kav2) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(1,kav2) > 2223
                        AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(6,kav2) = AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(7,kav2 -1); %time in
                        AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(7,kav2) = AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(6,kav2) + floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(1,kav2),AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(1,kav2-1))/24/3600;
                        [r c] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(1,kav2));
                        if time_in(AGV_IDNumber{1,AGV_ID2(1,kav1)}.IDNumber + 1,c) == 0
                            time_in(AGV_IDNumber{1,AGV_ID2(1,kav1)}.IDNumber + 1,c) = AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(6,kav2);
                        end
                        time_out(AGV_IDNumber{1,AGV_ID2(1,kav1)}.IDNumber + 1,c) = AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(7,kav2);
                    else
                        point = mod(AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(1,kav2)-523,425);
                        AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(6,kav2) = AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(7,kav2 -1); %time in
                        AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(7,kav2) = AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(6,kav2) + floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(1,kav2),AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(1,kav2-1))/24/3600;
                        [r c] = find(time_in(1,:) == point);
                        if time_in(AGV_IDNumber{1,AGV_ID2(1,kav1)}.IDNumber + 1,c) == 0
                            time_in(AGV_IDNumber{1,AGV_ID2(1,kav1)}.IDNumber + 1,c) = AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(6,kav2);
                        end
                        time_out(AGV_IDNumber{1,AGV_ID2(1,kav1)}.IDNumber + 1,c) = AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(7,kav2);
                    end
                end
            end
        end
        if size(AGV_IDNumber{1,AGV_ID2(1,kav1)}.path,2) == size(AGV_IDNumber{1,AGV_ID2(1,kav1)}.shortest_path,2)
            if AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav1)}.shortest_path(1,:)
                AGV_IDNumber{1,AGV_ID2(1,kav1)}.shortest_path = AGV_IDNumber{1,AGV_ID2(1,kav1)}.path;
            end
        end
    end
end

for k_check = 1:AGV_number
    if k_check == 1
        check_path1{size(check_path1,1)+1,k_check} = AGV_IDNumber{1,k_check}.path;
    else
        check_path1{size(check_path1,1),k_check} = AGV_IDNumber{1,k_check}.path;
    end
end

if size(AGV_ID_tam,2) == 0
    check_path6{size(check_path6,1)+1,1} = [];
    for k_check = 1:AGV_number
        for k_check1 = 1:size(check_path1{size(check_path1,1),k_check},2)
            check_path6{size(check_path6,1),k_check}{1,k_check1} = check_path1{size(check_path1,1),k_check}(1,k_check1);
            check_path6{size(check_path6,1),k_check}{2,k_check1} = string(datetime(check_path1{size(check_path1,1),k_check}(6,k_check1),'ConvertFrom','datenum'));
            check_path6{size(check_path6,1),k_check}{3,k_check1} = string(datetime(check_path1{size(check_path1,1),k_check}(7,k_check1),'ConvertFrom','datenum'));
        end
    end
end

%% check tim time loi
for kav1 = 1:AGV_number
    if size(AGV_IDNumber{1,kav1}.path,2) ~= 0
        if AGV_IDNumber{1,kav1}.path(6,1) < 1000 || AGV_IDNumber{1,kav1}.path(7,1) < 1000
            text1 = strcat('Loi thoi gian nho hon 0 doi voi xe',32,num2str(kav1));
            luachon = questdlg(text1,'Thong bao loi thoi gian','Yes','No','Yes');
            switch luachon
                case 'Yes'
                    dbquit all
                case 'No'
            end
        end
    end
end

%% Dectecting and Avoiding Collison

for kav3 = 1:size(AGV_ID2,2) %check voi moi AGV
    waiting_tam = AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time;
    for kav4 = 1:size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2) %duong
        
        if kav4 < size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)
            %lay doan hien tai và ke tiep de xet head on
            tam1 = strcat(num2str(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4)),'-',num2str(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1)));
        else
            break;
        end
        diem_giong = 0;
        if kav4 == 1
            diem_giong = 0;
        else
            if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4-1)
                diem_giong = 1;
            end
        end
        
        
        %chi xet voi nhung diem nam tren mat dat, nhung diem tren cao?        
        if (AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4) > 2223) && AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4) ~= 0 && diem_giong == 0
%             [r c] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4));
            for kav5 = 1:size(AGV_IDNumber,2) %check node AGV tren voi cac AGV con lai
                c_check = [];
                if size(AGV_ID3,2) ~= 0 %kiem tra xem co phai AGV chuyen duong 
                    clear c_check
                    [r_check c_check] = find(AGV_ID3 == AGV_IDNumber{1,kav5}.IDNumber);
                end
                if AGV_ID2(1,kav3) ~= AGV_IDNumber{1,kav5}.IDNumber && size(c_check,2)== 0 %bo qua AGV hien tai va xe lay duong lai
                    
                    doi_duong = 0;
                    cho_duong = 0;
                    
                    for kav7 = 1:(size(AGV_IDNumber{1,kav5}.path,2)-1)
                        %% PHAI SUA O DAY
                        if kav7 > (size(AGV_IDNumber{1,kav5}.path,2)-1)
                            break;
                        end
                        
                        %% Xet dieu kien co diem nam tren cao
                        % Chua ktr loi ich giua doi duong va cho
                            %Co diem nam tren o tren duong khong
                        if kav4 < size(AGV_IDNumber{1, AGV_ID2(1,kav3)}.path,2) && AGV_IDNumber{1, AGV_ID2(1,kav3)}.change_time == 0 && AGV_IDNumber{1,kav5}.path(1,kav7) == AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav4)%change-time khong duoc doi duong
                            %TU DUOI DI LEN
                            if AGV_IDNumber{1,kav5}.path(1,kav7+1) > 523 && AGV_IDNumber{1,kav5}.path(1,kav7+1) < 2224 && (AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav4 + 1) < 524 || AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav4 + 1) > 2223)
                                %Tim diem nam duoi
%                                 diemduoi = mod(AGV_IDNumber{1,kav5}.path(1,kav7) - 523,425);
                                diemduoi = AGV_IDNumber{1,kav5}.path(1,kav7);
                                %kiem tra co nam tren duong khong?
                                [r7 c7] = find(AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,:) == diemduoi);
                                if size(c7,2) ~= 0 %co xuat hien diem duoi
                                    %check thoi gian
                                    if (time_in(AGV_IDNumber{1, AGV_ID2(1,kav3)}.IDNumber + 1,diemduoi) >= time_in(AGV_IDNumber{1, kav5}.IDNumber + 1,diemduoi)) || (time_in(AGV_IDNumber{1, AGV_ID2(1,kav3)}.IDNumber + 1,diemduoi) <= time_in(AGV_IDNumber{1, kav5}.IDNumber + 1,diemduoi) && time_out(AGV_IDNumber{1, AGV_ID2(1,kav3)}.IDNumber + 1,diemduoi) >= time_in(AGV_IDNumber{1, kav5}.IDNumber + 1,diemduoi))
                                        %thuc hien doi duong
                                        if size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.another_path,2) > 0
                                            fprintf('Xay ra chiem duong voi diem tren cao xe %d voi xe %d tai diem %d (%d)\n',AGV_IDNumber{1, AGV_ID2(1,kav3)}.IDNumber, AGV_IDNumber{1, kav5}.IDNumber, AGV_IDNumber{1,kav5}.path(1,kav7),mod(AGV_IDNumber{1,kav5}.path(1,kav7)-523,425));
                                            fprintf('        Doi duong do co diem chan tren cho xe %d tai diem %d, tu diem %d den diem %d\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber,diemduoi,AGV_IDNumber{1,AGV_ID2(1,kav3)}.local_node,AGV_IDNumber{1,AGV_ID2(1,kav3)}.distination);
%                                             AGV_IDNumber{1,AGV_ID2(1,kav3)}.bo_headon = []; 
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.path = AGV_IDNumber{1,AGV_ID2(1,kav3)}.another_path{1,1};
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.another_path(:,1) = [];
                                            time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,:) = 0;
                                            time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,:) = 0;
                                            % Them vao tap AGV_ID3
                                            AGV_ID3 = [AGV_ID3 AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber];
                                            doi_duong = 1;
                                            break;
                                        else
                                            doi_duong = 0;
                                            fprintf('Xay ra chiem duong voi diem tren cao xe %d voi xe %d tai diem %d (%d)\n',AGV_IDNumber{1, AGV_ID2(1,kav3)}.IDNumber, AGV_IDNumber{1, kav5}.IDNumber, AGV_IDNumber{1,kav5}.path(1,kav7),mod(AGV_IDNumber{1,kav5}.path(1,kav7)-523,425));
                                            fprintf('        Cho xe %d cho do co diem chan tren boi xe %d tai diem %d, tu diem %d den diem %d\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber,AGV_IDNumber{1, kav5}.IDNumber,diemduoi,AGV_IDNumber{1,AGV_ID2(1,kav3)}.local_node,AGV_IDNumber{1,AGV_ID2(1,kav3)}.distination);
                                            %neu khong doi duoc cho cho
                                            old_time = AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav4-1);
                                            AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav4-1) = AGV_IDNumber{1,kav5}.path(7,kav7) + 2*floyd_t(AGV_IDNumber{1,kav5}.path(1,kav7),AGV_IDNumber{1,kav5}.path(1,size(AGV_IDNumber{1,kav5}.path,2)))/24/3600 + 2/24/3600;
                                            add_time = AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav4-1) - old_time;
                                            AGV_IDNumber{1, AGV_ID2(1,kav3)}.waiting_time = AGV_IDNumber{1, AGV_ID2(1,kav3)}.waiting_time + add_time;
                                            [r8 c8] = find(time_in(1,:) == AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav4-1));
                                            time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c8) = AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav4-1);
                                            for kav9 = kav4:size(AGV_IDNumber{1, AGV_ID2(1,kav3)}.path,2)
                                                AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(6,kav9) = AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav9-1);
                                                AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav9) = AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(6,kav9) + floyd_t(AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav9),AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav9-1))/24/3600;
                                                if AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav9) < 524 || AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav9) > 2223
                                                    [r8 c8] = find(time_in(1,:) == AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav9));
                                                else
                                                    [r8 c8] = find(time_in(1,:) == mod(AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav9)-523,425));
                                                end
                                                time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c8) = AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(6,kav9);
                                                time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c8) = AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav9);
                                            end
                                        end
                                    end
                                end
                            end
                            
                            
                            %TU TREN DI XUONG
                            if kav7 > 1
                                if AGV_IDNumber{1,kav5}.path(1,kav7-1) > 523 && AGV_IDNumber{1,kav5}.path(1,kav7-1) < 2224 && (AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav4 + 1) < 524 || AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav4 + 1) > 2223)
                                    %Tim diem nam duoi
    %                                 diemduoi = mod(AGV_IDNumber{1,kav5}.path(1,kav7) - 523,425);
                                    diemduoi = AGV_IDNumber{1,kav5}.path(1,kav7);
                                    %kiem tra co nam tren duong khong?
                                    [r7 c7] = find(AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,:) == diemduoi);
                                    if size(c7,2) ~= 0 %co xuat hien diem duoi
                                        %check thoi gian
                                        [r8 c8] = find(time_in(1,:) == mod(AGV_IDNumber{1,kav5}.path(1,1)-523,425));
                                        if time_out(AGV_IDNumber{1, AGV_ID2(1,kav3)}.IDNumber + 1,diemduoi) >= time_in(AGV_IDNumber{1, kav5}.IDNumber + 1,c8) && time_out(AGV_IDNumber{1, AGV_ID2(1,kav3)}.IDNumber + 1,diemduoi) <= time_out(AGV_IDNumber{1, kav5}.IDNumber + 1,diemduoi)
                                            %thuc hien doi duong
    %                                         if size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.another_path,2) > 0
                                                fprintf('Xay ra chiem duong voi diem tren cao xe %d voi xe %d tai diem %d (%d)\n',AGV_IDNumber{1, AGV_ID2(1,kav3)}.IDNumber, AGV_IDNumber{1, kav5}.IDNumber, AGV_IDNumber{1,kav5}.path(1,kav7),mod(AGV_IDNumber{1,kav5}.path(1,kav7)-523,425));
                                                fprintf('        Cho xe %d cho do co diem chan tren boi xe %d tai diem %d, tu diem %d den diem %d\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber,AGV_IDNumber{1, kav5}.IDNumber,diemduoi,AGV_IDNumber{1,AGV_ID2(1,kav3)}.local_node,AGV_IDNumber{1,AGV_ID2(1,kav3)}.distination);
                                                doi_duong = 0;
                                                %neu khong doi duoc cho cho
                                                old_time = AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav4-1);
                                                AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav4-1) = AGV_IDNumber{1,kav5}.path(7,kav7) + 2/24/3600;
                                                add_time = AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav4-1) - old_time;
                                                AGV_IDNumber{1, AGV_ID2(1,kav3)}.waiting_time = AGV_IDNumber{1, AGV_ID2(1,kav3)}.waiting_time + add_time;
                                                [r8 c8] = find(time_in(1,:) == AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav4-1));
                                                time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c8) = AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav4-1);
                                                for kav9 = kav4:size(AGV_IDNumber{1, AGV_ID2(1,kav3)}.path,2)
                                                    AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(6,kav9) = AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav9-1);
                                                    AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav9) = AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(6,kav9) + floyd_t(AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav9),AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav9-1))/24/3600;
                                                    if AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav9) < 524 || AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav9) > 2223
                                                        [r8 c8] = find(time_in(1,:) == AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav9));
                                                    else
                                                        [r8 c8] = find(time_in(1,:) == mod(AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(1,kav9)-523,425));
                                                    end
                                                    time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c8) = AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(6,kav9);
                                                    time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c8) = AGV_IDNumber{1, AGV_ID2(1,kav3)}.path(7,kav9);
                                                end
    %                                         end
                                        end
                                    end
                                end
                            end
                        end
                        
                        if doi_duong == 1
                            break
                        end



                        [r9 c9] = find(AGV_IDNumber{1,AGV_ID2(1,kav3)}.bo_headon == AGV_IDNumber{1,kav5}.IDNumber);
                        if doi_duong == 0 && size(c9,2) == 0
                            %% Xet cac truong hop Headon
                            tam2 = strcat(num2str(AGV_IDNumber{1,kav5}.path(1,kav7+1)),'-',num2str(AGV_IDNumber{1,kav5}.path(1,kav7)));
                            giatri_headon = headon;
                            if size(tam1,2) == size(tam2,2)
                                if tam1 == tam2

                                    if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4) > 523 && AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4) < 2224
                                        [r1 c1] = find(time_in(1,:) == mod(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4)-523,425));
                                    else
                                        [r1 c1] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4));
                                    end
                                    if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) > 523 && AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) < 2224
                                        [r2 c2] = find(time_in(1,:) == mod(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1)-523,425));
                                    else
                                        [r2 c2] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1));
                                    end
                                    if AGV_IDNumber{1,kav5}.path(1,kav7) > 523 && AGV_IDNumber{1,kav5}.path(1,kav7) < 2224
                                        [r3 c3] = find(time_in(1,:) == mod(AGV_IDNumber{1,kav5}.path(1,kav7)-523,425));
                                    else
                                        [r3 c3] = find(time_in(1,:) == AGV_IDNumber{1,kav5}.path(1,kav7));
                                    end
                                    if AGV_IDNumber{1,kav5}.path(1,kav7+1) > 523 && AGV_IDNumber{1,kav5}.path(1,kav7+1) < 2224
                                        [r4 c4] = find(time_in(1,:) == mod(AGV_IDNumber{1,kav5}.path(1,kav7+1)-523,425));
                                    else
                                        [r4 c4] = find(time_in(1,:) == AGV_IDNumber{1,kav5}.path(1,kav7+1));
                                    end

                                    check_headon1{size(check_headon1,1)+1,1} = tam1;
                                    check_headon1{size(check_headon1,1),2} = tam2;
                                    check_headon1{size(check_headon1,1),3} = AGV_IDNumber{1,AGV_ID2(1,kav3)};
                                    check_headon1{size(check_headon1,1),4} = AGV_IDNumber{1,kav5};
                                    check_headon1{size(check_headon1,1),5} = time_in;
                                    check_headon1{size(check_headon1,1),6} = time_out;
                                    check_headon1{size(check_headon1,1),7} = [c1 c2];
                                    check_headon1{size(check_headon1,1),8}.timein1 = string(datetime(time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1),'ConvertFrom','datenum'));
                                    check_headon1{size(check_headon1,1),8}.timeout1 = string(datetime(time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1),'ConvertFrom','datenum'));
                                    check_headon1{size(check_headon1,1),8}.timein2 = string(datetime(time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2),'ConvertFrom','datenum'));
                                    check_headon1{size(check_headon1,1),8}.timeout2 = string(datetime(time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2),'ConvertFrom','datenum'));
                                    check_headon1{size(check_headon1,1),8}.timein3 = string(datetime(time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c3),'ConvertFrom','datenum'));
                                    check_headon1{size(check_headon1,1),8}.timeout3 = string(datetime(time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c3),'ConvertFrom','datenum'));
                                    check_headon1{size(check_headon1,1),8}.timein4 = string(datetime(time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c4),'ConvertFrom','datenum'));
                                    check_headon1{size(check_headon1,1),8}.timeout4 = string(datetime(time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c4),'ConvertFrom','datenum'));
                                    check_headon1{size(check_headon1,1),9} = size(check_path1,1);
                                    check_headon1{size(check_headon1,1),10} = [AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber AGV_IDNumber{1,kav5}.IDNumber];
                                    check_headon1{size(check_headon1,1),11} = luot_chay;
                                    
                                    if ((time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1) + 0.2/24/3600) > time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c3)) && ((time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1) + 0.2/24/3600) < time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c4)) && ((time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2) + 0.2/24/3600) > time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c4))
                                        headon = headon + 1;
                                        check_headon{size(check_headon,1)+1,1} = tam1;
                                        check_headon{size(check_headon,1),2} = tam2;
                                        check_headon{size(check_headon,1),3} = AGV_IDNumber{1,AGV_ID2(1,kav3)};
                                        check_headon{size(check_headon,1),4} = AGV_IDNumber{1,kav5};
                                        check_headon{size(check_headon,1),5} = time_in;
                                        check_headon{size(check_headon,1),6} = time_out;
                                        check_headon{size(check_headon,1),7} = [c1 c2];
                                        check_headon{size(check_headon,1),8}.timein1 = string(datetime(time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1),'ConvertFrom','datenum'));
                                        check_headon{size(check_headon,1),8}.timeout1 = string(datetime(time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1),'ConvertFrom','datenum'));
                                        check_headon{size(check_headon,1),8}.timein2 = string(datetime(time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2),'ConvertFrom','datenum'));
                                        check_headon{size(check_headon,1),8}.timeout2 = string(datetime(time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2),'ConvertFrom','datenum'));
                                        check_headon{size(check_headon,1),8}.timein3 = string(datetime(time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c3),'ConvertFrom','datenum'));
                                        check_headon{size(check_headon,1),8}.timeout3 = string(datetime(time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c3),'ConvertFrom','datenum'));
                                        check_headon{size(check_headon,1),8}.timein4 = string(datetime(time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c4),'ConvertFrom','datenum'));
                                        check_headon{size(check_headon,1),8}.timeout4 = string(datetime(time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c4),'ConvertFrom','datenum'));
                                        check_headon{size(check_headon,1),9} = size(check_path1,1);
                                        check_headon{size(check_headon,1),10} = [AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber AGV_IDNumber{1,kav5}.IDNumber];
                                        check_headon{size(check_headon,1),11} = luot_chay;
                                    else
                                        if ((time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1) - 0.2/24/3600) < time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c3)) && ((time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2) + 0.2/24/3600) > time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c3)) && ((time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2) + 0.2/24/3600) < time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c4))
                                            headon = headon + 1;
                                            check_headon{size(check_headon,1)+1,1} = tam1;
                                            check_headon{size(check_headon,1),2} = tam2;
                                            check_headon{size(check_headon,1),3} = AGV_IDNumber{1,AGV_ID2(1,kav3)};
                                            check_headon{size(check_headon,1),4} = AGV_IDNumber{1,kav5};
                                            check_headon{size(check_headon,1),5} = time_in;
                                            check_headon{size(check_headon,1),6} = time_out;
                                            check_headon{size(check_headon,1),7} = [c1 c2];
                                            check_headon{size(check_headon,1),8}.timein1 = string(datetime(time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1),'ConvertFrom','datenum'));
                                            check_headon{size(check_headon,1),8}.timeout1 = string(datetime(time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1),'ConvertFrom','datenum'));
                                            check_headon{size(check_headon,1),8}.timein2 = string(datetime(time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2),'ConvertFrom','datenum'));
                                            check_headon{size(check_headon,1),8}.timeout2 = string(datetime(time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2),'ConvertFrom','datenum'));
                                            check_headon{size(check_headon,1),8}.timein3 = string(datetime(time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c3),'ConvertFrom','datenum'));
                                            check_headon{size(check_headon,1),8}.timeout3 = string(datetime(time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c3),'ConvertFrom','datenum'));
                                            check_headon{size(check_headon,1),8}.timein4 = string(datetime(time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c4),'ConvertFrom','datenum'));
                                            check_headon{size(check_headon,1),8}.timeout4 = string(datetime(time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c4),'ConvertFrom','datenum'));
                                            check_headon{size(check_headon,1),9} = size(check_path1,1);
                                            check_headon{size(check_headon,1),10} = [AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber AGV_IDNumber{1,kav5}.IDNumber];
                                            check_headon{size(check_headon,1),11} = luot_chay;
                                        else
                                            if ((time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1) + 0.2/24/3600) > time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c3)) && ((time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2) - 0.2/24/3600) < time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c4))
                                                headon = headon + 1;
                                                check_headon{size(check_headon,1)+1,1} = tam1;
                                                check_headon{size(check_headon,1),2} = tam2;
                                                check_headon{size(check_headon,1),3} = AGV_IDNumber{1,AGV_ID2(1,kav3)};
                                                check_headon{size(check_headon,1),4} = AGV_IDNumber{1,kav5};
                                                check_headon{size(check_headon,1),5} = time_in;
                                                check_headon{size(check_headon,1),6} = time_out;
                                                check_headon{size(check_headon,1),7} = [c1 c2];
                                                check_headon{size(check_headon,1),8}.timein1 = string(datetime(time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1),'ConvertFrom','datenum'));
                                                check_headon{size(check_headon,1),8}.timeout1 = string(datetime(time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1),'ConvertFrom','datenum'));
                                                check_headon{size(check_headon,1),8}.timein2 = string(datetime(time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2),'ConvertFrom','datenum'));
                                                check_headon{size(check_headon,1),8}.timeout2 = string(datetime(time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2),'ConvertFrom','datenum'));
                                                check_headon{size(check_headon,1),8}.timein3 = string(datetime(time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c3),'ConvertFrom','datenum'));
                                                check_headon{size(check_headon,1),8}.timeout3 = string(datetime(time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c3),'ConvertFrom','datenum'));
                                                check_headon{size(check_headon,1),8}.timein4 = string(datetime(time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c4),'ConvertFrom','datenum'));
                                                check_headon{size(check_headon,1),8}.timeout4 = string(datetime(time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c4),'ConvertFrom','datenum'));
                                                check_headon{size(check_headon,1),9} = size(check_path1,1);
                                                check_headon{size(check_headon,1),10} = [AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber AGV_IDNumber{1,kav5}.IDNumber];
                                                check_headon{size(check_headon,1),11} = luot_chay;
                                            else
                                                if ((time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1) - 0.2/24/3600) < time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c3)) && ((time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2) + 0.2/24/3600) > time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c4))
                                                    headon = headon + 1;
                                                    check_headon{size(check_headon,1)+1,1} = tam1;
                                                    check_headon{size(check_headon,1),2} = tam2;
                                                    check_headon{size(check_headon,1),3} = AGV_IDNumber{1,AGV_ID2(1,kav3)};
                                                    check_headon{size(check_headon,1),4} = AGV_IDNumber{1,kav5};
                                                    check_headon{size(check_headon,1),5} = time_in;
                                                    check_headon{size(check_headon,1),6} = time_out;
                                                    check_headon{size(check_headon,1),7} = [c1 c2];
                                                    check_headon{size(check_headon,1),8}.timein1 = string(datetime(time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1),'ConvertFrom','datenum'));
                                                    check_headon{size(check_headon,1),8}.timeout1 = string(datetime(time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1),'ConvertFrom','datenum'));
                                                    check_headon{size(check_headon,1),8}.timein2 = string(datetime(time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2),'ConvertFrom','datenum'));
                                                    check_headon{size(check_headon,1),8}.timeout2 = string(datetime(time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c2),'ConvertFrom','datenum'));
                                                    check_headon{size(check_headon,1),8}.timein3 = string(datetime(time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c3),'ConvertFrom','datenum'));
                                                    check_headon{size(check_headon,1),8}.timeout3 = string(datetime(time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c3),'ConvertFrom','datenum'));
                                                    check_headon{size(check_headon,1),8}.timein4 = string(datetime(time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c4),'ConvertFrom','datenum'));
                                                    check_headon{size(check_headon,1),8}.timeout4 = string(datetime(time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c4),'ConvertFrom','datenum'));
                                                    check_headon{size(check_headon,1),9} = size(check_path1,1);
                                                    check_headon{size(check_headon,1),10} = [AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber AGV_IDNumber{1,kav5}.IDNumber];
                                                    check_headon{size(check_headon,1),11} = luot_chay;
                                                end
                                            end
                                        end
                                    end
                                end
                            end


                            if headon > giatri_headon % co xay ra headon o doan nay hoac co diem nam tren diem nay
                                cho_duong = 0;
                                fprintf('Co xay ra headon giua xe %d va xe %d, tai diem %d\n', AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber, AGV_IDNumber{1,kav5}.IDNumber, AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4));


%                                     fprintf('gia tri truoc headon 2');
%                                 waiting_tam = AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time;
%                                     AGV_dangxet{1,size(AGV_dangxet,2)+1}{1,1} = AGV_IDNumber{1,AGV_ID2(1,kav3)};
%                                     AGV_dangxet{2,size(AGV_dangxet,2)}{1,1} = time_in;
%                                     AGV_dangxet{3,size(AGV_dangxet,2)}{1,1} = time_out;
                                %% Truong hop 1: Tim diem cho tren xe kav3
                                    %tim thu tu node dang xe if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4) > 2223
                                [r1 c1] = find(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4));
                                c1 = c1(1,1);
%                                       %tim vi tri gan nhat khong nam tren
                                %doan duong 
                                for k_headon1 = 0:(c1-1)
                                    [r2 c2] = find(AGV_IDNumber{1,kav5}.path(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,c1-k_headon1));
                                    if size(c2,2) == 0 %diem dau tien khong nam tren duong cua kav5
                                        %chi xet nhung diem o mat dat
                                        if (AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,c1 - k_headon1 + 1) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,c1 - k_headon1 + 1) > 2223) && (AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,c1 - k_headon1) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,c1 - k_headon1) > 2223) && (AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,c1 - k_headon1) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,c1 - k_headon1) > 2223)
                                            fprintf('    Tim tren xe %d (dang xet)\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber);
                                            [r3 c3] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,c1  - k_headon1 + 1));
                                            [r4 c4] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,c1 - k_headon1));
                                            [r5 c5] = find(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,c1 - k_headon1));
                                            c5 = c5(1,1);
                                            fprintf('        Thay doi thoi gian tren xe %d (dang xet), luot %d, cho o diem %d tu diem %d va diem %d\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber,size(check_headon,1),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,c5),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,c1  - k_headon1 + 1),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,c1  - k_headon1));
                                            


%                                                 %lay lai time
                                            old_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,c5);
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,c5) = time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c3) + safe_time;
                                            add_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,c5) - old_time;
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time + safe_time + time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c3) - time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c4);
%                                                 waiting = AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time
                                            time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c4) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,c5);
                                            for k_headon2 = (c1  - k_headon1 + 1): size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)
                                                if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,k_headon2) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,k_headon2) > 2223
                                                    [r4 c4] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,k_headon2));
                                                else
                                                    [r4 c4] = find(time_in(1,:) == mod(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,k_headon2)-523,425));
                                                end
                                                if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,k_headon2-1) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,k_headon2-1) > 2223
                                                    [r5 c5] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,k_headon2-1));
                                                else
                                                    [r5 c5] = find(time_in(1,:) == mod(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,k_headon2-1)-523,425));
                                                end
                                                AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,k_headon2) = time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber +1,c5);
                                                time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c4) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,k_headon2);
%                                                 AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,k_headon2) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,k_headon2) + floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,k_headon2),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,k_headon2-1))/24/3600;
                                                AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,k_headon2) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,k_headon2) + add_time;
                                                time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c4) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,k_headon2);
                                            end
                                            cho_duong = 1;
                                            break;
                                        end
                                    end
                                end

                                %% Truong hop 2: Tim diem cho tren xe kav5
                                if cho_duong == 0 
                                    %Tim vi tri node dang xet tren kav5
                                    [r1 c1] = find(AGV_IDNumber{1,kav5}.path(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4));
                                    for k_headon1 = 0:(c1(1,1)-1)
                                        [r2 c2] = find(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,:) == AGV_IDNumber{1,kav5}.path(1,c1(1,1)-k_headon1));
                                        if size(c2,2) == 0 %diem dau tien khong nam tren duong cua kav3
                                            %kiem tra kav5 di qua chua
                                            if size(AGV_IDNumber{1,kav5}.path1,2) ~= 0
                                                [r6 c6] = find(AGV_IDNumber{1,kav5}.path1(1,:) == AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1));
                                            else
                                                c6 = 1;
                                            end
                                            if size(c6,2) ~= 0
                                            %chi xet nhung diem o mat dat
                                                if (AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1 + 1) < 524 || AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1 + 1) > 2223) && (AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1) < 524 || AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1) > 2223) && (AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1) < 524 || AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1) > 2223)
                                                    fprintf('    Tim tren xe %d giu nguyen xe %d\n',AGV_IDNumber{1,kav5}.IDNumber, AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber);
                                                    fprintf('        Thay doi thoi gian tren xe %d, luot %d, tu diem %d va diem %d (them diem cho,chen diem)\n',AGV_IDNumber{1,kav5}.IDNumber,size(check_headon,1),AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1 + 1),AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1));
                                                    %them diem
                                                    diem_them = [];
                                                    diem_them(1,1) = AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1);
                                                    diem_them(2,1) = x(AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1),1);
                                                    diem_them(3,1) = y(AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1),1);
                                                    diem_them(4,1) = z(AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1),1);
                                                    diem_them(5,1) = AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1);

                                                    [r3 c3] = find(time_in(1,:) == AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1 + 1)); %diem dau tien tren duong
                                                    [r4 c4] = find(time_in(1,:) == AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1)); %diem dau tien khong tren duong
                                                    diem_them(6,1) = AGV_IDNumber{1,kav5}.path(7,c1(1,1) - k_headon1);
                                                    [r5 c5] = find(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,:) == AGV_IDNumber{1,kav5}.path(1,c1(1,1)-k_headon1+1));
                                                    
                                                    %% dong nay con loi
                                                    diem_them(7,1) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,c5(1,size(c5,2))) + safe_time + 3/24/3600;
                                                    
                                                    %% 
                                                    if diem_them(7,1) < diem_them(6,1)
                                                        diem_them(7,1) = diem_them(6,1) + 0.5/24/3600;
                                                    end
                                                    add_time = diem_them(7,1) - diem_them(6,1);
                                                    fprintf('in/out diem them %d:  %s\n',diem_them(1,1),strcat(char(datetime(diem_them(6,1),'ConvertFrom','datenum')),32,32,char(datetime(diem_them(7,1),'ConvertFrom','datenum')),32,32,'thoi gian them:',32,num2str(add_time*24*3600)));
                                                    
                                                    path_them{1,size(path_them,2)+1} = AGV_IDNumber{1,kav5}.IDNumber;
                                                    path_them{2,size(path_them,2)} = AGV_IDNumber{1,kav5}.path;
                                                    path_them{3,size(path_them,2)} = diem_them;
                                                    
                                                    [r5 c5] = find(AGV_IDNumber{1,kav5}.path(1,:) == AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1));
                                                    path_them{4,size(path_them,2)} = {[c1],[c2],[c3],[c4],[c5]};
                                                    
                                                    AGV_IDNumber{1,kav5}.path(6,c5(1,1)+1) = diem_them(7,1);
                                                    if AGV_IDNumber{1,kav5}.path(1,c5(1,1)+1) < 524 || AGV_IDNumber{1,kav5}.path(1,c5(1,1)+1) > 2223
                                                        [r10 c10] = find(time_in(1,:) == AGV_IDNumber{1,kav5}.path(1,c5(1,1)+1));
                                                    else
                                                        [r10 c10] = find(time_in(1,:) == mod(AGV_IDNumber{1,kav5}.path(1,c5(1,1)+1)-523,425));
                                                    end
                                                    time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c10) = AGV_IDNumber{1,kav5}.path(6,c5(1,1)+1);
                                                    
                                                    if AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1) < 524 || AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1) > 2223
                                                        [r10 c10] = find(time_in(1,:) == AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1));
                                                    else
                                                        [r10 c10] = find(time_in(1,:) == mod(AGV_IDNumber{1,kav5}.path(1,c1(1,1) - k_headon1)-523,425));
                                                    end
                                                    time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c10) = diem_them(7,1);
                                                    if c5(1,1) == 1
                                                        AGV_IDNumber{1,kav5}.path(7,c5(1,1)+1) = AGV_IDNumber{1,kav5}.path(6,c5(1,1)+1) + 2*safe_time;
                                                    else
                                                        AGV_IDNumber{1,kav5}.path(7,c5(1,1)+1) = AGV_IDNumber{1,kav5}.path(6,c5(1,1)+1) + floyd_t(AGV_IDNumber{1,kav5}.path(1,c5(1,1)),AGV_IDNumber{1,kav5}.path(1,c5(1,1)-1))/24/3600 + safe_time;
                                                    end
% %                                                     AGV_IDNumber{1,kav5}.path(7,c5(1,1)+1) = AGV_IDNumber{1,kav5}.path(7,c5(1,1)+1) + add_time + 2/24/3600;
                                                    AGV_IDNumber{1,kav5}.waiting_time = AGV_IDNumber{1,kav5}.waiting_time + time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c3) - time_out(AGV_IDNumber{1,kav5}.IDNumber + 1, c3);
                                                    time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c3) = AGV_IDNumber{1,kav5}.path(7,c5(1,1)+1);
                                                    AGV_IDNumber{1,kav5}.path = [AGV_IDNumber{1,kav5}.path(:,1:(c5(1,1))) diem_them AGV_IDNumber{1,kav5}.path(:,(c5(1,1)+1):size(AGV_IDNumber{1,kav5}.path,2))];
                                                    
                                                    path_them{1,size(path_them,2)+1} = AGV_IDNumber{1,kav5}.IDNumber;
                                                    path_them{2,size(path_them,2)} = AGV_IDNumber{1,kav5}.path;

                                                    for k_headon2 = (c5(1,1) + 3): size(AGV_IDNumber{1,kav5}.path,2)
                                                        if AGV_IDNumber{1,kav5}.path(1,k_headon2) < 524 || AGV_IDNumber{1,kav5}.path(1,k_headon2) > 2223
                                                            [r4 c4] = find(time_in(1,:) == AGV_IDNumber{1,kav5}.path(1,k_headon2));
                                                        else
                                                            [r4 c4] = find(time_in(1,:) == mod(AGV_IDNumber{1,kav5}.path(1,k_headon2)-523,425));
                                                        end
                                                        if AGV_IDNumber{1,kav5}.path(1,k_headon2-1) < 524 || AGV_IDNumber{1,kav5}.path(1,k_headon2-1) > 2223
                                                            [r5 c5] = find(time_in(1,:) == AGV_IDNumber{1,kav5}.path(1,k_headon2-1));
                                                        else
                                                            [r5 c5] = find(time_in(1,:) == mod(AGV_IDNumber{1,kav5}.path(1,k_headon2-1)-523,425));
                                                        end
                                                        AGV_IDNumber{1,kav5}.path(6,k_headon2) = time_out(AGV_IDNumber{1,kav5}.IDNumber +1,c5);
                                                        time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c4) = AGV_IDNumber{1,kav5}.path(6,k_headon2);
                                                        AGV_IDNumber{1,kav5}.path(7,k_headon2) = AGV_IDNumber{1,kav5}.path(6,k_headon2) + floyd_t(AGV_IDNumber{1,kav5}.path(1,k_headon2),AGV_IDNumber{1,kav5}.path(1,k_headon2-1))/24/3600;
%                                                         AGV_IDNumber{1,kav5}.path(7,k_headon2) = AGV_IDNumber{1,kav5}.path(7,k_headon2) + add_time;
                                                        time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c4) = AGV_IDNumber{1,kav5}.path(7,k_headon2);
                                                    end
                                                    if luot_chay ~= 1 && size(AGV_IDNumber{1,kav5}.path1,2) == 0
                                                        c8 = 1;
                                                    else
                                                        [r8 c8] = find(AGV_IDNumber{1,kav5}.path(1,:) == AGV_IDNumber{1,kav5}.path1(1,1));
                                                    end
                                                    %cat duong kav5
                                                    AGV_IDNumber{1,kav5}.path = AGV_IDNumber{1,kav5}.path(:,c8:size(AGV_IDNumber{1,kav5}.path,2));
                                                    path_them{1,size(path_them,2)+1} = AGV_IDNumber{1,kav5}.IDNumber;
                                                    path_them{2,size(path_them,2)} = AGV_IDNumber{1,kav5}.path;
                                                    
                                                    AGV_IDNumber{1,kav5}.change_time = 1;
                                                    AGV_IDNumber{1,kav5}.change = 1;
                                                    AGV_ID4 = [AGV_ID4 AGV_IDNumber{1,kav5}.IDNumber];

                                                    AGV_ID_tam{1,size(AGV_ID_tam,2)+1} = AGV_ID2;
                                                    AGV_ID_tam{2,size(AGV_ID_tam,2)} = kav3;
                                                    AGV_ID_tam{3,size(AGV_ID_tam,2)} = kav4;
                                                    AGV_ID_tam{4,size(AGV_ID_tam,2)} = kav5;
                                                    AGV_ID_tam{5,size(AGV_ID_tam,2)} = kav7;
                                                    fprintf('               VAO VONG TRONG\n');
                                                    while size(AGV_ID4,2) ~= 0 
                                                        AGV_ID2 = AGV_ID4;
                                                        Collision_Avoidance_AGV1;
                                                    end
                                                    fprintf('               KET THUC VONG TRONG\n');
                                                    AGV_ID2 = AGV_ID_tam{1,size(AGV_ID_tam,2)};
                                                    kav3 = AGV_ID_tam{2,size(AGV_ID_tam,2)};
                                                    kav4 = AGV_ID_tam{3,size(AGV_ID_tam,2)};
                                                    kav5 = AGV_ID_tam{4,size(AGV_ID_tam,2)};
                                                    kav7 = AGV_ID_tam{5,size(AGV_ID_tam,2)};
                                                    AGV_ID_tam(:,size(AGV_ID_tam,2)) = [];
                                                    cho_duong = 1;
                                                    path_them{1,size(path_them,2)+1} = AGV_IDNumber{1,kav5}.IDNumber;
                                                    path_them{2,size(path_them,2)} = AGV_IDNumber{1,kav5}.path;
                                                    break;
                                                end
                                                break;
                                            end
                                        end
                                    end
                                end
                                
                                %% Truong hop 3: tim diem gan nhat khong nam tren duong cac xe khac de cho
                                
                                
                                
                                
                                

                                %% Truong hop 4: Neu khong co diem cho, thuc hien thay doi duong
                                if cho_duong == 0 && doi_duong == 0 && size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.another_path,2) > 0 && AGV_IDNumber{1,AGV_ID2(1,kav3)}.change_time == 0
                                    fprintf('    Thay duong moi cho xe %d do co headon voi xe %d tai diem %d\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber,AGV_IDNumber{1,kav5}.IDNumber, AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4));
%                                     AGV_IDNumber{1,AGV_ID2(1,kav3)}.bo_headon = [];
                                    AGV_IDNumber{1,AGV_ID2(1,kav3)}.path = AGV_IDNumber{1,AGV_ID2(1,kav3)}.another_path{1,1};
                                    AGV_IDNumber{1,AGV_ID2(1,kav3)}.another_path(:,1) = [];
                                    AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time = waiting_tam;
                                    time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,:) = 0;
                                    time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,:) = 0;
                                    % Them vao tap AGV_ID3
                                    AGV_ID3 = [AGV_ID3 AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber];
                                    doi_duong = 1;
                                    break;
                                end
                                if cho_duong == 0 && size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.another_path,2) == 0
                                    %headon k kha tho lay lai duong cu
                                    fprintf('    Lay lai duong dau tien cho xe %d do khong xu ly duoc headon\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber);
                                    AGV_IDNumber{1,AGV_ID2(1,kav3)}.path = AGV_IDNumber{1,AGV_ID2(1,kav3)}.shortest_path;
                                    %tra duong ve another_path
                                    AGV_IDNumber{1,k3}.another_path = AGV_IDNumber{1,k3}.another_path1;
                                    time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,:) = 0;
                                    time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,:) = 0;
                                    for kav8 = 1:size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)
                                        if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav8) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav8) > 2223
                                            [r7 c7] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav8));
                                        else
                                            [r7 c7] = find(time_in(1,:) == mod(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav8)-523,425));
                                        end
                                        time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1, c7) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav8);
                                        time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1, c7) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav8);
                                    end
                                end
                                
                  

                                %% Truong hop 5: Neu ca 3 truong hop tren khong duoc cho phep dung cho o vi tri nhan hang (cua)
                                if cho_duong == 0 && doi_duong == 0 
                                    %ca hai xe deu di den cua
                                    [r_check1 c_check1] = find([2240,2241,2242,2243,2244,2245] == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,1)); %xe dang xet dung o cua
                                    [r_check2 c_check2] = find([2240,2241,2242,2243,2244,2245] == AGV_IDNumber{1,kav5}.path(1,size(AGV_IDNumber{1,kav5}.path,2)));
                                    if size(c_check1,2) ~= 0 && size(c_check2,2) ~= 0 && c_check1 == c_check2
                                        fprintf('    Cho o vi tri cua nhan hang doi voi xe %d do headon tai diem %d voi xe %d\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber,AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4),AGV_IDNumber{1,kav5}.IDNumber);
                                        fprintf('        Xe dang xet %d voi vi tri ban dau tai %d\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber,AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,1));
                                        fprintf('        Xe duoc xet den %d voi vi tri den sau cung %d\n',AGV_IDNumber{1,kav5}.IDNumber,AGV_IDNumber{1,kav5}.path(1,size(AGV_IDNumber{1,kav5}.path,2)));
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time + AGV_IDNumber{1,kav5}.path(7,size(AGV_IDNumber{1,kav5}.path,2)) + safe_time - AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1);
                                        tam3 = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1);
                                        old_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1);
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1) = AGV_IDNumber{1,kav5}.path(7,size(AGV_IDNumber{1,kav5}.path,2)) + 3/24/3600;
                                        add_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1) - old_time;
                                        fprintf('diem %d , time: %s\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,1),strcat(char(datetime(tam3,'ConvertFrom','datenum')),32,32,char(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1),'ConvertFrom','datenum')),32,32,char(datetime(AGV_IDNumber{1,kav5}.path(7,size(AGV_IDNumber{1,kav5}.path,2)),'ConvertFrom','datenum'))));
                                        
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{1,1} = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,1);
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{2,1} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,1),'ConvertFrom','datenum'));
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{3,1} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1),'ConvertFrom','datenum'));
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{4,1} = (AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1) - AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,1))*24*3600;
                                        [r_vitri c_vitri] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,1));
                                        time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c_vitri) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1);
                                        for i = 2:size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,i) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i-1);
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i) + add_time;
%                                             AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,i) + floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,i),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,i-1))/24/3600;
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{1,i} = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,i);
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{2,i} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,i),'ConvertFrom','datenum'));
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{3,i} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i),'ConvertFrom','datenum'));
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{4,i} = (AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i) - AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,i))*24*3600;
                                            if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,i) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,i) > 2223
                                                [r_vitri c_vitri] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,i));
                                                time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c_vitri) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,i);
                                                time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c_vitri) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i);
                                            else
                                                [r_vitri c_vitri] = find(time_in(1,:) == mod(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,i)-523,425));
                                                time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c_vitri) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,i);
                                                time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c_vitri) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i);
                                            end
                                        end

                                    else


                                    %khong tim duoc diem cho
                                    %cho cho o diem bat dau/
                                        fprintf('    Cho xe %d cho o diem bat dau ****KHONG XU LY DUOC\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber);
                                        fprintf('        Vi tri bat dau cua xe %d la %d\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber,AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,1));
                                        path_xe = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path
                                        %cho bao lau
                                        old_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1);
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1) + 7/24/3600;
                                        add_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1) - old_time;
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{1,1} = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,1);
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{2,1} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,1),'ConvertFrom','datenum'));
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{3,1} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1),'ConvertFrom','datenum'));
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{4,1} = (AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1) - AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,1))*24*3600;
                                        [r_vitri c_vitri] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,1));
                                        time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c_vitri) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,1);
                                        for i = 2:size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,i) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i-1);
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i) + add_time;
%                                             AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,i) + floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,i),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,i-1))/24/3600;
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{1,i} = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,i);
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{2,i} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,i),'ConvertFrom','datenum'));
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{3,i} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i),'ConvertFrom','datenum'));
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{4,i} = (AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i) - AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,i))*24*3600;
                                            if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,i) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,i) > 2223
                                                [r_vitri c_vitri] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,i));
                                                time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c_vitri) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,i);
                                                time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c_vitri) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i);
                                            else
                                                [r_vitri c_vitri] = find(time_in(1,:) == mod(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,i)-523,425));
                                                time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c_vitri) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,i);
                                                time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c_vitri) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,i);
                                            end
                                        end



                                    end
                                    AGV_IDNumber{1,AGV_ID2(1,kav3)}.bo_headon(1,size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.bo_headon,2)+1) = AGV_IDNumber{1,kav5}.IDNumber;
                                end
                            end
                        end
                        
                        if doi_duong == 1
                            break;
                        end

                        %% PHAI SUA O DAY
                        if kav7 > (size(AGV_IDNumber{1,kav5}.path,2)-1)
                            break;
                        end
                        
                        %% Truong hop co xe o tren cao cung diem duoi
                        if kav7 <= size(AGV_IDNumber{1,kav5}.path,2)
                            if doi_duong == 0 && AGV_IDNumber{1,kav5}.path(1,kav7) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4) && size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2) == 7 && size(AGV_IDNumber{1,kav5}.path,2) == 7
                                if kav7 < size(AGV_IDNumber{1,kav5}.path,2)
                                    if AGV_IDNumber{1,kav5}.path(1,kav7+1) > 523 && AGV_IDNumber{1,kav5}.path(1,kav7+1) < 2224 && AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) > 523 && AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) < 2224
                                        % xe kav5 den truoc
                                        if (AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4) + 2/24/3600) > AGV_IDNumber{1,kav5}.path(6,kav7-1) && (AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4) + 2/24/3600) < (AGV_IDNumber{1,kav5}.path(7,kav7) + 2*floyd_t(AGV_IDNumber{1,kav5}.path(1,kav7),AGV_IDNumber{1,kav5}.path(1,size(AGV_IDNumber{1,kav5}.path,2)))/24/3600)
                                            fprintf('Co diem chan boi xe %d, them thoi gian cho cho xe %d(dang xet) tai diem %d\n',AGV_IDNumber{1,kav5}.IDNumber,AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber,AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4));
                                            old_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4);
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4) + 2*floyd_t(AGV_IDNumber{1,kav5}.path(1,kav7),AGV_IDNumber{1,kav5}.path(1,size(AGV_IDNumber{1,kav5}.path,2)))/24/3600 + 2/24/3600;
                                            add_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4) - old_time;
                                            AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time + 2*floyd_t(AGV_IDNumber{1,kav5}.path(1,kav7),AGV_IDNumber{1,kav5}.path(1,size(AGV_IDNumber{1,kav5}.path,2)))/24/3600 + 2/24/3600;
                                            [r c] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4));
                                            time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4);
                                            for k_duoi = (kav4+1):size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)
                                                AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,k_duoi) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,k_duoi-1);
                                                AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,k_duoi) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,k_duoi) + add_time;
    %                                             AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,k_duoi) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,k_duoi) + floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,k_duoi),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,k_duoi-1))/24/3600;
                                                [r1 c1] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,k_duoi));
                                                time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1(1,1)) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,k_duoi);
                                                time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1(1,1)) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,k_duoi);
                                            end
                                        end
                                        % xe kav3 den truoc
                                        if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4) > AGV_IDNumber{1,kav5}.path(6,kav7-1) && AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4) < AGV_IDNumber{1,kav5}.path(7,kav7) + 2*floyd_t(AGV_IDNumber{1,kav5}.path(1,kav7),AGV_IDNumber{1,kav5}.path(1,size(AGV_IDNumber{1,kav5}.path,2)))/24/3600 && (AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4) + 2/24/3600) < AGV_IDNumber{1,kav5}.path(6,kav7-1)
                                            fprintf('Co diem chan boi xe %d, them thoi gian cho cho xe %d tai diem %d giu nguyen%d\n',AGV_IDNumber{1,kav5}.IDNumber,AGV_IDNumber{1,kav5}.IDNumber,AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4),AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber);
                                            old_time = AGV_IDNumber{1,kav5}.path(7,kav7);
                                            AGV_IDNumber{1,kav5}.path(7,kav7) = AGV_IDNumber{1,kav5}.path(7,kav7) + 2*floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)))/24/3600 + 5/24/3600;
                                            add_time = AGV_IDNumber{1,kav5}.path(7,kav7) - old_time;
                                            AGV_IDNumber{1,kav5}.waiting_time = AGV_IDNumber{1,kav5}.waiting_time + 2*floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)))/24/3600 + 5/24/3600;
                                            [r11 c11] = find(time_in(1,:) == AGV_IDNumber{1,kav5}.path(1,kav7));
                                            time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c11) = AGV_IDNumber{1,kav5}.path(7,kav7);
                                            for k_duoi = (kav7+1):size(AGV_IDNumber{1,kav5}.path,2)
                                                AGV_IDNumber{1,kav5}.path(6,k_duoi) = AGV_IDNumber{1,kav5}.path(6,k_duoi-1);
                                                AGV_IDNumber{1,kav5}.path(7,k_duoi) = AGV_IDNumber{1,kav5}.path(7,k_duoi) + add_time;
    %                                             AGV_IDNumber{1,kav5}.path(7,k_duoi) = AGV_IDNumber{1,kav5}.path(6,k_duoi) + floyd_t(AGV_IDNumber{1,kav5}.path(1,k_duoi),AGV_IDNumber{1,kav5}.path(1,k_duoi-1))/24/3600;
                                                [r1 c1] = find(time_in(1,:) == AGV_IDNumber{1,kav5}.path(1,k_duoi));
                                                time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c1(1,1)) = AGV_IDNumber{1,kav5}.path(6,k_duoi);
                                                time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c1(1,1)) = AGV_IDNumber{1,kav5}.path(7,k_duoi);
                                            end

                                            AGV_IDNumber{1,kav5}.change_time = 1;
                                            AGV_ID4 = [AGV_ID4 AGV_IDNumber{1,kav5}.IDNumber];

                                            AGV_ID_tam{1,size(AGV_ID_tam,2)+1} = AGV_ID2;
                                            AGV_ID_tam{2,size(AGV_ID_tam,2)} = kav3;
                                            AGV_ID_tam{3,size(AGV_ID_tam,2)} = kav4;
                                            AGV_ID_tam{4,size(AGV_ID_tam,2)} = kav5;
                                            AGV_ID_tam{5,size(AGV_ID_tam,2)} = kav7;

                                            while size(AGV_ID4,2) ~= 0
                                                AGV_ID2 = AGV_ID4;
                                                Collision_Avoidance_AGV1;
                                                for k_headon = 1:size(AGV_ID2)
                                                    if AGV_IDNumber{1,AGV_ID2(1,k_headon)}.change == 0
                                                        [r_time c_time] = find(AGV_ID2 == AGV_IDNumber{1,AGV_ID2(1,k_headon)}.IDNumber);
                                                        AGV_IDNumber{1,AGV_ID2(1,c_time)}.change_time = 0;
                                                        AGV_ID2(:,c_time) = [];
                                                    end
                                                end
                                            end
                                            AGV_ID2 = AGV_ID_tam{1,size(AGV_ID_tam,2)};
                                            kav3 = AGV_ID_tam{2,size(AGV_ID_tam,2)};
                                            kav4 = AGV_ID_tam{3,size(AGV_ID_tam,2)};
                                            kav5 = AGV_ID_tam{4,size(AGV_ID_tam,2)};
                                            kav7 = AGV_ID_tam{5,size(AGV_ID_tam,2)};
                                            AGV_ID_tam(:,size(AGV_ID_tam,2)) = [];
                                        end

                                    end
                                end
                            end
                        end
                                    
                                    
                                    

                    
                        %% Xet Crossing
                        crossing1 = 0;
                        %Xet truong hop Crossing: timein -> [time_in; time_out]
                        if doi_duong == 0 && AGV_IDNumber{1,kav5}.path(1,kav7) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4)
                            %xe kav3 den truoc nen cho xe kav5 cho
                            [r c] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4));
                            if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4) < 524
                                if (time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) > time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) && (time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c)-1/24/3600) <= time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c)) && time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) < time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c)
                                    crossing = crossing + 1;
                                    [r2 c2] = find(AGV_IDNumber{1,kav5}.path(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4));
                                    c2 = c2(1,1);
                                    %kiem tra xe kav5 di qua chua
                                    
                                    
                                    
                                    
                                    %% Con sai
                                    if kav4 > 0
                                    %% Con sai
                                    
                                    
                                    
                                    
                                    
                                        %kiem tra kav5 qua diem truoc do chua
    %                                     if luot_chay ~= 1
                                        %truong hop co 2 xe den dich
                                        if size(AGV_IDNumber{1,kav5}.path1,2) ~= 0 && c2 ~= 1
                                            [r3 c3] = find(AGV_IDNumber{1,kav5}.path1(1,:) == AGV_IDNumber{1,kav5}.path(1,c2(1,1)-1));
                                        else
                                            c3 = 1;
                                        end
                                        if (size(c3,2) ~= 0 && size(AGV_IDNumber{1,kav5}.path1,2) ~= 0)% || luot_chay == 1
                                            fprintf('Xay ra crossing tai diem %d, them thoi gian cho cho xe %d giu nguyen xe %d\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4),AGV_IDNumber{1,kav5}.IDNumber,AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber);
                                            AGV_IDNumber{1,kav5}.waiting_time = AGV_IDNumber{1,kav5}.waiting_time + time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) - time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + safe_time;
                                            if AGV_IDNumber{1,kav5}.path1(1,1) == AGV_IDNumber{1,kav5}.path(1,c2-1)
                                                AGV_IDNumber{1,kav5}.waiting_time_them = AGV_IDNumber{1,kav5}.waiting_time_them + time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) - time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + safe_time;
                                            end
                                            if c2 == 1
                                                if kav4 < size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)
                                                    if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) > 523 &&  AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) < 2224
                                                        time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + 2*floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)))/24/3600 + 2/24/3600;
                                                    else
                                                        time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + safe_time;
                                                    end
                                                else
                                                    time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + safe_time;
                                                end
                                                AGV_IDNumber{1,kav5}.path(7,c2) = time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c);
                                                AGV_IDNumber{1,kav5}.timeline{3,c2} = string(datetime(AGV_IDNumber{1,kav5}.path(7,c2),'ConvertFrom','datenum'));
                                            else
                                                if kav4 < size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)
                                                    if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) > 523 &&  AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) < 2224
                                                        time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) = time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + 2*floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)))/24/3600 + 2/24/3600;
                                                    else
                                                        time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + safe_time;
                                                    end
                                                else
                                                    time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + safe_time;
                                                end
                                                AGV_IDNumber{1,kav5}.path(6,c2) = time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c);
%                                                 [r1 c1] = find(time_in(1,:) == AGV_IDNumber{1,kav5}.path(1,c2);
%                                                 time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c1) = AGV_IDNumber{1,kav5}.path(6,c2);
                                                AGV_IDNumber{1,kav5}.timeline{2,c2} = string(datetime(AGV_IDNumber{1,kav5}.path(6,c2),'ConvertFrom','datenum'));
                                                old_time = AGV_IDNumber{1,kav5}.path(7,c2 - 1);
                                                AGV_IDNumber{1,kav5}.path(7,c2 - 1) = time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c);
                                                add_time = AGV_IDNumber{1,kav5}.path(7,c2 - 1) - old_time;
                                                AGV_IDNumber{1,kav5}.timeline{3,c2 - 1} = string(datetime(AGV_IDNumber{1,kav5}.path(7,c2-1),'ConvertFrom','datenum'));
                                                [r1 c1] = find(time_out(1,:) == AGV_IDNumber{1,kav5}.path(1,c2-1));
                                                time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c1) = AGV_IDNumber{1,kav5}.path(7,c2 - 1);   
                                                AGV_IDNumber{1,kav5}.path(7,c2) = AGV_IDNumber{1,kav5}.path(7,c2) + add_time;
%                                                 AGV_IDNumber{1,kav5}.path(7,c2) = AGV_IDNumber{1,kav5}.path(6,c2) + floyd_t(AGV_IDNumber{1,kav5}.path(1,c2),AGV_IDNumber{1,kav5}.path(1,c2-1))/24/3600;
                                                AGV_IDNumber{1,kav5}.timeline{3,kav7} = string(datetime(AGV_IDNumber{1,kav5}.path(7,kav7),'ConvertFrom','datenum'));
                                                time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) = AGV_IDNumber{1,kav5}.path(7,c2);
                                            end

                                            %% check
                                            %Chay lai time_in & time_out
                                            for kav6 = (c2+1):size(AGV_IDNumber{1,kav5}.path,2)         
                                                AGV_IDNumber{1,kav5}.path(6,kav6) = AGV_IDNumber{1,kav5}.path(7,kav6 - 1);% + safe_time; %time in
                                                AGV_IDNumber{1,kav5}.path(7,kav6) = AGV_IDNumber{1,kav5}.path(7,kav6) + add_time;
%                                                 AGV_IDNumber{1,kav5}.path(7,kav6) = AGV_IDNumber{1,kav5}.path(6,kav6) + floyd_t(AGV_IDNumber{1,kav5}.path(1,kav6),AGV_IDNumber{1,kav5}.path(1,kav6-1))/24/3600;
                                                AGV_IDNumber{1,kav5}.timeline{2,kav6} = string(datetime(AGV_IDNumber{1,kav5}.path(6,kav6),'ConvertFrom','datenum'));
                                                AGV_IDNumber{1,kav5}.timeline{3,kav6} = string(datetime(AGV_IDNumber{1,kav5}.path(7,kav6),'ConvertFrom','datenum'));
                                                if AGV_IDNumber{1,kav5}.path(1,kav6) < 524 || AGV_IDNumber{1,kav5}.path(1,kav6) > 2223
                                                    [r1 c1] = find(time_in(1,:) == AGV_IDNumber{1,kav5}.path(1,kav6));
                                                else
                                                    [r1 c1] = find(time_in(1,:) == mod(AGV_IDNumber{1,kav5}.path(1,kav6)-523,425));
                                                end
                                                time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c1) = AGV_IDNumber{1,kav5}.path(6,kav6);
                                                time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c1) = AGV_IDNumber{1,kav5}.path(7,kav6);
                                            end


                                            AGV_IDNumber{1,kav5}.change_time = 1;
                                            AGV_ID4 = [AGV_ID4 AGV_IDNumber{1,kav5}.IDNumber];

                                            AGV_ID_tam{1,size(AGV_ID_tam,2)+1} = AGV_ID2;
                                            AGV_ID_tam{2,size(AGV_ID_tam,2)} = kav3;
                                            AGV_ID_tam{3,size(AGV_ID_tam,2)} = kav4;
                                            AGV_ID_tam{4,size(AGV_ID_tam,2)} = kav5;
                                            AGV_ID_tam{5,size(AGV_ID_tam,2)} = kav7;

                                            while size(AGV_ID4,2) ~= 0
                                                AGV_ID2 = AGV_ID4;
                                                Collision_Avoidance_AGV1;
                                                for k_headon = 1:size(AGV_ID2)
                                                    if AGV_IDNumber{1,AGV_ID2(1,k_headon)}.change == 0
                                                        [r_time c_time] = find(AGV_ID2 == AGV_IDNumber{1,AGV_ID2(1,k_headon)}.IDNumber);
                                                        AGV_ID2(:,c_time) = [];
                                                    end
                                                end
                                            end
                                            AGV_ID2 = AGV_ID_tam{1,size(AGV_ID_tam,2)};
                                            kav3 = AGV_ID_tam{2,size(AGV_ID_tam,2)};
                                            kav4 = AGV_ID_tam{3,size(AGV_ID_tam,2)};
                                            kav5 = AGV_ID_tam{4,size(AGV_ID_tam,2)};
                                            kav7 = AGV_ID_tam{5,size(AGV_ID_tam,2)};
                                            AGV_ID_tam(:,size(AGV_ID_tam,2)) = [];
            %                                 AGV_IDNumber{1,kav5}.change_time = 0;
                                        else
                                            crossing1 = 1;
                                        end
                                    end
                                end

                                %Xe kav3 den sau nen cho
                                if crossing1 == 1 || ((time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c)) >= time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) && time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) <= time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c))
    %                             if crossing1 == 1 || AGV_IDNumber{1,AGV_ID2(1,kav3)}.          >= time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) && time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) <= time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c))
                                    fprintf('Xay ra crossing tai diem %d voi xe %d, them thoi gian cho cho xe %d (dang xet)\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4),AGV_IDNumber{1,kav5}.IDNumber,AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber);
                                    crossing = crossing + 1;
                                    AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time + time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) - time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + safe_time;
                                    [r c] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4));
                                    if kav4 == 1
                                        if kav7 < size(AGV_IDNumber{1,kav5}.path,2)
                                            if AGV_IDNumber{1,kav5}.path(1,kav7+1) > 523 && AGV_IDNumber{1,kav5}.path(1,kav7+1) < 2224
                                                time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + 2*floyd_t(AGV_IDNumber{1,kav5}.path(1,kav7),AGV_IDNumber{1,kav5}.path(1,size(AGV_IDNumber{1,kav5}.path,2)))/24/3600 + 2/24/3600;
                                            else
                                                time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + safe_time;
                                            end
                                        else
                                            time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + safe_time;
                                        end
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4) = time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c);
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{3,kav4} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4),'ConvertFrom','datenum'));
                                    else
                                        if kav7 < size(AGV_IDNumber{1,kav5}.path,2)
                                            if AGV_IDNumber{1,kav5}.path(1,kav7+1) > 523 && AGV_IDNumber{1,kav5}.path(1,kav7+1) < 2224
                                                time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + 2*floyd_t(AGV_IDNumber{1,kav5}.path(1,kav7),AGV_IDNumber{1,kav5}.path(1,size(AGV_IDNumber{1,kav5}.path,2)))/24/3600 + 2/24/3600;
                                            else
                                                time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + safe_time;
                                            end
                                        else
                                            time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + safe_time;
                                        end
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4) = time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c);
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{2,kav4} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4),'ConvertFrom','datenum'));
                                        old_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4 - 1);
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4 - 1) = time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c);
                                        add_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4 - 1) - old_time;
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{3,kav4 - 1} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4-1),'ConvertFrom','datenum'));
                                        [r1 c1] = find(time_out(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4-1));
                                        time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4 - 1);
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4) + add_time;
%                                         AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4) + floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4-1))/24/3600;
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{3,kav4} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4),'ConvertFrom','datenum'));
                                        time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4);
                                    end

                                    %Chay lai time_in & time_out
                                    for kav6 = (kav4+1):size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)         
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav6) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav6 - 1); %time in
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav6) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav6) + add_time;
%                                         AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav6) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav6) + floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav6),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav6-1))/24/3600;
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{2,kav6} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav6),'ConvertFrom','datenum'));
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{3,kav6} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav6),'ConvertFrom','datenum'));
                                        if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav6) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav6) > 2223
                                            [r1 c1] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav6));
                                        else
                                            [r1 c1] = find(time_in(1,:) == mod(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav6)-523,425));
                                        end
                                        time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav6);
                                        time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav6);
                                    end
                                end
                            else
                                if ((time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) - 3/24/3600) > time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) && (time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + 2/24/3600) <= time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c)) && time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) < time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c)
                                    crossing = crossing + 1;
                                    [r2 c2] = find(AGV_IDNumber{1,kav5}.path(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4));
                                    c2 = c2(1,1);
                                    %kiem tra xe kav5 di qua chua
                                    
                                    
                                    
                                    
                                    
                                    
                                    %% Con sai
                                    if kav4 > 0
                                    %% Con sai
                                    
                                    
                                    
                                    
                                    
                                        %kiem tra kav5 qua diem truoc do chua
    %                                     if luot_chay ~= 1
                                        %truong hop co 2 xe den dich
                                        if size(AGV_IDNumber{1,kav5}.path1,2) ~= 0
                                            [r3 c3] = find(AGV_IDNumber{1,kav5}.path1(1,:) == AGV_IDNumber{1,kav5}.path(1,c2-1));
                                        else
                                            c3 = 1;
                                        end
                                        if (size(c3,2) ~= 0 && size(AGV_IDNumber{1,kav5}.path1,2) ~= 0)% || luot_chay == 1
                                            fprintf('Xay ra crossing tai diem %d, them thoi gian cho cho xe %d giu nguyen xe %d\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4),AGV_IDNumber{1,kav5}.IDNumber,AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber);
                                            fprintf('%s\n',strcat(char(datetime(time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c),'ConvertFrom','datenum')),32,32,char(datetime(time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c),'ConvertFrom','datenum')),32,32,char(datetime(time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c),'ConvertFrom','datenum')),32,32,char(datetime(time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c),'ConvertFrom','datenum'))));
                                            AGV_IDNumber{1,kav5}.waiting_time = AGV_IDNumber{1,kav5}.waiting_time + time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) - time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + safe_time;
                                            if AGV_IDNumber{1,kav5}.path1(1,1) == AGV_IDNumber{1,kav5}.path(1,c2-1)
                                                AGV_IDNumber{1,kav5}.waiting_time_them = AGV_IDNumber{1,kav5}.waiting_time_them + time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) - time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + safe_time;
                                            end
                                            if c2 == 1
                                                if kav4 < size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)
                                                    if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) > 523 &&  AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) < 2224
                                                        time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + 2*floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)))/24/3600 + 2/24/3600;
                                                    else
                                                        time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + safe_time;
                                                    end
                                                else
                                                    time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + safe_time;
                                                end
                                                AGV_IDNumber{1,kav5}.path(7,c2) = time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c);
                                                AGV_IDNumber{1,kav5}.timeline{3,c2} = string(datetime(AGV_IDNumber{1,kav5}.path(7,c2),'ConvertFrom','datenum'));
                                            else
                                                if kav4 < size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)
                                                    if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) > 523 &&  AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) < 2224
                                                        time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) = time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + 2*floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)))/24/3600 + 2/24/3600;
                                                    else
                                                        time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + safe_time;
                                                    end
                                                else
                                                    time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + safe_time;
                                                end
                                                old_time = AGV_IDNumber{1,kav5}.path(6,c2);
                                                AGV_IDNumber{1,kav5}.path(6,c2) = time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c);
                                                add_time = AGV_IDNumber{1,kav5}.path(6,c2) - old_time;
                                                AGV_IDNumber{1,kav5}.timeline{2,c2} = string(datetime(AGV_IDNumber{1,kav5}.path(6,c2),'ConvertFrom','datenum'));
                                                AGV_IDNumber{1,kav5}.path(7,c2 - 1) = time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c);
                                                AGV_IDNumber{1,kav5}.timeline{3,c2 - 1} = string(datetime(AGV_IDNumber{1,kav5}.path(7,c2-1),'ConvertFrom','datenum'));
                                                [r1 c1] = find(time_out(1,:) == AGV_IDNumber{1,kav5}.path(1,c2-1));
                                                time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c1) = AGV_IDNumber{1,kav5}.path(7,c2 - 1);   
                                                AGV_IDNumber{1,kav5}.path(7,c2) = AGV_IDNumber{1,kav5}.path(7,c2) + add_time;
%                                                 AGV_IDNumber{1,kav5}.path(7,c2) = AGV_IDNumber{1,kav5}.path(6,c2) + floyd_t(AGV_IDNumber{1,kav5}.path(1,c2),AGV_IDNumber{1,kav5}.path(1,c2-1))/24/3600;
                                                AGV_IDNumber{1,kav5}.timeline{3,kav7} = string(datetime(AGV_IDNumber{1,kav5}.path(7,kav7),'ConvertFrom','datenum'));
                                                time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) = AGV_IDNumber{1,kav5}.path(7,c2);
                                            end

                                            %% check
                                            %Chay lai time_in & time_out
                                            for kav6 = (c2+1):size(AGV_IDNumber{1,kav5}.path,2)         
                                                AGV_IDNumber{1,kav5}.path(6,kav6) = AGV_IDNumber{1,kav5}.path(7,kav6 - 1);% + safe_time; %time in
                                                AGV_IDNumber{1,kav5}.path(7,kav6) = AGV_IDNumber{1,kav5}.path(7,kav6) + add_time;
%                                                 AGV_IDNumber{1,kav5}.path(7,kav6) = AGV_IDNumber{1,kav5}.path(6,kav6) + floyd_t(AGV_IDNumber{1,kav5}.path(1,kav6),AGV_IDNumber{1,kav5}.path(1,kav6-1))/24/3600;
                                                AGV_IDNumber{1,kav5}.timeline{2,kav6} = string(datetime(AGV_IDNumber{1,kav5}.path(6,kav6),'ConvertFrom','datenum'));
                                                AGV_IDNumber{1,kav5}.timeline{3,kav6} = string(datetime(AGV_IDNumber{1,kav5}.path(7,kav6),'ConvertFrom','datenum'));
                                                if AGV_IDNumber{1,kav5}.path(1,kav6) < 524 || AGV_IDNumber{1,kav5}.path(1,kav6) > 2223
                                                    [r1 c1] = find(time_in(1,:) == AGV_IDNumber{1,kav5}.path(1,kav6));
                                                else
                                                    [r1 c1] = find(time_in(1,:) == mod(AGV_IDNumber{1,kav5}.path(1,kav6)-523,425));
                                                end
                                                time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c1) = AGV_IDNumber{1,kav5}.path(6,kav6);
                                                time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c1) = AGV_IDNumber{1,kav5}.path(7,kav6);
                                            end


                                            AGV_IDNumber{1,kav5}.change_time = 1;
                                            AGV_ID4 = [AGV_ID4 AGV_IDNumber{1,kav5}.IDNumber];

                                            AGV_ID_tam{1,size(AGV_ID_tam,2)+1} = AGV_ID2;
                                            AGV_ID_tam{2,size(AGV_ID_tam,2)} = kav3;
                                            AGV_ID_tam{3,size(AGV_ID_tam,2)} = kav4;
                                            AGV_ID_tam{4,size(AGV_ID_tam,2)} = kav5;
                                            AGV_ID_tam{5,size(AGV_ID_tam,2)} = kav7;
                                            fprintf('                VAO VONG TRONG\n');
                                            while size(AGV_ID4,2) ~= 0
                                                AGV_ID2 = AGV_ID4;
                                                Collision_Avoidance_AGV1;
                                                for k_headon = 1:size(AGV_ID2)
                                                    if AGV_IDNumber{1,AGV_ID2(1,k_headon)}.change == 0
                                                        [r_time c_time] = find(AGV_ID2 == AGV_IDNumber{1,AGV_ID2(1,k_headon)}.IDNumber);
                                                        AGV_ID2(:,c_time) = [];
                                                    end
                                                end
                                            end
                                            fprintf('                KET THUC VONG TRONG\n');
                                            AGV_ID2 = AGV_ID_tam{1,size(AGV_ID_tam,2)};
                                            kav3 = AGV_ID_tam{2,size(AGV_ID_tam,2)};
                                            kav4 = AGV_ID_tam{3,size(AGV_ID_tam,2)};
                                            kav5 = AGV_ID_tam{4,size(AGV_ID_tam,2)};
                                            kav7 = AGV_ID_tam{5,size(AGV_ID_tam,2)};
                                            AGV_ID_tam(:,size(AGV_ID_tam,2)) = [];
                                        else
                                            crossing1 = 1;
                                        end
                                    end
                                end

                                %Xe kav3 den sau nen cho
                                if crossing1 == 1 || ((time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) - 3/24/3600) >= time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c) && (time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c)) <= time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c))
                                    fprintf('Xay ra crossing tai diem %d voi xe %d, them thoi gian cho cho xe %d (dang xet)\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4),AGV_IDNumber{1,kav5}.IDNumber,AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber);
                                    
                                    crossing = crossing + 1;
                                    AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time + time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) - time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + safe_time;
                                    [r c] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4));
                                    fprintf('%s\n',strcat(char(datetime(time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c),'ConvertFrom','datenum')),32,32,char(datetime(time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c),'ConvertFrom','datenum')),32,32,char(datetime(time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c),'ConvertFrom','datenum')),32,32,char(datetime(time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c),'ConvertFrom','datenum'))));
                                    if kav4 == 1
                                        if kav7 < size(AGV_IDNumber{1,kav5}.path,2)
                                            if AGV_IDNumber{1,kav5}.path(1,kav7+1) > 523 && AGV_IDNumber{1,kav5}.path(1,kav7+1) < 2224
                                                time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + 2*floyd_t(AGV_IDNumber{1,kav5}.path(1,kav7),AGV_IDNumber{1,kav5}.path(1,size(AGV_IDNumber{1,kav5}.path,2)))/24/3600 + 2/24/3600;
                                            else
                                                time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + safe_time;
                                            end
                                        else
                                            time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + safe_time;
                                        end
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4) = time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c);
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{3,kav4} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4),'ConvertFrom','datenum'));
                                    else
                                        if kav7 < size(AGV_IDNumber{1,kav5}.path,2)
                                            if AGV_IDNumber{1,kav5}.path(1,kav7+1) > 523 && AGV_IDNumber{1,kav5}.path(1,kav7+1) < 2224
                                                time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) + 2*floyd_t(AGV_IDNumber{1,kav5}.path(1,kav7),AGV_IDNumber{1,kav5}.path(1,size(AGV_IDNumber{1,kav5}.path,2)))/24/3600 + 2/24/3600;
                                            else
                                                time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + safe_time;
                                            end
                                        else
                                            time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c) + safe_time;
                                        end
                                        old_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4);
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4) = time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c);
                                        add_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4) - old_time;
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{2,kav4} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4),'ConvertFrom','datenum'));
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4 - 1) = time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c);
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{3,kav4 - 1} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4-1),'ConvertFrom','datenum'));
                                        [r1 c1] = find(time_out(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4-1));
                                        time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4 - 1);                    
%                                         AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4) + add_time;
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4) + floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4-1))/24/3600;
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{3,kav4} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4),'ConvertFrom','datenum'));
                                        time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4);
                                    end

                                    %Chay lai time_in & time_out
                                    for kav6 = (kav4+1):size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2)    
                                        old_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav6);
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav6) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav6 - 1); %time in
                                        add_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav6) - old_time;
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav6) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav6) + add_time;
%                                         AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav6) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav6) + floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav6),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav6-1))/24/3600;
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{2,kav6} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav6),'ConvertFrom','datenum'));
                                        AGV_IDNumber{1,AGV_ID2(1,kav3)}.timeline{3,kav6} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav6),'ConvertFrom','datenum'));
                                        if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav6) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav6) > 2223
                                            [r1 c1] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav6));
                                        else
                                            [r1 c1] = find(time_in(1,:) == mod(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav6)-523,425));
                                        end
                                        time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav6);
                                        time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c1) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav6);
                                    end
                                end
                            end
                        end
                        if doi_duong == 1
                            break;
                        end
                        
                        
                        %% Truong hop co trung diem den ben duoi
                        if doi_duong == 0 && (kav4+1) == size(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path,2) && (AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) < 524 || AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) > 2223)
                            if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1) == AGV_IDNumber{1,kav5}.path(1,size(AGV_IDNumber{1,kav5}.path,2))
                                if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4+1) > AGV_IDNumber{1,kav5}.path(6,size(AGV_IDNumber{1,kav5}.path,2)) && AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4+1) < AGV_IDNumber{1,kav5}.path(7,size(AGV_IDNumber{1,kav5}.path,2))
                                    fprintf('Trung diem cuoi giua xe %d voi xe %d tai diem %d, them thoi gian cho xe %d (dang xet)\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber,AGV_IDNumber{1,kav5}.IDNumber,AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1),AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber);
                                    AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time = AGV_IDNumber{1,AGV_ID2(1,kav3)}.waiting_time + AGV_IDNumber{1,kav5}.path(7,size(AGV_IDNumber{1,kav5}.path,2)) + safe_time - AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4+1);
                                    AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4+1) = AGV_IDNumber{1,kav5}.path(7,size(AGV_IDNumber{1,kav5}.path,2)) + safe_time;
                                    AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4+1) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4+1) + floyd_t(AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1),AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4))/24/3600;
                                    [r10 c10] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1));
                                    time_in(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c10) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4+1);
                                    time_out(AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber + 1,c10) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4+1);
                                end
                                if AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(6,kav4+1) < AGV_IDNumber{1,kav5}.path(6,size(AGV_IDNumber{1,kav5}.path,2)) && AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4+1) > AGV_IDNumber{1,kav5}.path(6,size(AGV_IDNumber{1,kav5}.path,2)) && AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4+1) < AGV_IDNumber{1,kav5}.path(7,size(AGV_IDNumber{1,kav5}.path,2))
                                    fprintf('Trung diem cuoi giua xe %d voi xe %d tai diem %d, them thoi gian cho xe %d\n',AGV_IDNumber{1,AGV_ID2(1,kav3)}.IDNumber,AGV_IDNumber{1,kav5}.IDNumber,AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4+1),AGV_IDNumber{1,kav5}.IDNumber);
                                    AGV_IDNumber{1,kav5}.waiting_time = AGV_IDNumber{1,kav5}.waiting_time + AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4+1) + safe_time - AGV_IDNumber{1,kav5}.path(6,size(AGV_IDNumber{1,kav5}.path,2));
                                    AGV_IDNumber{1,kav5}.path(6,size(AGV_IDNumber{1,kav5}.path,2)) = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(7,kav4+1) + safe_time;
                                    AGV_IDNumber{1,kav5}.path(7,size(AGV_IDNumber{1,kav5}.path,2)) = AGV_IDNumber{1,kav5}.path(6,size(AGV_IDNumber{1,kav5}.path,2)) + floyd_t(AGV_IDNumber{1,kav5}.path(1,size(AGV_IDNumber{1,kav5}.path,2)),AGV_IDNumber{1,kav5}.path(1,size(AGV_IDNumber{1,kav5}.path,2)-1))/24/3600;
                                    [r10 c10] = find(time_in(1,:) == AGV_IDNumber{1,kav5}.path(7,size(AGV_IDNumber{1,kav5}.path,2)));
                                    time_in(AGV_IDNumber{1,kav5}.IDNumber + 1,c10) = AGV_IDNumber{1,kav5}.path(6,size(AGV_IDNumber{1,kav5}.path,2));
                                    time_out(AGV_IDNumber{1,kav5}.IDNumber + 1,c10) = AGV_IDNumber{1,kav5}.path(7,size(AGV_IDNumber{1,kav5}.path,2));
                                    
                                    AGV_IDNumber{1,kav5}.change_time = 1;
                                    AGV_ID4 = [AGV_ID4 AGV_IDNumber{1,kav5}.IDNumber];

                                    AGV_ID_tam{1,size(AGV_ID_tam,2)+1} = AGV_ID2;
                                    AGV_ID_tam{2,size(AGV_ID_tam,2)} = kav3;
                                    AGV_ID_tam{3,size(AGV_ID_tam,2)} = kav4;
                                    AGV_ID_tam{4,size(AGV_ID_tam,2)} = kav5;
                                    AGV_ID_tam{5,size(AGV_ID_tam,2)} = kav7;
%                                         check_AGV_IDNumber8{1,size(check_AGV_IDNumber8,2)+1} = AGV_IDNumber{1,AGV_ID2(1,kav3)};
%                                         check_AGV_IDNumber8{2,size(check_AGV_IDNumber8,2)} = AGV_IDNumber{1,kav5};
%                                         check_AGV_IDNumber8{3,size(check_AGV_IDNumber8,2)} = AGV_IDNumber{1,AGV_ID2(1,kav3)}.path(1,kav4);
%                                         check_AGV_IDNumber8{4,size(check_AGV_IDNumber8,2)} = AGV_IDNumber{1,kav5}.path(1,kav7);

                                    while size(AGV_ID4,2) ~= 0
                                        AGV_ID2 = AGV_ID4;
                                        Collision_Avoidance_AGV1;
                                        for k_headon = 1:size(AGV_ID2)
                                            if AGV_IDNumber{1,AGV_ID2(1,k_headon)}.change == 0
                                                [r_time c_time] = find(AGV_ID2 == AGV_IDNumber{1,AGV_ID2(1,k_headon)}.IDNumber);
%                                                 AGV_IDNumber{1,AGV_ID2(1,c_time)}.change_time = 0;
                                                AGV_ID2(:,c_time) = [];
                                            end
                                        end
                                    end
                                    AGV_ID2 = AGV_ID_tam{1,size(AGV_ID_tam,2)};
                                    kav3 = AGV_ID_tam{2,size(AGV_ID_tam,2)};
                                    kav4 = AGV_ID_tam{3,size(AGV_ID_tam,2)};
                                    kav5 = AGV_ID_tam{4,size(AGV_ID_tam,2)};
                                    kav7 = AGV_ID_tam{5,size(AGV_ID_tam,2)};
                                    AGV_ID_tam(:,size(AGV_ID_tam,2)) = [];
                                end
                            end
                        end
                                            
                                            
                        
                    end
                end
                if doi_duong == 1
                    break;
                end
            end
        end
        if doi_duong == 1
            break;
        end
    end
    if doi_duong == 1
        break;
    end
end

%% check tim time loi
for kav1 = 1:AGV_number
    if size(AGV_IDNumber{1,kav1}.path,2) ~= 0 && size(AGV_IDNumber{1,kav1}.path,1) == 7
        for kav11 = 1:size(AGV_IDNumber{1,kav1}.path,2)
            if (AGV_IDNumber{1,kav1}.path(7,kav11) - AGV_IDNumber{1,kav1}.path(6,kav11)) < 0
                text1 = strcat('Loi thoi gian co vi tri out be hon in voi xe',32,num2str(kav1));
                luachon = questdlg(text1,'Thong bao loi thoi gian','Yes','No','Yes');
                switch luachon
                    case 'Yes'
                        dbquit all
                    case 'No'
                end
            end
        end
    end
end


%% lay timeline sau collision
if size(AGV_ID2,2) ~= 0
    for kav1 = 1:size(AGV_ID2,2) %check voi moi AGV
        if size(AGV_IDNumber{1,AGV_ID2(1,kav1)}.path,1) == 7
            AGV_IDNumber{1,AGV_ID2(1,kav1)}.timeline = {};
            for kav2 = 1:size(AGV_IDNumber{1,AGV_ID2(1,kav1)}.path,2)
                %tao timeline trc collision
                AGV_IDNumber{1,AGV_ID2(1,kav1)}.timeline{1,kav2} = AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(1,kav2);
                AGV_IDNumber{1,AGV_ID2(1,kav1)}.timeline{2,kav2} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(6,kav2),'ConvertFrom','datenum'));
                AGV_IDNumber{1,AGV_ID2(1,kav1)}.timeline{3,kav2} = string(datetime(AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(7,kav2),'ConvertFrom','datenum'));
                AGV_IDNumber{1,AGV_ID2(1,kav1)}.timeline{4,kav2} = (AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(7,kav2) - AGV_IDNumber{1,AGV_ID2(1,kav1)}.path(6,kav2))*24*3600;
            end
        end
    end
end

% fprintf('time tam chay den cuoi...............................................');
% time_kt = time_tam