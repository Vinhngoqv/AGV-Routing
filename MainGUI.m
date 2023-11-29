function varargout = MainGUI(varargin)
% MAINGUI MATLAB code for MainGUI.fig
%      MAINGUI, by itself, creates a new MAINGUI or raises the existing
%      singleton*.
%
%      H = MAINGUI returns the handle to a new MAINGUI or the handle to
%      the existing singleton*.
%
%      MAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI.M with the given input arguments.
%
%      MAINGUI('Property','Value',...) creates a new MAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainGUI

% Last Modified by GUIDE v2.5 19-May-2021 13:11:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MainGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MainGUI is made visible.
function MainGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainGUI (see VARARGIN)

% Choose default command line output for MainGUI

handles.output = hObject;
clc
global history_table dem1 dem2 dem3 dem4 dem5 dem6 tonghang vitritrong time3;
global n type  A B C D E F G H I J K M N O P stt node time tt T5 T;
global adj floyd x y z type_good_list tonkho loai AGV_number AGV_IDNumber;
global floyd_t floyd adj adj_t AGV_ID2 time_in time_out 
global head head1 crossing headon end_p start_p luot_chay check_headon check_headon1 check_path1 time_tam
global luot_cuoi check_AGV_IDNumber5 AGV_saivitri_list1 time_0 check_path6 check_waiting_time
global A_path AGV_ID3 AAA AGV_dangxet random_number cua_nhan AGV_ID4 check_AGV_IDNumber8 AGV_ID_tam path_them
global vi_tri_history


load distance_matrix1;
adj = round(adj,4);
floyd = round(floyd,4);
toado = xlsread('toa_do.xlsx','Toa do','B2:D2310');
x = toado(:,1);
y = toado(:,2);
z = toado(:,3);

load tdv;
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
K = cellstr(txt(:,9));

T = [A E F H I J];

%loai hang
txt1 = {};
type_good_list = {};
AGV_IDNumber = {};
[num1 txt1] = xlsread('toa_do.xlsx','type_good_list');
type_good_list = [type_good_list; txt1];
set(handles.mahang,'string',type_good_list);

%dem hang ton kho
hang_ton_kho
set(handles.tonkho,'Data',tonkho);
set(handles.soloai,'string',num2str(size(txt1,1)-1));
set(handles.tonghang,'string',tonghang);
set(handles.vitritrong,'string',vitritrong);


history;
if size(history_table,1) ~= 0
    set(handles.his_table,'Data',history_table(:,1:5));
else
    set(handles.his_table,'Data',history_table);
end
vi_tri_history = xlsread('toa_do.xlsx','vi_tri_history');
vi_tri_history = string(vi_tri_history);
vi_tri_history = cellstr(vi_tri_history);



%khoi tao AGV
luachon = questdlg('Lua chon khoi tao AGV:','Khoi tao AGV','Tao moi','Phien lam viec truoc','Tao moi');
switch luachon
    case 'Tao moi'
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
    case 'Phien lam viec truoc'
        load AGV_IDNumber_matrix;
end

set(handles.agv_status1,'string','idle');
set(handles.agv_status2,'string','idle');
set(handles.agv_status3,'string','idle');
set(handles.agv_status4,'string','idle');
set(handles.agv_status5,'string','idle');
set(handles.agv_status6,'string','idle');

set(handles.agv_position1,'string',num2str(AGV_IDNumber{1,1}.local_node));
set(handles.agv_position2,'string',num2str(AGV_IDNumber{1,2}.local_node));
set(handles.agv_position3,'string',num2str(AGV_IDNumber{1,3}.local_node));
set(handles.agv_position4,'string',num2str(AGV_IDNumber{1,4}.local_node));
set(handles.agv_position5,'string',num2str(AGV_IDNumber{1,5}.local_node));
set(handles.agv_position6,'string',num2str(AGV_IDNumber{1,6}.local_node));

set(handles.x1,'string',num2str(x(AGV_IDNumber{1,1}.local_node,1)));
set(handles.x2,'string',num2str(x(AGV_IDNumber{1,2}.local_node,1)));
set(handles.x3,'string',num2str(x(AGV_IDNumber{1,3}.local_node,1)));
set(handles.x4,'string',num2str(x(AGV_IDNumber{1,4}.local_node,1)));
set(handles.x5,'string',num2str(x(AGV_IDNumber{1,5}.local_node,1)));
set(handles.x6,'string',num2str(x(AGV_IDNumber{1,6}.local_node,1)));

set(handles.y1,'string',num2str(y(AGV_IDNumber{1,1}.local_node,1)));
set(handles.y2,'string',num2str(y(AGV_IDNumber{1,2}.local_node,1)));
set(handles.y3,'string',num2str(y(AGV_IDNumber{1,3}.local_node,1)));
set(handles.y4,'string',num2str(y(AGV_IDNumber{1,4}.local_node,1)));
set(handles.y5,'string',num2str(y(AGV_IDNumber{1,5}.local_node,1)));
set(handles.y6,'string',num2str(y(AGV_IDNumber{1,6}.local_node,1)));

set(handles.z1,'string',num2str(z(AGV_IDNumber{1,1}.local_node,1)));
set(handles.z2,'string',num2str(z(AGV_IDNumber{1,2}.local_node,1)));
set(handles.z3,'string',num2str(z(AGV_IDNumber{1,3}.local_node,1)));
set(handles.z4,'string',num2str(z(AGV_IDNumber{1,4}.local_node,1)));
set(handles.z5,'string',num2str(z(AGV_IDNumber{1,5}.local_node,1)));
set(handles.z6,'string',num2str(z(AGV_IDNumber{1,6}.local_node,1)));


axes(handles.axes3);
imshow('logotruong.png');

axes(handles.axes1);
ve_khu_vuc_luu_tru;
% ve_layout;

axes(handles.agv_simulation);
ve_duong_di;

