global AGV AGV_number change_path
AGV_tam = AGV;
delta = 2/24/3600;

for i_d = 1:AGV_number %Xet voi moi AGV
    if change_path == 1
        break;
    end
    for j_d = 1:size(AGV{1,i_d}.path,1)
        if change_path == 1
            break;
        end
        for k_d = 1:AGV_number %Xet voi cac AGV con lai
            if change_path == 1
                break;
            end
            if k_d ~= i_d
                %% Tim vi tri xe i_d co trong cac xe k_d khong?
                Trung = 0;
                TAM = AGV{1,k_d}.path;
                [r_check c_check] = find(TAM(:,1) == AGV{1,i_d}.path(j_d,1));
                if size(r_check,1) >= 1
                    if size(r_check,1) == 1
                        if AGV{1,i_d}.path(j_d,2) == AGV{1,k_d}.path(r_check,2)
                            Trung = 1;
                        end
                    else
                        for i_c = 1:size(r_check,1)
                            if AGV{1,i_d}.path(j_d,2) == AGV{1,k_d}.path(r_check(i_c,1),2)
                                Trung = 1;
                                r_check = r_check(i_c,1);
                                break;
                            end
                        end
                    end
                end
                if Trung == 1 % Neu co xuat hien, thuc hien check collision
                    %% Check head on
                    if j_d < size(AGV{1,i_d}.path,1) && r_check >1 %Diem hien tai khong phai la diem cuoi
                        if AGV{1,i_d}.path(j_d+1,1) == AGV{1,k_d}.path(r_check-1,1) && AGV{1,i_d}.path(j_d+1,2) == AGV{1,k_d}.path(r_check-1,2)
