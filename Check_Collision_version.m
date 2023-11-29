clc
clear all


for order = 1:1% vong chay ktr loi
close all

global history_table dem1 dem2 dem3 dem4 dem5 dem6 tonghang vitritrong time3;
global n type  A B C D E F G H I J K M N O P stt node time tt T5 T;
global adj floyd x y z type_good_list tonkho loai AGV_number AGV_IDNumber;
global floyd_t AGV_ID2 time_in time_out
global head head1 crossing headon end_p start_p luot_chay check_headon check_headon1 check_path1 time_tam
global luot_cuoi check_AGV_IDNumber5 AGV_saivitri_list1 time_0 check_path6 check_waiting_time
global A_path AGV_ID3 AAA AGV_dangxet random_number cua_nhan AGV_ID4 check_AGV_IDNumber8 AGV_ID_tam path_them AGV_ID2_list
global check_path4_2

% load distance_matrix

ve_duong_di;
load distance_matrix1;
adj = round(adj,4);
floyd = round(floyd,4);
toado = xlsread('toa_do.xlsx','Toa do','B2:D2310');
x = toado(:,1);
y = toado(:,2);
z = toado(:,3);

load tdv;
load time_2;
[num txt] = xlsread('toa_do.xlsx','thong so vtlt','A2:K4001');
A = string(num(:,1));
A = cellstr(A);
E = txt(:,3);
F = string(num(:,6));
F = cellstr(F);
H = string(num(:,8));
H = cellstr(H);
I = int2str(num(:,9));
I = cellstr(I);
J = string(txt(:,8));
J = cellstr(J);
K = txt(:,9);

T = [A E F H I J];

%loai hang
txt1 = {};
type_good_list = {};
AGV_IDNumber = {};
crossing = 0;
headon = 0;

luot_cuoi = 0;
demlanve = 0;
random_number = 0;

AGV_ID2_list = {};
path_them = {};
check_path1 = {};
check_path2 = {};
check_path3 = {};
check_path4 = {};
check_path4_2 = {};
check_path5 = {};
check_path6 = {};
check_path7 = {};
check_timeinout1 = {};
check_timeinout2 = {};
check_timeinout3 = {};
check_timeinout4 = {};
check_timeinout5 = {};
check_AGV_IDNumber1 = {};
check_AGV_IDNumber2 = {};
check_AGV_IDNumber3 = {};
check_AGV_IDNumber4 = {};
check_AGV_IDNumber5 = {};
check_AGV_IDNumber6 = {};
check_AGV_IDNumber7 = {};
check_AGV_IDNumber8 = {};
check_veluutru = {};
AGV_dangxet = {};
check_waiting_time = {};
check_headon = {};
check_headon1 = {};
AGV_ID_tam = {};
[num1 txt1] = xlsread('toa_do.xlsx','type_good_list');
type_good_list = [type_good_list; txt1];

%dem hang ton kho
hang_ton_kho;


%khoi tao AGV
AGV_number = 6;
for i = 1:AGV_number
    AGV_IDNumber{1,i}.IDNumber = i;
    AGV_IDNumber{1,i}.local_node = 2245 + i;
    AGV_IDNumber{1,i}.loading = 0;
    AGV_IDNumber{1,i}.mission = 0;
    AGV_IDNumber{1,i}.distination = 0;
    AGV_IDNumber{1,i}.mission_phase = []; %from/to
    AGV_IDNumber{1,i}.total_mission = {[0]};
    AGV_IDNumber{1,i}.work_distance = 0;
    AGV_IDNumber{1,i}.path = [];
    AGV_IDNumber{1,i}.path1 = []; %[x y z]
    AGV_IDNumber{1,i}.path1_size = 0;
    AGV_IDNumber{1,i}.another_path = [];
    AGV_IDNumber{1,i}.another_path1 = [];
    AGV_IDNumber{1,i}.shortest_path = [];
    AGV_IDNumber{1,i}.bo_headon = [];
    AGV_IDNumber{1,i}.change_time = 0;
    AGV_IDNumber{1,i}.change = 0;
    AGV_IDNumber{1,i}.type_mission = [];
    AGV_IDNumber{1,i}.working_time = 0;
    AGV_IDNumber{1,i}.waiting_time = 0;
    AGV_IDNumber{1,i}.waiting_time_them = 0;
    AGV_IDNumber{1,i}.loading_time = 0;
    AGV_IDNumber{1,i}.unloading_time = 0;
    AGV_IDNumber{1,i}.idle_time = 0;
    AGV_IDNumber{1,i}.empty_time = 0;
    AGV_IDNumber{1,i}.full_load_time = 0;
end

time3 = {};
AGV_ID = [];
veduong = [];
AGV_ID3 = [];
AGV_ID4 = [];
location_list = [2246,2247,2248,2249,2250,2251];
cua_nhan = [2240 2241 2242 2243 2244 2245];

n = 50;
type = 5;
sltiendo = vitritrong;
sltiendo1 = vitritrong;

COL;

start_time = datetime;