%ve agv vao vi tri
head = [];
for i = 1:AGV_number
    head(1,size(head,2)+1) = fill3([x(AGV_IDNumber{1,i}.local_node,1)-1,x(AGV_IDNumber{1,i}.local_node,1)+1,x(AGV_IDNumber{1,i}.local_node,1)+1,x(AGV_IDNumber{1,i}.local_node,1)-1],[y(AGV_IDNumber{1,i}.local_node,1)-1,y(AGV_IDNumber{1,i}.local_node,1)-1,y(AGV_IDNumber{1,i}.local_node,1)+1,y(AGV_IDNumber{1,i}.local_node,1)+1],[z(AGV_IDNumber{1,i}.local_node,1) z(AGV_IDNumber{1,i}.local_node,1) z(AGV_IDNumber{1,i}.local_node,1) z(AGV_IDNumber{1,i}.local_node,1)],[0.8 1-0.15*i 0.1+0.15*i]);
%     head(1,size(head,2)) = text(x(AGV_IDNumber{1,i}.local_node,1),y(AGV_IDNumber{1,i}.local_node,1),z(AGV_IDNumber{1,i}.local_node,1),num2str(AGV_IDNumber{1,i}.IDNumber),'FontSize',8);
end

% tien do thuc hien don hang
set(handles.tiendo,'visible','off');
set(handles.tiendo1,'visible','off');
set(handles.start_time,'visible','off');
set(handles.start_time1,'visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on selection change in maxuat.
function maxuat_Callback(hObject, eventdata, handles)
% hObject    handle to maxuat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns maxuat contents as cell array
%        contents{get(hObject,'Value')} returns selected item from maxuat


% --- Executes during object creation, after setting all properties.
function maxuat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxuat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function slxuat_Callback(hObject, eventdata, handles)
% hObject    handle to slxuat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of slxuat as text
%        str2double(get(hObject,'String')) returns contents of slxuat as a double


% --- Executes during object creation, after setting all properties.
function slxuat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slxuat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in xuat.
function xuat_Callback(hObject, eventdata, handles)
% hObject    handle to xuat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global n type history_table start_p end_p kq dem1 dem2 dem3 dem4 dem5 dem6 tonghang vitritrong time3;
global vtxh A B C D E F G H I J K M N O P stt node time tt T5 T;
global adj floyd x y z type_good_list tonkho AGV_number AGV_IDNumber type_mission AGV_ID AGV_ID2 IDNumber;
global head head1 %bien ve
global floyd location_list
global floyd_t AGV_ID2 time_in time_out adj_t adj
global head head1 crossing headon end_p start_p luot_chay check_headon check_path1 time_tam time_0 check_path6 check_waiting_time
global A_path AGV_ID3 luot_cuoi random_number
global adj floyd x y z type_good_list tonkho loai AGV_number AGV_IDNumber;
global floyd_t adj_t AGV_ID2 time_in time_out 
global head head1 crossing headon end_p start_p luot_chay check_headon check_headon1 check_path1 time_tam
global luot_cuoi check_AGV_IDNumber5 AGV_saivitri_list1 time_0 check_path6 check_waiting_time
global A_path AGV_ID3 AAA AGV_dangxet random_number cua_nhan type_good_list AGV_ID4 check_AGV_IDNumber8 AGV_ID_tam path_them
global end_time t_dukien vi_tri_history
clc
load time_2;
% tien do thuc hien don hang

kq = {};
time3 = {};
AGV_ID = [];
veduong = [];
AGV_ID3 = [];
AGV_ID4 = [];
time_tam = [];
headon = 0;
crossing = 0;
luot_cuoi = 0;
demlanve = 0;
random_number = 0;
time3 = {};


path_them = {};
check_path1 = {};
check_path2 = {};
check_path3 = {};
check_path4 = {};
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


location_list = [2246,2247,2248,2249,2250,2251];
cua_nhan = [2240 2241 2242 2243 2244 2245];

%% Lay gia tri don hang
n = get(handles.soluong,'string');
n = str2num(n);
type = get(handles.mahang,'value');

FIFO;
axes(handles.axes1);
%Xd_vtxh;
co_chay = 0;
if size(vtxh,1) ~= 0
    co_chay = 1;
    history_table1{1,1} = strcat(32,32,32,32,'Out');
    history_table1{1,2} = strcat(32,32,32,32,char(datetime));
    history_table1{1,3} = strcat(32,32,32,type);
    history_table1{1,4} = num2str(n);
    sltiendo = n;
    sltiendo1 = n;
    set(handles.tiendo,'string',strcat(num2str(sltiendo),'/',num2str(sltiendo1)));
    set(handles.tiendo,'visible','on');
    set(handles.tiendo1,'visible','on');
    set(handles.start_time1,'string',string(datetime));
    set(handles.start_time,'visible','on');
    set(handles.start_time1,'visible','on');
    history_table1{1,5} = 0; %tong thoi gian thuc hien don hang
    history_table1{1,6} = 0; %thoi gian du kien
    history_table1{1,7} = strcat(num2str(vtxh{1,2}),';'); %tong hop vi tri luu tru
    if size(vi_tri_history,1) ~= 0
        vi_tri_history_tam = vi_tri_history;
        vi_tri_history = vi_tri_history(1,:);
        for i_history = 1:size(vi_tri_history,2)
            vi_tri_history{1,i_history} = [];
        end
        vi_tri_history = [vi_tri_history;vi_tri_history_tam];
    end
    vi_tri_history{1,1} = num2str(vtxh{1,2});
    for i = 2:size(vtxh,1)
        history_table1{1,7} = strcat(history_table1{1,7},32,num2str(vtxh{i,2}),';');
        vi_tri_history{1,i} = num2str(vtxh{i,2});
    end
    %% Cap nhat o cuoi
%     history_table1{1,5} = 0; %tong khoang cach di chuyen thuc hien don hang
%     history_table = [history_table1 ; history_table];
%     xlswrite('toa_do.xlsx',history_table,'system_history','A2');
%     history; %cho cung dang hien thi
%     set(handles.his_table,'Data',history_table(:,1:6));
    %%
    hang_ton_kho
    set(handles.tonkho,'Data',tonkho);
    set(handles.soloai,'string',num2str(size(txt1,1)-1));
    set(handles.tonghang,'string',tonghang);
    set(handles.vitritrong,'string',vitritrong);
end

%% Qua trinh thuc hien don hang
start_time = datetime;
AGV_trong = 1;
phase_mission = 1;
%lay moc thoi gian cho toan bo qua trinh
time_0 = datenum(datetime);
time_tam = 0;
luot_chay = 0;

while size(vtxh,1) ~= 0 || AGV_trong ~= 0 || phase_mission ~= 0
% for checkkq = 1:1
luot_chay = luot_chay + 1;
fprintf('*************** Luot chay theo vong: %d\n',luot_chay);
            %% GIao nhiem 
    AGV_trong = 1;
    AGV_ID2 = [];
    while size(vtxh,1) ~= 0 && AGV_trong ~= 0
        AGV_trong = 0;
        for k2 = 1:size(AGV_IDNumber,2)
            if AGV_IDNumber{1,k2}.loading == 0
                AGV_trong = AGV_trong + 1;
            end
        end
        if AGV_trong ~= 0 && size(vtxh,1) ~= 0
            %chon random nhiem vu
            random_number = randperm(size(vtxh,1),1);
            end_p = str2num(vtxh{random_number,1});
            type_mission = vtxh{random_number,3};
            dispatching_AGV;
            sltiendo = sltiendo - 1;
            set(handles.tiendo,'string',strcat(num2str(sltiendo),'/',num2str(sltiendo1)));
            set(handles.tiendo,'visible','on');
            set(handles.tiendo1,'visible','on');
%             kq{size(kq,1)+1,1} = AGV_IDNumber{1,AGV_ID2(1,size(AGV_ID2,2))}.local_node;
%             kq{size(kq,1),2} = str2num(vtxh{random_number,1});
%             kq{size(kq,1),4} = AGV_ID2(1,size(AGV_ID2,2));
            vtxh(random_number,:) = [];
            
%             %Lua chon don hang theo thu tu
%             end_p = str2num(vtxh{1,1});
%             type_mission = vtxh{1,3};
%             dispatching_AGV;
%             sltiendo = sltiendo - 1;
%             set(handles.tiendo,'string',strcat(num2str(sltiendo),'/',num2str(sltiendo1)));
%             set(handles.tiendo,'visible','on');
%             set(handles.tiendo1,'visible','on');
%             kq{size(kq,1)+1,1} = AGV_IDNumber{1,AGV_ID2(1,size(AGV_ID2,2))}.local_node;
%             kq{size(kq,1),2} = str2num(vtxh{1,1});
%             kq{size(kq,1),4} = AGV_ID2(1,size(AGV_ID2,2));
%             vtxh(1,:) = [];
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
                AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase = [AGV_IDNumber{1,AGV_ID(1,k3)}.local_node, AGV_IDNumber{1,AGV_ID(1,k3)}.mission(1,1)];
                AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase = [AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase; [AGV_IDNumber{1,AGV_ID(1,k3)}.mission(1,1), cua_nhan(1,vitricua)]];
            end
            path = {};
            start_p = AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase(1,1);
            end_p = AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase(2,1);
            AGV_IDNumber{1,AGV_ID(1,k3)}.mission_phase(:,1) = [];
            kq{size(kq,1)+1,1} = start_p;
            kq{size(kq,1),2} = end_p;
            kq{size(kq,1),4} = AGV_IDNumber{1,AGV_ID(1,k3)}.IDNumber;
            
            routing_AGV_collision_headon;
            AGV_IDNumber{1,AGV_ID(1,k3)}.path = A_path{1,1};
            AGV_IDNumber{1,AGV_ID(1,k3)}.shortest_path = AGV_IDNumber{1,AGV_ID(1,k3)}.path;
            if size(A_path,2) > 1
                A_path(:,1) = [];
                AGV_IDNumber{1,AGV_ID(1,k3)}.another_path = A_path;
                AGV_IDNumber{1,AGV_ID(1,k3)}.another_path1 = A_path;
            end
        end
    end

    %% Collision Dectection and Avoidance
    Collision_Avoidance_AGV1;
    
    AGV_ID_tam1 = AGV_ID2;
    while size(AGV_ID3,2) ~= 0 
        AGV_ID2 = AGV_ID3;
        Collision_Avoidance_AGV1;
    end
    AGV_ID2 = AGV_ID_tam1;
    
    %Tra headon lai tap rong
    for iii = 1:AGV_number
        AGV_IDNumber{1,iii}.bo_headon = [];
    end
    
    %% Cap nhat duong vao bang ket qua
        %lay duong
    for k3 = 1:AGV_number
        if size(AGV_IDNumber{1,k3}.path,2) ~= 0
            text_path = num2str(AGV_IDNumber{1,k3}.path(1,1));
            for k4 = 2:size(AGV_IDNumber{1,k3}.path,2)
                text_path = strcat(text_path,'-',num2str(AGV_IDNumber{1,k3}.path(1,k4)));
            end
            for k4 = 1:size(kq,1)
                if k3 == kq{k4,4}
                    kq{k4,3} = text_path;
                end
            end
        end
    end    
    set(handles.path_table,'Data',kq);    
    
    %% Chia nho duong di cac AGV vua tim duong
    for k_path1 = 1:size(AGV_ID2,2)
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

    set(handles.agv_position1,'string',num2str(AGV_IDNumber{1,1}.local_node));
    set(handles.agv_position2,'string',num2str(AGV_IDNumber{1,2}.local_node));
    set(handles.agv_position3,'string',num2str(AGV_IDNumber{1,3}.local_node));
    set(handles.agv_position4,'string',num2str(AGV_IDNumber{1,4}.local_node));
    set(handles.agv_position5,'string',num2str(AGV_IDNumber{1,5}.local_node));
    set(handles.agv_position6,'string',num2str(AGV_IDNumber{1,6}.local_node));
    if size(AGV_IDNumber{1,1}.type_mission,1) ~= 0
        if AGV_IDNumber{1,1}.type_mission == 0 && size(AGV_IDNumber{1,1}.mission_phase,2) == 1
            set(handles.agv_status1,'string','empty');
        else
            set(handles.agv_status1,'string','full-loading');
        end
    else
        set(handles.agv_status1,'string','idle');
    end
    if size(AGV_IDNumber{1,2}.type_mission,1) ~= 0
        if AGV_IDNumber{1,2}.type_mission == 0 && size(AGV_IDNumber{1,2}.mission_phase,2) == 1
            set(handles.agv_status2,'string','empty');
        else
            set(handles.agv_status2,'string','full-loading');
        end
    else
        set(handles.agv_status2,'string','idle');
    end
    if size(AGV_IDNumber{1,3}.type_mission,1) ~= 0
        if AGV_IDNumber{1,3}.type_mission == 0 && size(AGV_IDNumber{1,3}.mission_phase,2) == 1
            set(handles.agv_status3,'string','empty');
        else
            set(handles.agv_status3,'string','full-loading');
        end
    else
        set(handles.agv_status3,'string','idle');
    end
    if size(AGV_IDNumber{1,4}.type_mission,1) ~= 0
        if AGV_IDNumber{1,4}.type_mission == 0 && size(AGV_IDNumber{1,4}.mission_phase,2) == 1
            set(handles.agv_status4,'string','empty');
        else
            set(handles.agv_status4,'string','full-loading');
        end
    else
        set(handles.agv_status4,'string','idle');
    end
    if size(AGV_IDNumber{1,5}.type_mission,1) ~= 0
        if AGV_IDNumber{1,5}.type_mission == 0 && size(AGV_IDNumber{1,5}.mission_phase,2) == 1
            set(handles.agv_status5,'string','empty');
        else
            set(handles.agv_status5,'string','full-loading');
        end
    else
        set(handles.agv_status5,'string','idle');
    end
    if size(AGV_IDNumber{1,6}.type_mission,1) ~= 0
        if AGV_IDNumber{1,6}.type_mission == 0 && size(AGV_IDNumber{1,6}.mission_phase,2) == 1
            set(handles.agv_status6,'string','empty');
        else
            set(handles.agv_status6,'string','full-loading');
        end
    else
        set(handles.agv_status6,'string','idle');
    end

    %% Following path
    axes(handles.agv_simulation);
    following_path;

    
    %% Cap nhat trang thai vi tri kho
    axes(handles.axes1);
    [I J] = xlsread('toa_do.xlsx','thong so vtlt','I2:J4001'); %trangthai type
    I = int2str(I);
    I = cellstr(I);
    color_matrix = {[1 0 0]; [0 1 0]; [0 0 1]; [0 1 1];
                [1 0 1]; [1 1 0]; [0 0.4470 0.7410]; [0.8500 0.3250 0.0980]; [0.9290 0.6940 0.1250];
                [0.4940 0.1840 0.5560]; [0.4660 0.6740 0.1880]; [0.3010 0.7450 0.9330]; [0.6350 0.078 0.184]};
    
    AGV_ID1 = AGV_ID;
    for k5 = 1:size(AGV_ID,2)
        if (size(AGV_IDNumber{1,AGV_ID(1,k5)}.path1,2) == 0) && (AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,1) ~= 0) && size(AGV_IDNumber{1,AGV_ID(1,k5)}.mission_phase,2) == 0
            loai1 = type_good_list(:,1);
            loai1(1,:) = [];
            loai1 = cell2mat(loai1);
            [r c] = find(loai1 == type);
                        
            demlanve = demlanve + 1;
            fprintf('Lan %d; xe: %d; vi tri luu tru: %d; toa do: %f %f %f %f\n',demlanve, AGV_IDNumber{1,AGV_ID(1,k5)}.IDNumber, AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),M(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),N(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),P(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),O(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1));
            
            patch([M(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),N(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),N(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),M(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1)],[O(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),O(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),P(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),P(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1)],[0 0 0 0],'FaceColor','white');
            %text(M(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1)+0.1,(O(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1)+P(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1))/2,J{AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1},'FontSize',4);
            AGV_IDNumber{1,AGV_ID(1,k5)}.mission = [0 0];
            AGV_IDNumber{1,AGV_ID(1,k5)}.path = [];
            for k6 = 1:size(kq,1)
                if k6 <= size(kq,1)
                    if AGV_ID(1,k5) == kq{k6,4}
                        kq(k6,:)=[];
                        set(handles.path_table,'Data',kq);
                    end
                end
            end
            [r c] = find(AGV_ID1 == AGV_ID(1,k5));
            AGV_ID1(:,c) = [];
        end
        if (size(AGV_IDNumber{1,AGV_ID(1,k5)}.path1,2) == 0) && size(AGV_IDNumber{1,AGV_ID(1,k5)}.mission_phase,2) ~= 0 %&& (AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,1) ~= 0)
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
end

