function around_array = number_around(xval,yval,time,number_matrix)
%ham chuc nang tim kiem cac AGV tai 8 o xung quanh
around_array = 0;

for k= 2:-1:-2
    for j= 2:-1:-2
        s_x = xval+k;
        s_y = yval+j;
        if( (s_x >0 && s_x <= size(number_matrix,2)) && (s_y >0 && s_y <= size(number_matrix,1)))%node within array bound
            if size(number_matrix{s_y,s_x},1) > 0
                for i_around = 1:size(number_matrix{s_y,s_x},1)
                    fprintf('Xe xet(%d, %d): %s      Xe tham chieu(%d, %d): %s\n ',xval, yval, datetime(time,'ConvertFrom','datenum'),s_x, s_y, datetime(number_matrix{s_y,s_x}(i_around,2),'ConvertFrom','datenum'));
                    if (time < number_matrix{s_y,s_x}(i_around,2) + 0.5/24/3600) && (time > number_matrix{s_y,s_x}(i_around,2) - 0.5/24/3600)
                        around_array = around_array + 1;
                    end
                end
            end
        end
    end
end
            

% % Neu vi tri hien tai la (0;0)
% if xval > 0 && (yval - 2) > 0 %(0,-2)
%     if size(number_matrix{yval-2,xval},1) > 0
%         for i_around = 1:size(number_matrix{yval-2,xval},1)
%             fprintf('Xe xet: %s\n',datetime(time,'ConvertFrom','datenum'));
%             fprintf('Xe tham chieu: %s\n',datetime(number_matrix{yval-2,xval}(i_around,2),'ConvertFrom','datenum'));
%             if (time < number_matrix{yval-2,xval}(i_around,2) + 0.5/24/3600) && (time > number_matrix{yval-2,xval}(i_around,2) - 0.5/24/3600)
%                 around_array = around_array + 1
%             end
%         end
%     end
% end
% if xval > 0 && (yval - 1) > 0 %(0,-1)
%     if size(number_matrix{yval-1,xval},1) > 0
%         for i_around = 1:size(number_matrix{yval-1,xval},1)
%             if (time < number_matrix{yval-1,xval}(i_around,2) + 0.5/24/3600) && (time > number_matrix{yval-1,xval}(i_around,2) - 0.5/24/3600)
%                 around_array = around_array + 1
%             end
%         end
%     end
% end
% if xval > 0 && (yval + 1) <= size(number_matrix,1) %(0,1)
%     if size(number_matrix{yval+1,xval},1) > 0
%         for i_around = 1:size(number_matrix{yval+1,xval},1)
%             if (time < number_matrix{yval+1,xval}(i_around,2) + 0.5/24/3600) && (time > number_matrix{yval+1,xval}(i_around,2) - 0.5/24/3600)
%                 around_array = around_array + 1
%             end
%         end
%     end
% end
% if xval > 0 && (yval + 2) <= size(number_matrix,1) %(0,2)
%     if size(number_matrix{yval+2,xval},1) > 0
%         for i_around = 1:size(number_matrix{yval+2,xval},1)
%             if (time < number_matrix{yval+2,xval}(i_around,2) + 0.5/24/3600) && (time > number_matrix{yval+2,xval}(i_around,2) - 0.5/24/3600)
%                 around_array = around_array + 1
%             end
%         end
%     end
% end
% if (xval-2) > 0 && yval > 0 %(-2,0)
%     if size(number_matrix{yval,xval-2},1) > 0
%         for i_around = 1:size(number_matrix{yval,xval-2},1)
%             if (time < number_matrix{yval,xval-2}(i_around,2) + 0.5/24/3600) && (time > number_matrix{yval,xval-2}(i_around,2) - 0.5/24/3600)
%                 around_array = around_array + 1
%             end
%         end
%     end
% end
% if (xval-1) > 0 && yval > 0 %(-1,0)
%     if size(number_matrix{yval,xval-1},1) > 0
%         for i_around = 1:size(number_matrix{yval,xval-1},1)
%             if (time < number_matrix{yval,xval-1}(i_around,2) + 0.5/24/3600) && (time > number_matrix{yval,xval-1}(i_around,2) - 0.5/24/3600)
%                 around_array = around_array + 1
%             end
%         end
%     end
% end
% if (xval+1) <= size(number_matrix,2) && yval > 0 %(1,0)
%     if size(number_matrix{yval,xval+1},1) > 0
%         for i_around = 1:size(number_matrix{yval,xval+1},1)
%             if (time < number_matrix{yval,xval+1}(i_around,2) + 0.5/24/3600) && (time > number_matrix{yval,xval+1}(i_around,2) - 0.5/24/3600)
%                 around_array = around_array + 1
%             end
%         end
%     end
% end
% if (xval+2) <= size(number_matrix,2) && yval > 0 %(2,0)
%     if size(number_matrix{yval,xval+2},1) > 0
%         for i_around = 1:size(number_matrix{yval,xval+2},1)
%             if (time < number_matrix{yval,xval+2}(i_around,2) + 0.5/24/3600) && (time > number_matrix{yval,xval+2}(i_around,2) - 0.5/24/3600)
%                 around_array = around_array + 1
%             end
%         end
%     end
% end

fprintf('    Dang xet vi tri (%d, %d) co %d xe xung quanh.\n',xval,yval,around_array);
end