%                             fprintf('NGOAI Co kha nang xay ra headon tai (%d, %d) --> (%d, %d)\n',AGV{1,i_d}.path(j_d,1),AGV{1,i_d}.path(j_d,2),AGV{1,i_d}.path(j_d+1,1),AGV{1,i_d}.path(j_d+1,2));
                            if (AGV{1,i_d}.path(j_d,3) <= (AGV{1,k_d}.path(r_check,3) + 2/24/3600)) && (AGV{1,i_d}.path(j_d,3) >= (AGV{1,k_d}.path(r_check,3) - 2/24/3600))
                                fprintf('Co kha nang xay ra headon tai (%d, %d) --> (%d, %d) giua xe %d va xe %d\n',AGV{1,i_d}.path(j_d,1),AGV{1,i_d}.path(j_d,2),AGV{1,i_d}.path(j_d+1,1),AGV{1,i_d}.path(j_d+1,2),i_d,k_d);
                                vitringoai = 0;
                                chocho = 0;
                                    %% Truong hop 1: Truong hop Headon o ngay nga tu
                                if MAP(AGV{1,i_d}.path(j_d,1),AGV{1,i_d}.path(j_d,2)+1) == 2 && MAP(AGV{1,i_d}.path(j_d,1), AGV{1,i_d}.path(j_d,2)-1) == 2 && MAP(AGV{1,i_d}.path(j_d,1)-1, AGV{1,i_d}.path(j_d,2)) == 2 && MAP(AGV{1,i_d}.path(j_d,1)+1, AGV{1,i_d}.path(j_d,2)) == 2
                                        %xe i_d dung cho
                                    if j_d >= 2
                                        fprintf('    TH1: Cho xe %d cho o (%d, %d)\n', i_d, AGV{1,i_d}.path(j_d - 2,1), AGV{1,i_d}.path(j_d - 2,2));
                                        for i_c2 = (j_d - 1):size(AGV{1,i_d}.path,1)
                                            AGV{1,i_d}.path(i_c2,3) = AGV{1,i_d}.path(i_c2,3) + 3*delta;
                                        end
                                    end
                                        %Tai diem nga tu Headon, xe k_d
                                        %chen them diem cho
                                    if AGV{1,k_d}.path(r_check - 1,1) == AGV{1,k_d}.path(r_check + 1,1)
                                            %Check diem dung cho
                                        [r_check2 c_check2] = find(AGV{1,i_d}.path(j_d:size(AGV{1,i_d}.path,1), 1) == (AGV{1,k_d}.path(r_check,1)+1));
                                        cothuoc = 0;
                                        if size(r_check2,1) ~= 0
                                            for i_c4 = 1:size(r_check2,1)
                                                if AGV{1,i_d}.path(r_check + r_check2(i_c4,1) - 1,2) == AGV{1,k_d}.path(r_check,2)
                                                    cothuoc = 1;
                                                    break;
                                                end
                                            end
                                        end
                                        if cothuoc == 1
                                            AGV{1,k_d}.path = [AGV{1,k_d}.path(1:r_check,:); [AGV{1,k_d}.path(r_check,1)-1 AGV{1,k_d}.path(r_check,2) 0]; AGV{1,k_d}.path(r_check:size(AGV{1,k_d}.path,1),:)];
                                            change_path = 1;
                                        else
                                            AGV{1,k_d}.path = [AGV{1,k_d}.path(1:r_check,:); [AGV{1,k_d}.path(r_check,1)+1 AGV{1,k_d}.path(r_check,2) 0]; AGV{1,k_d}.path(r_check:size(AGV{1,k_d}.path,1),:)];
                                            change_path = 1;
                                        end
                                        AGV{1,k_d}.path(r_check + 1,3) = AGV{1,k_d}.path(r_check,3) + delta;
                                        for i_c3 = (r_check + 2):size(AGV{1,k_d}.path,1)
                                            AGV{1,k_d}.path(i_c3,3) = AGV{1,k_d}.path(i_c3,3) + 5*delta;
                                        end
                                    else
                                        [r_check2 c_check2] = find(AGV{1,i_d}.path(j_d:size(AGV{1,i_d}.path,1), 1) == (AGV{1,k_d}.path(r_check,1)));
                                        cothuoc = 0;
                                        if size(r_check2,1) ~= 0
                                            for i_c4 = 1:size(r_check2,1)
                                                if AGV{1,i_d}.path(j_d + r_check2(i_c4,1) - 1,2) == (AGV{1,k_d}.path(r_check,2)+1)
                                                    cothuoc = 1;
                                                    break;
                                                end
                                            end
                                        end
                                        if cothuoc == 1
                                            AGV{1,k_d}.path = [AGV{1,k_d}.path(1:r_check,:); [AGV{1,k_d}.path(r_check,1) AGV{1,k_d}.path(r_check,2)-1 0]; AGV{1,k_d}.path(r_check:size(AGV{1,k_d}.path,1),:)];
                                            change_path = 1;
                                        else
                                            AGV{1,k_d}.path = [AGV{1,k_d}.path(1:r_check,:); [AGV{1,k_d}.path(r_check,1) AGV{1,k_d}.path(r_check,2)+1 0]; AGV{1,k_d}.path(r_check:size(AGV{1,k_d}.path,1),:)];
                                            change_path = 1;
                                        end
                                        AGV{1,k_d}.path(r_check + 1,3) = AGV{1,k_d}.path(r_check,3) + delta;
                                        for i_c3 = (r_check + 2):size(AGV{1,k_d}.path,1)
                                            AGV{1,k_d}.path(i_c3,3) = AGV{1,k_d}.path(i_c3,3) + 5*delta;
                                        end
                                    end
                                end
                                if change_path == 1
                                    %%% Giu lai cac xe khac truoc thay doi
                                    for i_change = 1:AGV_number
                                        if i_change ~= i_d && i_change ~= k_d %Truong hop 1 ch?nh duong ca 2 xe
                                            AGV{1,i_change} = AGV_tam{1,i_change};
                                        end
                                    end
                                    break;
                                end
                                    
                                for i_c2 = j_d:-1:1 %Tim nhung diem truoc do co diem nao cho duoc khong
                                    %% Tim nga tu de tranh
                                    if (j_d - i_c2) > 2 && i_c2 ~= j_d && MAP(AGV{1,i_d}.path(i_c2,1),AGV{1,i_d}.path(i_c2,2)+1) == 2 && MAP(AGV{1,i_d}.path(i_c2,1), AGV{1,i_d}.path(i_c2,2)-1) == 2 && MAP(AGV{1,i_d}.path(i_c2,1)-1, AGV{1,i_d}.path(i_c2,2)) == 2 && MAP(AGV{1,i_d}.path(i_c2,1)+1, AGV{1,i_d}.path(i_c2,2)) == 2