%% Qua trinh thuc hien don hang
AGV_trong = 1;
phase_mission = 1;
%lay moc thoi gian cho toan bo qua trinh
time_0 = datenum(datetime);
time_tam = 0;
luot_chay = 0;

while size(vtlt,1) ~= 0 || AGV_trong ~= 0 || phase_mission ~= 0
% for checkkq = 1:1
luot_chay = luot_chay + 1;
fprintf('*************** Luot chay theo vong: %d\n',luot_chay);

%ktr thong so trang thai agv
    for k_check = 1:AGV_number
        if k_check == 1
%             check_path1{size(check_path1,1)+1,k_check} = AGV_IDNumber{1,k_check}.path;
            check_AGV_IDNumber1{size(check_AGV_IDNumber1,1)+1,k_check} = AGV_IDNumber{1,k_check};
        else
%             check_path1{size(check_path1,1),k_check} = AGV_IDNumber{1,k_check}.path;
            check_AGV_IDNumber1{size(check_AGV_IDNumber1,1),k_check} = AGV_IDNumber{1,k_check};
        end
    end
    
            %% GIao nhiem 
    AGV_trong = 1;
    AGV_ID2 = [];
    while size(vtlt,1) ~= 0 && AGV_trong ~= 0
        AGV_trong = 0;
        for k2 = 1:size(AGV_IDNumber,2)
            if AGV_IDNumber{1,k2}.loading == 0
                AGV_trong = AGV_trong + 1;
            end
        end
        if AGV_trong ~= 0 && size(vtlt,1) ~= 0
            
            %chon random nhiem vu
            random_number = randperm(size(vtlt,1),1);
            end_p = str2num(vtlt{random_number,1});
            type_mission = vtlt{random_number,3};
            dispatching_AGV;
            sltiendo = sltiendo - 1;
            vtlt(random_number,:) = [];

%             %thuc hien lan luot theo list
%             end_p = str2num(vtlt{1,1});
%             type_mission = vtlt{1,3};
%             dispatching_AGV;
%             sltiendo = sltiendo - 1;
%             vtlt(1,:) = [];
        else
            break
        end
    end
    
    
    %xet nhung xe chua hoan thanh nhiem vu
    for k2 = 1:size(AGV_IDNumber,2)
        if (size(AGV_IDNumber{1,k2}.path,2) == 0) && (size(AGV_IDNumber{1,k2}.mission_phase,2) ~= 0)
            AGV_ID2 = [AGV_ID2 AGV_IDNumber{1,k2}.IDNumber];
        end
    end
    AGV_ID2;
    
    for k2 = 1:size(AGV_ID2,2)
        check_number = find(AGV_ID == AGV_ID2(1,k2));
        if size(check_number,2) == 0
            AGV_ID = [AGV_ID AGV_ID2(1,k2)];
        end
    end
    
                
    
        %% Lay duong
    for k3 = 1:size(AGV_ID,2)
        if (AGV_IDNumber{1,AGV_ID(1,k3)}.loading == 1) && (size(AGV_IDNumber{1,AGV_ID(1,k3)}.path,2) == 0)
            IDNumber = AGV_ID(1,k3);
            if AGV_IDNumber{1,AGV_ID(1,k3)}.type_mission == 1 && size(AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase,2) == 0
                vitricua = randperm(size(cua_nhan,2),1);
                AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase = [AGV_IDNumber{1,AGV_ID(1,k3)}.local_node, cua_nhan(1,vitricua)]; %start
                AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase = [AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase; [cua_nhan(1,vitricua) , AGV_IDNumber{1,AGV_ID(1,k3)}.mission(1,1)]]; %end
            end
            if AGV_IDNumber{1,AGV_ID(1,k3)}.type_mission == 0 && size(AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase,2) == 0
                vitricua = randperm(size(cua_nhan,2),1);
                AGV_IDNumber{1,AGV_ID(1,k3).mission_phase} = [AGV_IDNumber{1,AGV_ID(1,k3)}.local_node, AGV_IDNumber{1,AGV_ID(1,k3)}.mission(1,1)];
                AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase = [AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase; [AGV_IDNumber{1,AGV_ID(1,k3)}.mission(1,1), cua_nhan(1,vitricua)]];
            end
            path = {};
            start_p = AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase(1,1);
            end_p = AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase(2,1);
            AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase(:,1) = [];
            
            routing_AGV_collision_headon;
            AGV_IDNumber{1,AGV_ID(1,k3)}.path = A_path{1,1};
            AGV_IDNumber{1,AGV_ID(1,k3)}.shortest_path = AGV_IDNumber{1,AGV_ID(1,k3)}.path;
            if size(A_path,2) > 1
                A_path(:,1) = [];
                AGV_IDNumber{1,AGV_ID(1,k3)}.another_path = A_path;
                AGV_IDNumber{1,AGV_ID(1,k3)}.another_path1 = A_path;
            end
            text_path = num2str(AGV_IDNumber{1,AGV_ID(1,k3)}.path(1,1));
            for k4 = 2:size(AGV_IDNumber{1,AGV_ID(1,k3)}.path,2)
                text_path = strcat(text_path,'-',num2str(AGV_IDNumber{1,AGV_ID(1,k3)}.path(1,k4)));
            end