axes(handles.agv_simulation);
drawnow;
pause(0.01);
if size(location_list,2) ~= 0
    delete(head1);
end

%% Di chuyen cac xe ve vi tri do
AGV_saivitri = 0;
%     location_list = [2257,2258,2259,2260,2261,2262];
AGV_saivitri_list = [1 2 3 4 5 6];
%     location_list = [2257,2258,2259,2260,2261,2262];
% for i_vitri = 1:AGV_number
%     AGV_IDNumber{1,i_vitri}.IDNumber
%     AGV_IDNumber{1,i_vitri}.local_node
% end
location_list = [2246,2247,2248,2249,2250,2251];
for i_vitri = 1:AGV_number
    check_local = find(location_list == AGV_IDNumber{1,i_vitri}.local_node);
    if size(check_local,2) ~= 0
        [r c] = find(location_list == AGV_IDNumber{1,i_vitri}.local_node);
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
        routing_AGV_collision_headon;
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path = path{1,1};
        kq{size(kq,1)+1,1} = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.local_node;
        kq{size(kq,1),2} = end_p;
        kq{size(kq,1),4} = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.IDNumber;
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
        
        
        % chia nho duong di
        %gan vao path moi
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1 = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(1,:);
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,:) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(5,:);
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(6,:) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(6,:);
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(7,:) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(7,:);
        %lay toa do x y z
        for k_path2 = 1:size(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1,2)
            AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(2,k_path2) = x(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path2),1);
            AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(3,k_path2) = y(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path2),1);
            AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(4,k_path2) = z(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path2),1);
        end
        %chia nho quang duong thanh delta doan
        path_tam = [];
        for k_path3 = 2:size(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1,2)
            deta = floor((AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(7,k_path3) - AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(6,k_path3))*24*3600/0.3);
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
if size(AGV_saivitri_list,2) ~= 0
    for i_vitri = 1:size(AGV_saivitri_list,2)
        if size(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path,2) ~= 0
            text_path = num2str(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(1,1));
            for k4 = 2:size(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path,2)
                text_path = strcat(text_path,'-',num2str(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(1,k4)));
            end
            for k4 = 1:size(kq,1)
                if AGV_saivitri_list(1,i_vitri) == kq{k4,4}
                    kq{k4,3} = text_path;
                end
            end
        end
    end