%                                         fprintf('Nga tu (%d, %d): tren (%d, %d, %d); duoi (%d, %d, %d); phai (%d, %d, %d); trai (%d, %d, %d)\n', AGV{1,i_d}.path(i_c2,1), AGV{1,i_d}.path(i_c2,2), AGV{1,i_d}.path(i_c2,1),AGV{1,i_d}.path(i_c2,2)+1, MAP(AGV{1,i_d}.path(i_c2,1),AGV{1,i_d}.path(i_c2,2)+1), AGV{1,i_d}.path(i_c2,1), AGV{1,i_d}.path(i_c2,2)-1, MAP(AGV{1,i_d}.path(i_c2,1), AGV{1,i_d}.path(i_c2,2)-1), AGV{1,i_d}.path(i_c2,1)-1, AGV{1,i_d}.path(i_c2,2), MAP(AGV{1,i_d}.path(i_c2,1)-1, AGV{1,i_d}.path(i_c2,2)), AGV{1,i_d}.path(i_c2,1)+1, AGV{1,i_d}.path(i_c2,2), MAP(AGV{1,i_d}.path(i_c2,1)+1, AGV{1,i_d}.path(i_c2,2)));
                                        change_path = 1;
                                        chocho = 1;
                                        fprintf('    TH2: Cho xe %d cho o nga tu (%d, %d)\n',i_d, AGV{1,i_d}.path(i_c2,1), AGV{1,i_d}.path(i_c2,2));
                                        if AGV{1,i_d}.path(i_c2 - 1,1) == AGV{1,i_d}.path(i_c2 + 1,1)
                                            %Check diem dung cho
                                            [r_check2 c_check2] = find(AGV{1,k_d}.path(r_check:size(AGV{1,k_d}.path,1), 1) == (AGV{1,i_d}.path(i_c2,1)+1));
                                            cothuoc = 0;
                                            if size(r_check2,1) ~= 0
                                                for i_c4 = 1:size(r_check2,1)
                                                    if AGV{1,k_d}.path(r_check + r_check2(i_c4,1) - 1,2) == AGV{1,i_d}.path(i_c2,2)
                                                        cothuoc = 1;
                                                        break;
                                                    end
                                                end
                                            end
                                            if cothuoc == 1
                                                AGV{1,i_d}.path = [AGV{1,i_d}.path(1:i_c2,:); [AGV{1,i_d}.path(i_c2,1)-1 AGV{1,i_d}.path(i_c2,2) 0]; AGV{1,i_d}.path(i_c2:size(AGV{1,i_d}.path,1),:)];
                                            else
                                                AGV{1,i_d}.path = [AGV{1,i_d}.path(1:i_c2,:); [AGV{1,i_d}.path(i_c2,1)+1 AGV{1,i_d}.path(i_c2,2) 0]; AGV{1,i_d}.path(i_c2:size(AGV{1,i_d}.path,1),:)];
                                            end
                                            AGV{1,i_d}.path(i_c2+1,3) = AGV{1,i_d}.path(i_c2,3) + delta;
                                            for i_c3 = (i_c2 + 2):size(AGV{1,i_d}.path,1)
                                                AGV{1,i_d}.path(i_c3,3) = AGV{1,i_d}.path(i_c3,3) +(j_d-i_c2 + 8)*delta;
                                            end
                                        else
                                            [r_check2 c_check2] = find(AGV{1,k_d}.path(r_check:size(AGV{1,k_d}.path,1), 1) == (AGV{1,i_d}.path(i_c2,1)));
                                            cothuoc = 0;
                                            if size(r_check2,1) ~= 0
                                                for i_c4 = 1:size(r_check2,1)
                                                    if AGV{1,k_d}.path(r_check + r_check2(i_c4,1) - 1,2) == (AGV{1,i_d}.path(i_c2,2)+1)
                                                        cothuoc = 1;
                                                        break;
                                                    end
                                                end
                                            end
                                            if cothuoc == 1
                                                AGV{1,i_d}.path = [AGV{1,i_d}.path(1:i_c2,:); [AGV{1,i_d}.path(i_c2,1) AGV{1,i_d}.path(i_c2,2)-1 0]; AGV{1,i_d}.path(i_c2:size(AGV{1,i_d}.path,1),:)];
                                            else
                                                AGV{1,i_d}.path = [AGV{1,i_d}.path(1:i_c2,:); [AGV{1,i_d}.path(i_c2,1) AGV{1,i_d}.path(i_c2,2)+1 0]; AGV{1,i_d}.path(i_c2:size(AGV{1,i_d}.path,1),:)];
                                            end
                                            AGV{1,i_d}.path(i_c2+1,3) = AGV{1,i_d}.path(i_c2,3) + delta;
                                            for i_c3 = (i_c2 + 2):size(AGV{1,i_d}.path,1)
                                                AGV{1,i_d}.path(i_c3,3) = AGV{1,i_d}.path(i_c3,3) +(j_d-i_c2 + 8)*delta;
                                            end
                                        end
                                    end
                                    %% abc
                                    if change_path == 1
                                        %%% Giu lai cac xe khac truoc thay doi
                                        for i_change = 1:AGV_number
                                            if i_change ~= i_d
                                                AGV{1,i_change} = AGV_tam{1,i_change};
                                            end
                                        end
                                        break;
                                    end
                                    %% Tim vi tri khong nam trong duong
                                    dem = 0;
                                    for i_c3 = 1:size(AGV{1,k_d}.path,1)
                                        if AGV{1,i_d}.path(i_c2,1) == AGV{1,k_d}.path(i_c3,1) && AGV{1,i_d}.path(i_c2,2) == AGV{1,k_d}.path(i_c3,2)
                                            dem = dem + 1;
                                        end
                                    end
                                    if dem == 0
                                        vitringoai = i_c2;
                                        chocho = 1;
                                        fprintf('    TH3: Cho xe %d cho o vi tri (%d, %d)\n',i_d, AGV{1,i_d}.path(i_c2,1),AGV{1,i_d}.path(i_c2,2));
                                        break;
                                    end
                                end
                                change_path = 1;
                                if vitringoai == 2 || vitringoai == 1
                                    for i_c2 = 2:size(AGV{1,i_d}.path,1)
                                        AGV{1,i_d}.path(i_c2,3) = AGV{1,i_d}.path(i_c2,3) + (j_d - vitringoai + 7)*delta;
                                    end
                                end
                                if vitringoai > 2
                                    for i_c2 = (vitringoai + 1):size(AGV{1,i_d}.path,1)
                                        AGV{1,i_d}.path(i_c2,3) = AGV{1,i_d}.path(i_c2,3) + (j_d - vitringoai + 7)*delta;
                                    end
                                end
                                %% Tim lai duong moi do khong co vi tri cho
                                if chocho == 0 
                                    %Nguyen tat tim duong moi
                                    NEW_MAP = MAP;
                                    if i_c2 > 1 && i_c2 < size(AGV{1,i_d}.path,1)
                                        for i_c5 = 2:i_c2
                                            NEW_MAP(AGV{1,i_d}.path(i_c5,1),AGV{1,i_d}.path(i_c5,2)) = -1;
                                        end
                                    else
                                        NEW_MAP(AGV{1,i_d}.path(2,1),AGV{1,i_d}.path(2,2)) = -1;
                                    end
                                    fprintf('    TH4: Chon lai duong di cho xe %d\n',i_d);
                                    AGV{1,i_d}.path = Astar_finding(AGV{1,i_d}.local(1,1),AGV{1,i_d}.local(1,2), AGV{1,i_d}.distination(1,1),AGV{1,i_d}.distination(1,2),NEW_MAP);
                                    chonlaiduong = AGV{1,i_d}.path;
                                    change_path = 1;
                                    
                                end
                            end %End check time Headon
                                    
                        end %End dieu kien co kha nang Headon
                    end %End checking Heado-on
                    
                    if change_path == 1
                        %%% Giu lai cac xe khac truoc thay doi
                        for i_change = 1:AGV_number
                            if i_change ~= i_d
                                AGV{1,i_change} = AGV_tam{1,i_change};
                            end
                        end
                        break;
                    end

                    %% Check cross
                    if (AGV{1,i_d}.path(j_d,3) <= (AGV{1,k_d}.path(r_check,3) + 0.5/24/3600)) && (AGV{1,i_d}.path(j_d,3) >= (AGV{1,k_d}.path(r_check,3) - 0.5/24/3600))
                        fprintf('Xay ra cross giua xe %d va xe %d tai (%d, %d)\n',i_d, k_d, AGV{1,i_d}.path(j_d,1),AGV{1,i_d}.path(j_d,2));
                        if j_d <= 2
                            fprintf('    Cho xe %d cho o (%d, %d)\n', i_d, AGV{1,i_d}.path(1,1), AGV{1,i_d}.path(1,2));
                            for i_c2 = 2:size(AGV{1,i_d}.path,1)
                                AGV{1,i_d}.path(i_c2,3) = AGV{1,i_d}.path(i_c2,3) + 2*delta;
                            end
                        else
                            fprintf('    Cho xe %d cho o (%d, %d)\n', i_d, AGV{1,i_d}.path(j_d - 2,1), AGV{1,i_d}.path(j_d - 2,2));
                            for i_c2 = (j_d - 1):size(AGV{1,i_d}.path,1)
                                AGV{1,i_d}.path(i_c2,3) = AGV{1,i_d}.path(i_c2,3) + 2*delta;
                            end
                        end
                    end
                    
                end
            end
        end %End for k_d
    end %End for j_d
end %End for i_d