%             for k4 = 1:size(kq,1)
%                 if AGV_ID(1,k3) == kq{k4,4}
%                     kq{k4,3} = text_path;
%                 end
%             end
        end
    end
 
%     fprintf('truoc');
    for k_check = 1:AGV_number
        if k_check == 1
            check_path1{size(check_path1,1)+1,k_check} = AGV_IDNumber{1,k_check}.path;
            check_AGV_IDNumber2{size(check_AGV_IDNumber2,1)+1,k_check} = AGV_IDNumber{1,k_check};
        else
            check_path1{size(check_path1,1),k_check} = AGV_IDNumber{1,k_check}.path;
            check_AGV_IDNumber2{size(check_AGV_IDNumber2,1),k_check} = AGV_IDNumber{1,k_check};
        end
    end
    check_timeinout1{size(check_timeinout1,1)+1,1} = time_in;
    check_timeinout1{size(check_timeinout1,1),2} = time_out;
    %% Collision Dectection and Avoidance
    Collision_Avoidance_AGV1;
    
    for k_check = 1:AGV_number
        if k_check == 1
            check_path1{size(check_path1,1)+1,k_check} = AGV_IDNumber{1,k_check}.path;
            check_AGV_IDNumber3{size(check_AGV_IDNumber3,1)+1,k_check} = AGV_IDNumber{1,k_check};
        else
            check_path1{size(check_path1,1),k_check} = AGV_IDNumber{1,k_check}.path;
            check_AGV_IDNumber3{size(check_AGV_IDNumber3,1),k_check} = AGV_IDNumber{1,k_check};
        end
    end
    
%     fprintf('sau');
    for k_check = 1:AGV_number
        if k_check == 1
            check_path2{size(check_path2,1)+1,k_check} = AGV_IDNumber{1,k_check}.path;
%             check_AGV_IDNumber2{size(check_AGV_IDNumber2,1)+1,k_check} = AGV_IDNumber{1,k_check};
        else
            check_path2{size(check_path2,1),k_check} = AGV_IDNumber{1,k_check}.path;
%             check_AGV_IDNumber2{size(check_AGV_IDNumber2,1),k_check} = AGV_IDNumber{1,k_check};
        end
        if size(check_path2{size(check_path2,1),k_check},2) == 0 && k_check == 1 
            check_path5{size(check_path5,1)+1,k_check} = [];
        end
        for k_check1 = 1:size(check_path2{size(check_path2,1),k_check},2)
            if size(check_path2{size(check_path2,1),k_check},1) ~= 5
                if (k_check == 1 && k_check1 == 1)
                    check_path5{size(check_path5,1)+1,k_check}(1,k_check1) = string(datetime(check_path2{size(check_path2,1),k_check}(6,k_check1),'ConvertFrom','datenum'));
                else
                    check_path5{size(check_path5,1),k_check}(1,k_check1) = string(datetime(check_path2{size(check_path2,1),k_check}(6,k_check1),'ConvertFrom','datenum'));
                end
                check_path5{size(check_path5,1),k_check}(2,k_check1) = string(datetime(check_path2{size(check_path2,1),k_check}(7,k_check1),'ConvertFrom','datenum'));
                check_path2{size(check_path2,1),k_check}(8,k_check1) = (check_path2{size(check_path2,1),k_check}(7,k_check1) - check_path2{size(check_path2,1),k_check}(6,k_check1))*24*3600;
        
            end
        end
    end
    check_timeinout2{size(check_timeinout2,1)+1,1} = time_in;
    check_timeinout2{size(check_timeinout2,1),2} = time_out;
    
    AGV_ID_tam1 = AGV_ID2;
    while size(AGV_ID3,2) ~= 0 
        AGV_ID2 = AGV_ID3;
%         for iii = 1:size(AGV_ID2)
%             if size(AGV_IDNumber{1,AGV_ID2(1,iii)}.path,2) == size(AGV_IDNumber{1,AGV_ID2(1,iii)}.shortest_path,2)
%                 if AGV_IDNumber{1,AGV_ID2(1,iii)}.path(1,:) == AGV_IDNumber{1,AGV_ID2(1,iii)}.shortest_path(1,:)
%                     AGV_IDNumber{1,AGV_ID2(1,iii)}.bo_headon = 1;
%                 else
%                     AGV_IDNumber{1,AGV_ID2(1,iii)}.bo_headon = 0;
%                 end
%             end
%         end
        Collision_Avoidance_AGV1;