end
set(handles.path_table,'Data',kq);

axes(handles.agv_simulation);
luot_cuoi = 1;
following_path;

kq = {};
set(handles.path_table,'Data',kq);

save('AGV_IDNumber_matrix.mat','AGV_IDNumber');

set(handles.agv_position1,'string',num2str(AGV_IDNumber{1,1}.local_node));
set(handles.agv_position2,'string',num2str(AGV_IDNumber{1,2}.local_node));
set(handles.agv_position3,'string',num2str(AGV_IDNumber{1,3}.local_node));
set(handles.agv_position4,'string',num2str(AGV_IDNumber{1,4}.local_node));
set(handles.agv_position5,'string',num2str(AGV_IDNumber{1,5}.local_node));
set(handles.agv_position6,'string',num2str(AGV_IDNumber{1,6}.local_node));
set(handles.agv_status1,'string','idle');
set(handles.agv_status2,'string','idle');
set(handles.agv_status3,'string','idle');
set(handles.agv_status4,'string','idle');
set(handles.agv_status5,'string','idle');
set(handles.agv_status6,'string','idle');

%Cai dat lai gia tri ban dau cho xuat
set(handles.path_table,'Data',kq);
set(handles.soluong,'string','');
set(handles.mahang,'value',1);
% tien do thuc hien don hang
set(handles.tiendo,'visible','off');
set(handles.tiendo1,'visible','off');
set(handles.start_time,'visible','off');
set(handles.start_time1,'visible','off');
vtxh = {};
% end_time = datetime;
%% Cap nhat o cuoi
if co_chay == 1
    history_table1{1,5} = (end_time - datenum(start_time))*24*3600; %tong khoang cach di chuyen thuc hien don hang
    history_table1{1,6} = t_dukien;
    history_table = [history_table1 ; history_table];
    xlswrite('toa_do.xlsx',history_table,'system_history','A2');
    xlswrite('toa_do.xlsx',vi_tri_history,'vi_tri_history','A1');
    history; %cho cung dang hien thi
    set(handles.his_table,'Data',history_table(:,1:5));