%         for k_headon = 1:size(AGV_ID2)
%             [r c] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,k_headon)}.path(1,1));
%             if time_in(AGV_IDNumber{1,AGV_ID2(1,k_headon)}.IDNumber + 1,c) ~= 0
%                 [r c] = find(AGV_ID2 == AGV_IDNumber{1,AGV_ID2(1,k_headon)}.IDNumber);
%                 AGV_ID2(:,c) = [];
%             end
%         end
    end
    AGV_ID2 = AGV_ID_tam1;
    
    %Tra headon lai tap rong
    for iii = 1:AGV_number
        AGV_IDNumber{1,iii}.bo_headon = [];
    end
    
    
     for k_check = 1:AGV_number
        if k_check == 1
%             check_path1{size(check_path1,1)+1,k_check} = AGV_IDNumber{1,k_check}.path;
            check_AGV_IDNumber4{size(check_AGV_IDNumber4,1)+1,k_check} = AGV_IDNumber{1,k_check};
        else
%             check_path1{size(check_path1,1),k_check} = AGV_IDNumber{1,k_check}.path;
            check_AGV_IDNumber4{size(check_AGV_IDNumber4,1),k_check} = AGV_IDNumber{1,k_check};
        end
     end
     
    
    

    %
    
    check_path7{size(check_path7,1)+1,k_check} = [];
    for k_check = 1:AGV_number
        if size(AGV_IDNumber{1,k_check}.path,2) ~= 0
            check_path7{size(check_path7,1),k_check} = AGV_IDNumber{1,k_check}.timeline;
        end
    end
    %% Chia nho duong di cac AGV vua tim duong
    for k_path1 = 1:size(AGV_ID2,2) %xet voi moi AGV
        %gan vao path moi
        AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1 = AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path(1,:);
        AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(5,:) = AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path(5,:);
        AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(6,:) = AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path(6,:);
        AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(7,:) = AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path(7,:);
        %lay toa do x y z
        for k_path2 = 1:size(AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1,2)
            AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(2,k_path2) = x(AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(5,k_path2),1);
            AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(3,k_path2) = y(AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(5,k_path2),1);
            AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(4,k_path2) = z(AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(5,k_path2),1);
        end
        %chia nho quang duong thanh delta doan
        path_tam = [];
        phan_du = 0;
        for k_path3 = 1:size(AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1,2)
            deta = floor((AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(7,k_path3) - AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(6,k_path3) + phan_du)*24*3600/0.3);
            phan_du = ((AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(7,k_path3) - AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(6,k_path3) + phan_du)*24*3600 - 0.3*deta)/24/3600;
            x_path = (x(AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(1,k_path3),1) - x(AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(5,k_path3),1))/deta;
            y_path = (y(AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(1,k_path3),1) - y(AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(5,k_path3),1))/deta;
            z_path = (z(AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(1,k_path3),1) - z(AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(5,k_path3),1))/deta;
            if k_path3 ~= size(AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1,2)
                for k_path4 = 0:(deta-1)
                    path_tam(1,size(path_tam,2)+1) = AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(1,k_path3);
                    path_tam(2,size(path_tam,2)) = AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(2,k_path3) + k_path4*x_path;
                    path_tam(3,size(path_tam,2)) = AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(3,k_path3) + k_path4*y_path;
                    path_tam(4,size(path_tam,2)) = AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(4,k_path3) + k_path4*z_path;
                    path_tam(5,size(path_tam,2)) = AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(5,k_path3);
                end
            else
                for k_path4 = 0: deta
                    path_tam(1,size(path_tam,2)+1) = AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(1,k_path3);
                    path_tam(2,size(path_tam,2)) = AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(2,k_path3) + k_path4*x_path;
                    path_tam(3,size(path_tam,2)) = AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(3,k_path3) + k_path4*y_path;
                    path_tam(4,size(path_tam,2)) = AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(4,k_path3) + k_path4*z_path;
                    path_tam(5,size(path_tam,2)) = AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1(5,k_path3);
                end
            end
        end
        AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1 = path_tam;
        AGV_IDNumber{1,AGV_ID2(1,k_path1)}.path1_size = size(path_tam,2);
    end
    

    %check doi voi nhung xe bi change time
%     if luot_chay ~= 1
        for k_path1 = 1:AGV_number
            if AGV_IDNumber{1,k_path1}.change_time == 1
%                 fprintf('Thuc hien thay doi co duong cho xe %d (thuc hien change_time)\n',AGV_IDNumber{1,k_path1}.IDNumber);
                coduong = AGV_IDNumber{1,k_path1}.path1_size;
                size_tam = size(AGV_IDNumber{1,k_path1}.path1,2);
                [r c] = find(AGV_IDNumber{1,k_path1}.path == AGV_IDNumber{1,k_path1}.path1(1,1));
                vitrihientai = AGV_IDNumber{1,k_path1}.path1(:,1);
                
                path_tam = [];
                if AGV_IDNumber{1,k_path1}.waiting_time_them ~= 0
                    fprintf('Thuc hien thay doi co duong cho xe %d (thuc hien change_time voi vi tri hien tai)\n',AGV_IDNumber{1,k_path1}.IDNumber);
                    deta = floor(AGV_IDNumber{1,k_path1}.waiting_time_them/0.3);
                    for k_path3 = 1:deta
                        path_tam(1,k_path3) = vitrihientai(1,1);
                        path_tam(2,k_path3) = vitrihientai(2,1);
                        path_tam(3,k_path3) = vitrihientai(3,1);
                        path_tam(4,k_path3) = vitrihientai(4,1);
                        path_tam(5,k_path3) = vitrihientai(5,1);
                    end
                else
                    fprintf('Thuc hien thay doi co duong cho xe %d (thuc hien change_time)\n',AGV_IDNumber{1,k_path1}.IDNumber);
                    [r c] = find(AGV_IDNumber{1,k_path1}.path1 == AGV_IDNumber{1,k_path1}.path1(1,1));
                    for k_path3 = 1:size(c,2)
                        path_tam(1,k_path3) = vitrihientai(1,k_path3);
                        path_tam(2,k_path3) = vitrihientai(2,k_path3);
                        path_tam(3,k_path3) = vitrihientai(3,k_path3);
                        path_tam(4,k_path3) = vitrihientai(4,k_path3);
                        path_tam(5,k_path3) = vitrihientai(5,k_path3);
                    end
                end
                %gan vao path moi
                AGV_IDNumber{1,k_path1}.path1 = AGV_IDNumber{1,k_path1}.path(1,c:size(AGV_IDNumber{1,k_path1}.path,2));
                AGV_IDNumber{1,k_path1}.path1(5,:) = AGV_IDNumber{1,k_path1}.path(5,c:size(AGV_IDNumber{1,k_path1}.path,2));
                AGV_IDNumber{1,k_path1}.path1(6,:) = AGV_IDNumber{1,k_path1}.path(6,c:size(AGV_IDNumber{1,k_path1}.path,2));
                AGV_IDNumber{1,k_path1}.path1(7,:) = AGV_IDNumber{1,k_path1}.path(7,c:size(AGV_IDNumber{1,k_path1}.path,2));
                %lay toa do x y z
                for k_path2 = 1:size(AGV_IDNumber{1,k_path1}.path1,2)
                    AGV_IDNumber{1,k_path1}.path1(2,k_path2) = x(AGV_IDNumber{1,k_path1}.path1(5,k_path2),1);
                    AGV_IDNumber{1,k_path1}.path1(3,k_path2) = y(AGV_IDNumber{1,k_path1}.path1(5,k_path2),1);
                    AGV_IDNumber{1,k_path1}.path1(4,k_path2) = z(AGV_IDNumber{1,k_path1}.path1(5,k_path2),1);
                end
                %chia nho quang duong thanh delta doan
                phan_du = 0;
                for k_path3 = 2:size(AGV_IDNumber{1,k_path1}.path1,2)
                    deta = floor((AGV_IDNumber{1,k_path1}.path1(7,k_path3) - AGV_IDNumber{1,k_path1}.path1(6,k_path3) + phan_du)*24*3600/0.3);
                    phan_du = ((AGV_IDNumber{1,k_path1}.path1(7,k_path3) - AGV_IDNumber{1,k_path1}.path1(6,k_path3) + phan_du)*24*3600 - 0.3*deta)/24/3600;
                    x_path = (x(AGV_IDNumber{1,k_path1}.path1(1,k_path3),1) - x(AGV_IDNumber{1,k_path1}.path1(5,k_path3),1))/deta;
                    y_path = (y(AGV_IDNumber{1,k_path1}.path1(1,k_path3),1) - y(AGV_IDNumber{1,k_path1}.path1(5,k_path3),1))/deta;
                    z_path = (z(AGV_IDNumber{1,k_path1}.path1(1,k_path3),1) - z(AGV_IDNumber{1,k_path1}.path1(5,k_path3),1))/deta;
                    if k_path3 ~= size(AGV_IDNumber{1,k_path1}.path1,2)
                        for k_path4 = 0:(deta-1)
                            path_tam(1,size(path_tam,2)+1) = AGV_IDNumber{1,k_path1}.path1(1,k_path3);
                            path_tam(2,size(path_tam,2)) = AGV_IDNumber{1,k_path1}.path1(2,k_path3) + k_path4*x_path;
                            path_tam(3,size(path_tam,2)) = AGV_IDNumber{1,k_path1}.path1(3,k_path3) + k_path4*y_path;
                            path_tam(4,size(path_tam,2)) = AGV_IDNumber{1,k_path1}.path1(4,k_path3) + k_path4*z_path;
                            path_tam(5,size(path_tam,2)) = AGV_IDNumber{1,k_path1}.path1(5,k_path3);
                        end
                    else
                        for k_path4 = 0: deta
                            path_tam(1,size(path_tam,2)+1) = AGV_IDNumber{1,k_path1}.path1(1,k_path3);
                            path_tam(2,size(path_tam,2)) = AGV_IDNumber{1,k_path1}.path1(2,k_path3) + k_path4*x_path;
                            path_tam(3,size(path_tam,2)) = AGV_IDNumber{1,k_path1}.path1(3,k_path3) + k_path4*y_path;
                            path_tam(4,size(path_tam,2)) = AGV_IDNumber{1,k_path1}.path1(4,k_path3) + k_path4*z_path;
                            path_tam(5,size(path_tam,2)) = AGV_IDNumber{1,k_path1}.path1(5,k_path3);
                        end
                    end
                    
                end
                coduonghientai = size(AGV_IDNumber{1,k_path1}.path1,2);