end



function soluong_Callback(hObject, eventdata, handles)
% hObject    handle to soluong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of soluong as text
%        str2double(get(hObject,'String')) returns contents of soluong as a double


% --- Executes during object creation, after setting all properties.
function soluong_CreateFcn(hObject, eventdata, handles)
% hObject    handle to soluong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mahang.
function mahang_Callback(hObject, eventdata, handles)
% hObject    handle to mahang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mahang contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mahang


% --- Executes during object creation, after setting all properties.
function mahang_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mahang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in nhap.
function nhap_Callback(hObject, eventdata, handles)
% hObject    handle to nhap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global n type history_table start_p end_p kq dem1 dem2 dem3 dem4 dem5 dem6 tonghang vitritrong time3;
global vtlt A B C D E F G H I J K M N O P stt node time tt T5 T;
global adj floyd x y z type_good_list tonkho AGV_ID AGV_ID2 AGV_IDNumber AGV_number type_mission IDNumber path;
global head head1 %bien ve
global floyd location_list
global floyd_t AGV_ID2 time_in time_out adj_t adj
global head head1 crossing headon end_p start_p luot_chay check_headon check_path1 time_tam time_0 check_path6 check_waiting_time
global A_path AGV_ID3 luot_cuoi random_number
global adj floyd x y z type_good_list tonkho loai AGV_number AGV_IDNumber;
global floyd_t adj_t AGV_ID2 time_in time_out 
global head head1 crossing headon end_p start_p luot_chay check_headon check_headon1 check_path1 time_tam
global luot_cuoi check_AGV_IDNumber5 AGV_saivitri_list1 time_0 check_path6 check_waiting_time
global A_path AGV_ID3 AAA AGV_dangxet random_number cua_nhan type_good_list AGV_ID4 check_AGV_IDNumber8 AGV_ID_tam path_them
global end_time t_dukien check_path4_2 vi_tri_history

clc
load time_2;
kq = {};
time3 = {};
AGV_ID = [];
veduong = [];
AGV_ID3 = [];
AGV_ID4 = [];
time_tam = [];
headon = 0;
crossing = 0;
luot_cuoi = 0;
demlanve = 0;
random_number = 0;
time3 = {};


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


location_list = [2246,2247,2248,2249,2250,2251];
cua_nhan = [2240 2241 2242 2243 2244 2245];

%% lay gia tri don hang
n = get(handles.soluong,'string');
n = str2num(n);
type = get(handles.mahang,'value');

axes(handles.axes1);

%tim vi tri luu tru
COL;
co_chay = 0;
if size(vtlt,1) ~= 0
    co_chay = 1;
    history_table1{1,1} = strcat(32,32,32,32,32,'In');
    history_table1{1,2} = strcat(32,32,32,32,char(datetime));
    history_table1{1,3} = strcat(32,32,32,type);
    if str2num(vitritrong) >= n 
        history_table1{1,4} = strcat(32,32,num2str(n));
        sltiendo = n;
        sltiendo1 = n;
        set(handles.tiendo,'string',strcat(num2str(sltiendo),'/',num2str(n)));
        set(handles.tiendo,'visible','on');
        set(handles.tiendo1,'visible','on');
        set(handles.start_time1,'string',string(datetime));
        set(handles.start_time,'visible','on');
        set(handles.start_time1,'visible','on');
    end
    if str2num(vitritrong) < n 
        history_table1{1,4} = strcat(32,32,num2str(vitritrong));
        sltiendo = vitritrong;
        sltiendo1 = vitritrong;
        set(handles.tiendo,'string',strcat(num2str(sltiendo),'/',num2str(vitritrong)));
        set(handles.tiendo,'visible','on');
        set(handles.tiendo1,'visible','on');
        set(handles.start_time1,'string',string(datetime));
        set(handles.start_time,'visible','on');
        set(handles.start_time1,'visible','on');
    end
    history_table1{1,5} = 0; %tong thoi gian di chuyen thuc hien don hang
    history_table1{1,6} = 0; %thoi gian du kien
    history_table1{1,7} = strcat(num2str(vtlt{1,2}),';'); %tong hop vi tri luu tru
    if size(vi_tri_history,1) ~= 0
        vi_tri_history_tam = vi_tri_history;
        vi_tri_history = vi_tri_history(1,:);
        for i_history = 1:size(vi_tri_history,2)
            vi_tri_history{1,i_history} = [];
        end
        vi_tri_history = [vi_tri_history;vi_tri_history_tam];
    end
    vi_tri_history{1,1} = num2str(vtlt{1,2});
    for i = 2:size(vtlt,1)
        history_table1{1,7} = strcat(history_table1{1,7},32,num2str(vtlt{i,2}),';');
        vi_tri_history{1,i} = num2str(vtlt{i,2});
    end
    %% Cap nhat ban history o cuoi