%                 size_tam = AGV_IDNumber{1,k_path1}.path1_size - size_tam;
                AGV_IDNumber{1,k_path1}.path1_size = size(path_tam,2);
%                 coduongmoi = AGV_IDNumber{1,k_path1}.path1_size;
%                 path_tam(:,1:size_tam) = [];
                AGV_IDNumber{1,k_path1}.path1 = path_tam;
%                 coduongsaukhitru = size(AGV_IDNumber{1,k_path1}.path1,2);
                AGV_IDNumber{1,k_path1}.change_time = 0;
            end
        end
%     end
    
    
    
% %     fprintf('sau path1');
    for k_check = 1:AGV_number
        if k_check == 1
            check_path3{size(check_path3,1)+1,k_check} = AGV_IDNumber{1,k_check}.path1;
%             check_AGV_IDNumber3{size(check_AGV_IDNumber3,1)+1,k_check} = AGV_IDNumber{1,k_check};
        else
            check_path3{size(check_path3,1),k_check} = AGV_IDNumber{1,k_check}.path1;
%             check_AGV_IDNumber3{size(check_AGV_IDNumber3,1),k_check} = AGV_IDNumber{1,k_check};
        end
    end
    
        
    for k_check = 1:AGV_number
        if k_check == 1
%             check_path4{size(check_path4,1)+1,k_check} = AGV_IDNumber{1,k_check}.path1;
            check_AGV_IDNumber5{size(check_AGV_IDNumber5,1)+1,k_check} = AGV_IDNumber{1,k_check};
        else
%             check_path4{size(check_path4,1),k_check} = AGV_IDNumber{1,k_check}.path1;
            check_AGV_IDNumber5{size(check_AGV_IDNumber5,1),k_check} = AGV_IDNumber{1,k_check};
        end
    end
    
        
        
        

    %% Following path
    following_path;
    %check duong con lai sau di chuyen
    for k_check = 1:AGV_number
        if k_check == 1
            check_path4{size(check_path4,1)+1,k_check} = AGV_IDNumber{1,k_check}.path1;
%             check_AGV_IDNumber5{size(check_AGV_IDNumber5,1)+1,k_check} = AGV_IDNumber{1,k_check};
        else
            check_path4{size(check_path4,1),k_check} = AGV_IDNumber{1,k_check}.path1;
%             check_AGV_IDNumber5{size(check_AGV_IDNumber5,1),k_check} = AGV_IDNumber{1,k_check};
        end
    end
    
    %% Cap nhat trang thai vi tri kho
%     axes(handles.axes1);
    [I J] = xlsread('toa_do.xlsx','thong so vtlt','I2:J4001'); %trangthai type
    I = int2str(I);
    I = cellstr(I);
    color_matrix = {[1 0 0]; [0 1 0]; [0 0 1]; [0 1 1];
                [1 0 1]; [1 1 0]; [0 0.4470 0.7410]; [0.8500 0.3250 0.0980]; [0.9290 0.6940 0.1250];
                [0.4940 0.1840 0.5560]; [0.4660 0.6740 0.1880]; [0.3010 0.7450 0.9330]; [0.6350 0.078 0.184]};
    
    AGV_ID1 = AGV_ID;
    check_veluutru{size(check_veluutru,1)+1,1} = {};
    for k5 = 1:size(AGV_ID,2)
%         fprintf('Thong tin truoc patch cua xe: %d\n',AGV_IDNumber{1,AGV_ID(1,k5)}.IDNumber);
        check_veluutru{size(check_veluutru,1),k5}{1,1} = AGV_IDNumber{1,AGV_ID(1,k5)}.IDNumber;
        check_veluutru{size(check_veluutru,1),k5}{1,2} = size(AGV_IDNumber{1,AGV_ID(1,k5)}.path1,2);
        check_veluutru{size(check_veluutru,1),k5}{1,3} = AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,1);
        check_veluutru{size(check_veluutru,1),k5}{1,4} = AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2);
        check_veluutru{size(check_veluutru,1),k5}{1,5} = AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase;
        
        if (size(AGV_IDNumber{1,AGV_ID(1,k5)}.path1,2) == 0) && (AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,1) ~= 0) && size(AGV_IDNumber{1,AGV_ID(1,k5)}.mission_phase,2) == 0
            loai1 = type_good_list(:,1);
            loai1(1,:) = [];
            loai1 = cell2mat(loai1);
            [r c] = find(loai1 == type);
            demlanve = demlanve + 1;
%             fprintf('Lan %d; Xe: %d; vi tri luu tru: %d; toa do: %f %f %f %f\n',demlanve, AGV_IDNumber{1,AGV_ID(1,k5)}.IDNumber, AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),M(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),N(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),P(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),O(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1));
            