%     history_table1{1,5} = 0; %tong khoang cach di chuyen thuc hien don hang
%     history_table = [history_table1 ; history_table];
%     xlswrite('toa_do.xlsx',history_table,'system_history','A2');
%     history; %cho cung dang hien thi
%     set(handles.his_table,'Data',history_table(:,1:6));
    %%
    %dem hang ton kho
    hang_ton_kho
    set(handles.tonkho,'Data',tonkho);
    set(handles.soloai,'string',num2str(size(txt1,1)-1));
    set(handles.tonghang,'string',tonghang);
    set(handles.vitritrong,'string',vitritrong);
end

%% Qua trinh thuc hien don hang
start_time = datetime;
AGV_trong = 1;
phase_mission = 1;
%lay moc thoi gian cho toan bo qua trinh
time_0 = datenum(datetime);
time_tam = 0;
luot_chay = 0;

while size(vtlt,1) ~= 0 || AGV_trong ~= 0 || phase_mission ~= 0
% for checkkq = 1:2
luot_chay = luot_chay + 1;
fprintf('*************** Luot chay theo vong: %d\n',luot_chay);
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
            set(handles.tiendo,'string',strcat(num2str(sltiendo),'/',num2str(sltiendo1)));
%             kq{size(kq,1)+1,1} = AGV_IDNumber{1,AGV_ID2(1,size(AGV_ID2,2))}.local_node;
%             kq{size(kq,1),2} = str2num(vtlt{random_number,1});
%             kq{size(kq,1),4} = AGV_ID2(1,size(AGV_ID2,2));
            vtlt(random_number,:) = [];

%             %thuc hien lan luot theo list
%             end_p = str2num(vtlt{1,1});
%             type_mission = vtlt{1,3};
%             dispatching_AGV;
%             sltiendo = sltiendo - 1;
%             set(handles.tiendo,'string',strcat(num2str(sltiendo),'/',num2str(sltiendo1)));
% %             kq{size(kq,1)+1,1} = AGV_IDNumber{1,AGV_ID2(1,size(AGV_ID2,2))}.local_node;
% %             kq{size(kq,1),2} = str2num(vtlt{1,1});
% %             kq{size(kq,1),4} = AGV_ID2(1,size(AGV_ID2,2));
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
            kq{size(kq,1)+1,1} = start_p;
            kq{size(kq,1),2} = end_p;
            kq{size(kq,1),4} = AGV_IDNumber{1,AGV_ID(1,k3)}.IDNumber;
            
            routing_AGV_collision_headon;
            AGV_IDNumber{1,AGV_ID(1,k3)}.path = A_path{1,1};
            AGV_IDNumber{1,AGV_ID(1,k3)}.shortest_path = AGV_IDNumber{1,AGV_ID(1,k3)}.path;
            if size(A_path,2) > 1
                A_path(:,1) = [];
                AGV_IDNumber{1,AGV_ID(1,k3)}.another_path = A_path;
                AGV_IDNumber{1,AGV_ID(1,k3)}.another_path1 = A_path;
            end
        end
    end
 
    
    %% Collision Dectection and Avoidance
    Collision_Avoidance_AGV1;
    
    AGV_ID_tam1 = AGV_ID2;
    while size(AGV_ID3,2) ~= 0 
        AGV_ID2 = AGV_ID3;
        Collision_Avoidance_AGV1;
    end
    AGV_ID2 = AGV_ID_tam1;
    
    %Tra headon lai tap rong
    for iii = 1:AGV_number
        AGV_IDNumber{1,iii}.bo_headon = [];
    end
    
    %% Cap nhat duong vao bang ket qua
        %lay duong
    for k3 = 1:AGV_number
        if size(AGV_IDNumber{1,k3}.path,2) ~= 0
            text_path = num2str(AGV_IDNumber{1,k3}.path(1,1));
            for k4 = 2:size(AGV_IDNumber{1,k3}.path,2)
                text_path = strcat(text_path,'-',num2str(AGV_IDNumber{1,k3}.path(1,k4)));
            end
            for k4 = 1:size(kq,1)
                if k3 == kq{k4,4}
                    kq{k4,3} = text_path;
                end
            end
        end
    end
    set(handles.path_table,'Data',kq);    
    
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
    

    set(handles.agv_position1,'string',num2str(AGV_IDNumber{1,1}.local_node));
    set(handles.agv_position2,'string',num2str(AGV_IDNumber{1,2}.local_node));
    set(handles.agv_position3,'string',num2str(AGV_IDNumber{1,3}.local_node));
    set(handles.agv_position4,'string',num2str(AGV_IDNumber{1,4}.local_node));
    set(handles.agv_position5,'string',num2str(AGV_IDNumber{1,5}.local_node));
    set(handles.agv_position6,'string',num2str(AGV_IDNumber{1,6}.local_node));
    if size(AGV_IDNumber{1,1}.type_mission,1) ~= 0
        if AGV_IDNumber{1,1}.type_mission == 1 && size(AGV_IDNumber{1,1}.mission_phase,2) == 1
            set(handles.agv_status1,'string','empty');
        else
            set(handles.agv_status1,'string','full-loading');
        end
    else
        set(handles.agv_status1,'string','idle');
    end
    if size(AGV_IDNumber{1,2}.type_mission,1) ~= 0
        if AGV_IDNumber{1,2}.type_mission == 1 && size(AGV_IDNumber{1,2}.mission_phase,2) == 1
            set(handles.agv_status2,'string','empty');
        else
            set(handles.agv_status2,'string','full-loading');
        end
    else
        set(handles.agv_status2,'string','idle');
    end
    if size(AGV_IDNumber{1,3}.type_mission,1) ~= 0
        if AGV_IDNumber{1,3}.type_mission == 1 && size(AGV_IDNumber{1,3}.mission_phase,2) == 1
            set(handles.agv_status3,'string','empty');
        else
            set(handles.agv_status3,'string','full-loading');
        end
    else
        set(handles.agv_status3,'string','idle');
    end
    if size(AGV_IDNumber{1,4}.type_mission,1) ~= 0
        if AGV_IDNumber{1,4}.type_mission == 1 && size(AGV_IDNumber{1,4}.mission_phase,2) == 1
            set(handles.agv_status4,'string','empty');
        else
            set(handles.agv_status4,'string','full-loading');
        end
    else
        set(handles.agv_status4,'string','idle');
    end
    if size(AGV_IDNumber{1,5}.type_mission,1) ~= 0
        if AGV_IDNumber{1,5}.type_mission == 1 && size(AGV_IDNumber{1,5}.mission_phase,2) == 1
            set(handles.agv_status5,'string','empty');
        else
            set(handles.agv_status5,'string','full-loading');
        end
    else
        set(handles.agv_status5,'string','idle');
    end
    if size(AGV_IDNumber{1,6}.type_mission,1) ~= 0
        if AGV_IDNumber{1,6}.type_mission == 1 && size(AGV_IDNumber{1,6}.mission_phase,2) == 1
            set(handles.agv_status6,'string','empty');
        else
            set(handles.agv_status6,'string','full-loading');
        end
    else
        set(handles.agv_status6,'string','idle');
    end
    
    
    %% Following path
    axes(handles.agv_simulation);
    following_path;
    
    %% Cap nhat trang thai vi tri kho
    axes(handles.axes1);
    [I J] = xlsread('toa_do.xlsx','thong so vtlt','I2:J4001'); %trangthai type
    I = int2str(I);
    I = cellstr(I);
    color_matrix = {[1 0 0]; [0 1 0]; [0 0 1]; [0 1 1];
                [1 0 1]; [1 1 0]; [0 0.4470 0.7410]; [0.8500 0.3250 0.0980]; [0.9290 0.6940 0.1250];
                [0.4940 0.1840 0.5560]; [0.4660 0.6740 0.1880]; [0.3010 0.7450 0.9330]; [0.6350 0.078 0.184]};
    
    AGV_ID1 = AGV_ID;
    for k5 = 1:size(AGV_ID,2)      
        if (size(AGV_IDNumber{1,AGV_ID(1,k5)}.path1,2) == 0) && (AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,1) ~= 0) && size(AGV_IDNumber{1,AGV_ID(1,k5)}.mission_phase,2) == 0
            loai1 = type_good_list(:,1);
            loai1(1,:) = [];
            loai1 = cell2mat(loai1);
            [r c] = find(loai1 == type);
            
            demlanve = demlanve + 1;
            fprintf('Lan %d; xe: %d; vi tri luu tru: %d; toa do: %f %f %f %f\n',demlanve, AGV_IDNumber{1,AGV_ID(1,k5)}.IDNumber, AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),M(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),N(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),P(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),O(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1));
                        
            patch([M(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),N(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),N(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),M(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1)],[O(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),O(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),P(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1),P(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1)],[0 0 0 0],'FaceColor',color_matrix{r,1});
            text(M(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1)+0.1,(O(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1)+P(AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1))/2,J{AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,2),1},'FontSize',4);
            AGV_IDNumber{1,AGV_ID(1,k5)}.mission = [0 0];
            AGV_IDNumber{1,AGV_ID(1,k5)}.path = [];
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
        if (size(AGV_IDNumber{1,AGV_ID(1,k5)}.path1,2) == 0) && size(AGV_IDNumber{1,AGV_ID(1,k5)}.mission_phase,2) ~= 0 %&& (AGV_IDNumber{1,AGV_ID(1,k5)}.mission(1,1) ~= 0)
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
end

axes(handles.agv_simulation);
drawnow;
pause(0.01);
if size(location_list,2) ~= 0
    delete(head1);
end

%% Di chuyen cac xe ve vi tri do
AGV_saivitri = 0;
%     location_list = [2257,2258,2259,2260,2261,2262];
AGV_saivitri_list = [1 2 3 4 5 6];
%     location_list = [2257,2258,2259,2260,2261,2262];
% for i_vitri = 1:AGV_number
%     AGV_IDNumber{1,i_vitri}.IDNumber
%     AGV_IDNumber{1,i_vitri}.local_node
% end
location_list = [2246,2247,2248,2249,2250,2251];
for i_vitri = 1:AGV_number
    check_local = find(location_list == AGV_IDNumber{1,i_vitri}.local_node);
    if size(check_local,2) ~= 0
        [r c] = find(location_list == AGV_IDNumber{1,i_vitri}.local_node);
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
        kq{size(kq,1)+1,1} = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.local_node;
        kq{size(kq,1),2} = end_p;
        kq{size(kq,1),4} = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.IDNumber;
        location_list(:,1) = [];
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
        
        % chia nho duong di
        %gan vao path moi
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1 = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(1,:);
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,:) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(5,:);
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(6,:) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(6,:);
        AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(7,:) = AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(7,:);
        %lay toa do x y z
        for k_path2 = 1:size(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1,2)
            AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(2,k_path2) = x(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path2),1);
            AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(3,k_path2) = y(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path2),1);
            AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(4,k_path2) = z(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1(5,k_path2),1);
        end
        %chia nho quang duong thanh delta doan
        path_tam = [];
        for k_path3 = 2:size(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path1,2)
            deta = floor((AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(7,k_path3) - AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(6,k_path3))*24*3600/0.3);
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
if size(AGV_saivitri_list,2) ~= 0
    for i_vitri = 1:size(AGV_saivitri_list,2)
        if size(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path,2) ~= 0
            text_path = num2str(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(1,1));
            for k4 = 2:size(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path,2)
                text_path = strcat(text_path,'-',num2str(AGV_IDNumber{1,AGV_saivitri_list(1,i_vitri)}.path(1,k4)));
            end
            for k4 = 1:size(kq,1)
                if AGV_saivitri_list(1,i_vitri) == kq{k4,4}
                    kq{k4,3} = text_path;
                end
            end
        end
    end