%             patch([M(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),N(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),N(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),M(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1)],[O(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),O(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),P(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),P(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1)],[0 0 0 0],'FaceColor',color_matrix{r,1});
%             text(M(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1)+0.1,(O(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1)+P(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1))/2,J{AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1},'FontSize',4);
            AGV_IDNumber{1,AGV_ID(1,k5)}.mission = [0 0];
            AGV_IDNumber{1,AGV_ID(1,k5)}.path = [];
%             for time0 = 1:562
%                 time_in(AGV_ID(1,k5)+1,time0) = 0;
%                 time_out(AGV_ID(1,k5)+1,time0) = 0;
%             end
%             for k6 = 1:size(kq,1)
%                 if k6 <= size(kq,1)
%                     if AGV_ID(1,k5) == kq{k6,4}
%                         kq(k6,:)=[];
%                         set(handles.path_table,'Data',kq);
%                     end
%                 end
%             end
            [r c] = find(AGV_ID1 == AGV_ID(1,k5));
            AGV_ID1(:,c) = [];
        end
        if (size(AGV_IDNumber{1,AGV_ID(1,k5)}.path1,2) == 0) && size(AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase,2) ~= 0 %&& (AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,1) ~= 0)
            [r c] = find(AGV_ID1 == AGV_ID(1,k5));
            AGV_ID1(:,c) = [];
        end
    end
    AGV_ID = AGV_ID1;
    
    phase_mission = 0;
    for k9 = 1:AGV_number
        if size(AGV_IDNumber{1,k9}.mission_phase,2) ~= 0
            phase_mission = phase_mission + 1;
        end
    end
    
    
    for k_check = 1:AGV_number
        if k_check == 1
    %             check_path1{size(check_path1,1)+1,k_check} = AGV_IDNumber{1,k_check}.path;
            check_AGV_IDNumber6{size(check_AGV_IDNumber6,1)+1,k_check} = AGV_IDNumber{1,k_check};
        else
    %             check_path1{size(check_path1,1),k_check} = AGV_IDNumber{1,k_check}.path;
            check_AGV_IDNumber6{size(check_AGV_IDNumber6,1),k_check} = AGV_IDNumber{1,k_check};
        end
    end
end

drawnow;
pause(0.01);
if size(location_list,2) ~= 0
    delete(head1);
end

%% Di chuyen cac xe ve vi tri do
AGV_saivitri = 0;
%     location_list = [2257,2258,2259,2260,2261,2262];
AGV_saivitri_list_tam = [1 2 3 4 5 6];
AGV_saivitri_list = AGV_saivitri_list_tam(:,1:AGV_number);
%     location_list = [2257,2258,2259,2260,2261,2262];
% for i_vitri = 1:AGV_number
%     AGV_IDNumber{1,i_vitri}.IDNumber
%     AGV_IDNumber{1,i_vitri}.local_node
% end
location_list_tam = [2246,2247,2248,2249,2250,2251];
location_list = location_list_tam(:,1:AGV_number);
for i_vitri = 1:AGV_number
    check_local = find(location_list == AGV_IDNumber{1,i_vitri}.distination);
    if size(check_local,2) ~= 0
        [r c] = find(location_list == AGV_IDNumber{1,i_vitri}.distination);
        location_list(:,c) = [];
        [r c] = find(AGV_saivitri_list == AGV_IDNumber{1,i_vitri}.IDNumber);
        AGV_saivitri_list(:,c) = [];
    end
end



if size(AGV_saivitri_list,2) ~= 0
    for i_vitri = 1:size(AGV_saivitri_list,2)
        % tim duong
        path = {};
        start_p = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.local_node;
        %tim vi tri do
        end_p = location_list(1,1);
        location_list(:,1) = [];
%         routing_AGV_collision;
        
        routing_AGV_collision_headon;
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path = path{1,1};
        % check collision
        AGV_ID2 = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.IDNumber;
        time_tam = datenum(datetime);
        Collision_Avoidance_AGV1;
        k_size = size(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path,2);
        AGV_ID_tam{1,size(AGV_ID_tam,2)+1} = AGV_ID2;
        while size(AGV_ID3,2) ~= 0 
            AGV_ID2 = AGV_ID3;
            Collision_Avoidance_AGV1;
            for k_headon = 1:size(AGV_ID2)
                [r c] = find(time_in(1,:) == AGV_IDNumber{1,AGV_ID2(1,k_headon)}.path(1,1));
                if time_in(AGV_IDNumber{1,AGV_ID2(1,k_headon)}.IDNumber + 1,c) ~= 0
                    [r c] = find(AGV_ID2 == AGV_IDNumber{1,AGV_ID2(1,k_headon)}.IDNumber);
                    AGV_IDNumber{1,AGV_ID2(1,c)}.change_time = 0;
                    AGV_ID2(:,c) = [];
                end
            end
        end
        AGV_ID2 = AGV_ID_tam{1,size(AGV_ID_tam,2)};
        AGV_ID_tam(:,size(AGV_ID_tam,2)) = [];
        
        %Thoi gian di chuyen ve khong tinh vao working_time