end
set(handles.path_table,'Data',kq);

axes(handles.agv_simulation);
luot_cuoi = 1;
following_path;

kq ={};
set(handles.path_table,'Data',kq);
save('AGV_IDNumber_matrix.mat','AGV_IDNumber');

set(handles.agv_position1,'string',num2str(AGV_IDNumber{1,1}.local_node));
set(handles.agv_position2,'string',num2str(AGV_IDNumber{1,2}.local_node));
set(handles.agv_position3,'string',num2str(AGV_IDNumber{1,3}.local_node));
set(handles.agv_position4,'string',num2str(AGV_IDNumber{1,4}.local_node));
set(handles.agv_position5,'string',num2str(AGV_IDNumber{1,5}.local_node));
set(handles.agv_position6,'string',num2str(AGV_IDNumber{1,6}.local_node));
set(handles.agv_status1,'string','idle');
set(handles.agv_status2,'string','idle');
set(handles.agv_status3,'string','idle');
set(handles.agv_status4,'string','idle');
set(handles.agv_status5,'string','idle');
set(handles.agv_status6,'string','idle');
  

%cai dat lai gia tri ban dau cho Nhap
set(handles.soluong,'string','');
set(handles.mahang,'value',1);
% tien do thuc hien don hang
set(handles.tiendo,'visible','off');
set(handles.tiendo1,'visible','off');
set(handles.start_time,'visible','off');
set(handles.start_time1,'visible','off');
vtlt = {};
% end_time = datetime;

%% Cap nhat ban history o cuoi
if co_chay == 1
    history_table1{1,5} = strcat(32,32,num2str(round((end_time - datenum(start_time))*24*3600,2))); %tong khoang cach di chuyen thuc hien don hang
    history_table1{1,6} = t_dukien;
    history_table = [history_table1 ; history_table];
    xlswrite('toa_do.xlsx',history_table,'system_history','A2');
    xlswrite('toa_do.xlsx',vi_tri_history,'vi_tri_history','A1');
    history; %cho cung dang hien thi
    set(handles.his_table,'Data',history_table(:,1:5));
end



% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate axes3


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
luachon = questdlg('What do you want to exist?','Exist','Yes','No','No');
switch luachon
    case 'Yes'
        close;
    case 'No'
end


% --- Executes on button press in AGV_IF.
function AGV_IF_Callback(hObject, eventdata, handles)
% hObject    handle to AGV_IF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global AGV_IDNumber

AGV_if;



% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in tracuu.
function tracuu_Callback(hObject, eventdata, handles)
% hObject    handle to tracuu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global n type history_table start_p end_p kq dem1 dem2 dem3 dem4 dem5 dem6 tonghang vitritrong time3;
global vtlt A B C D E F G H I J K M N O P stt node time tt T5 T;
global adj floyd x y z type_list_good;
clc;
Tra_cuu;


% --- Executes on button press in them_xoa.
function them_xoa_Callback(hObject, eventdata, handles)
% hObject    handle to them_xoa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global n type history_table start_p end_p kq dem1 dem2 dem3 dem4 dem5 dem6 tonghang vitritrong time3;
global vtlt A B C D E F G H I J K M N O P stt node time tt T5 T;
global adj floyd x y z type_good_list;
clc;
luachon = questdlg('Ban muon:','Them, Xoa loai hang','Them','Xoa','Them');
switch luachon
    case 'Them'
        check = 0;
        type = inputdlg('Nhap loai hang');
        for i = 1:size(type_good_list,1)
            if type_good_list{i,1} == type{1,1}
                check = check + 1;
            end
        end
        if check == 0
            type_good_list = [type_good_list;type];
            mess = msgbox('Da them');
        else
            mess = msgbox('Da ton tai loai hang nay');
        end
        for iii = 1:100
            III{iii,1} = '';
        end
        xlswrite('toa_do.xlsx',III,'type_good_list','A1')
        xlswrite('toa_do.xlsx',type_good_list,'type_good_list','A1')
        set(handles.mahang,'string',type_good_list);
        set(handles.maxuat,'string',type_good_list);
    case 'Xoa'
        check = 0;
        type = inputdlg('Nhap loai hang');
        %check xem co loai hang trong kho khong?
        for i = 1:size(type_good_list,1)
            if type_good_list{i,1} == type{1,1}
                check = check + 1;
            end
        end
        if check == 0
            msgbox('Khong ton tai loai hang nay trong kho');
        else
            %kiem tra xem loai hang nay con hang khong?
            check1 = 0;
            for ii = 1:size(J,1)
                if J{ii,1} == type{1,1}
                    check1 = check1 + 1;
                    if check1 ~= 0
                        break
                    end
                end
            end
            if check1 ~= 0 
                msgbox('Con hang trong kho. Khong duoc xoa!');
            else
                for i = 1:size(type_good_list,1)
                    if i <= size(type_good_list,1)
                        if type_good_list{i,1} == type{1,1}
                            type_good_list(i,:) = [];
                        end
                    end
                end
                mess = msgbox('Da xoa');
            end
        end
        if check ~= 0
            for iii = 1:100
                III{iii,1} = '';
            end
            xlswrite('toa_do.xlsx',III,'type_good_list','A1')
            xlswrite('toa_do.xlsx',type_good_list,'type_good_list','A1')
            set(handles.mahang,'string',type_good_list);
            set(handles.maxuat,'string',type_good_list);
        end
end
hang_ton_kho
set(handles.tonkho,'Data',tonkho);
set(handles.soloai,'string',num2str(size(txt1,1)-1));
set(handles.tonghang,'string',tonghang);
set(handles.vitritrong,'string',vitritrong);