%         [r3 c3] = find(time_in == AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(1,k_size));
%         [r4 c4] = find(time_in == AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(1,1));
%         AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.working_time = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.working_time + time_out(AGV_saivitri_list(1,i_vitri)+1,c3) - time_in(AGV_saivitri_list(1,i_vitri)+1,c4);
        % chia nho duong di
        %gan vao path moi
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1 = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(1,:);
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,:) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(5,:);
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(6,:) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(6,:);
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(7,:) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(7,:);
%         %lay toa do x y z
%         for k_path2 = 1:size(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1,2)
%             if k_path2 <= (size(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1,2) - 2) &&  (AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(1,k_path2) < 2224 || AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(1,k_path2) > 2251)
%                 if x(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(1,k_path2),1) ~= x(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(1,k_path2+2),1) && y(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(1,k_path2),1) ~= y(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(1,k_path2+2),1)
%                     AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(6,k_path2+2) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(7,k_path2);
%                     AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path2+2) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(1,k_path2);
%                     AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(:,k_path2+1) = [];
%                 end
%             end
%         end
        %lay toa do x y z
        for k_path2 = 1:size(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1,2)
            AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(2,k_path2) = x(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path2),1);
            AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(3,k_path2) = y(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path2),1);
            AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(4,k_path2) = z(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path2),1);
        end
        %chia nho quang duong thanh delta doan
        path_tam = [];
        for k_path3 = 2:size(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1,2)
            deta = floor((AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(7,k_path3) - AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(6,k_path3))*24*3600/0.3);
%                 x_path = (AGV_IDNumber{1,i_vitri}.path1(2,k_path3) - AGV_IDNumber{1,i_vitri}.path1(2,k_path3 - 1))/deta;
%                 y_path = (AGV_IDNumber{1,i_vitri}.path1(3,k_path3) - AGV_IDNumber{1,i_vitri}.path1(3,k_path3 - 1))/deta;
%                 z_path = (AGV_IDNumber{1,i_vitri}.path1(4,k_path3) - AGV_IDNumber{1,i_vitri}.path1(4,k_path3 - 1))/deta;
            x_path = (x(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(1,k_path3),1) - x(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path3),1))/deta;
            y_path = (y(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(1,k_path3),1) - y(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path3),1))/deta;
            z_path = (z(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(1,k_path3),1) - z(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path3),1))/deta;
            if k_path3 ~= size(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1,2)
                for k_path4 = 0:(deta-1)
                    path_tam(1,size(path_tam,2)+1) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(1,k_path3);
                    path_tam(2,size(path_tam,2)) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(2,k_path3) + k_path4*x_path;
                    path_tam(3,size(path_tam,2)) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(3,k_path3) + k_path4*y_path;
                    path_tam(4,size(path_tam,2)) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(4,k_path3) + k_path4*z_path;
                    path_tam(5,size(path_tam,2)) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path3);
                end
            else
                for k_path4 = 0:deta
                    path_tam(1,size(path_tam,2)+1) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(1,k_path3);
                    path_tam(2,size(path_tam,2)) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(2,k_path3) + k_path4*x_path;
                    path_tam(3,size(path_tam,2)) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(3,k_path3) + k_path4*y_path;
                    path_tam(4,size(path_tam,2)) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(4,k_path3) + k_path4*z_path;
                    path_tam(5,size(path_tam,2)) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path3);
                end
            end
        end
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1 = path_tam; 
    end
end

for k_check = 1:AGV_number
    if k_check == 1
%             check_path1{size(check_path1,1)+1,k_check} = AGV_IDNumber{1,k_check}.path;
        check_AGV_IDNumber6{size(check_AGV_IDNumber6,1)+1,k_check} = AGV_IDNumber{1,k_check};
    else
%             check_path1{size(check_path1,1),k_check} = AGV_IDNumber{1,k_check}.path;
        check_AGV_IDNumber6{size(check_AGV_IDNumber6,1),k_check} = AGV_IDNumber{1,k_check};
    end
end

luot_cuoi = 1;
following_path;
% saveas(gcf,strcat('order =',32,num2str(order)),'png');
end
end_time = datetime
for i = 1:size(path_them,2)
    for ii = 1:size(path_them{2,i},2)
        path_them{2,i}(8,ii) = (path_them{2,i}(7,ii) - path_them{2,i}(6,ii))*24*3600;
        path_them{5,i}{1,ii} = path_them{2,i}(1,ii);
        path_them{5,i}{2,ii} = string(datetime(path_them{2,i}(6,ii),'ConvertFrom','datenum'));
        path_them{5,i}{3,ii} = string(datetime(path_them{2,i}(7,ii),'ConvertFrom','datenum'));
        path_them{5,i}{4,ii} = (path_them{2,i}(7,ii) - path_them{2,i}(6,ii))*24*3600;
    end
end
