clc
addpath('U:\MAHAB\Ph.D._Files\ZigBee_Classifier_Project\Data_Loader\1_File_Loader')
addpath('U:\MAHAB\Ph.D._Files\ZigBee_Classifier_Project\Data_Loader\2_Burst_Index_Extractor')
common_Address = 'U:\MAHAB\Ph.D._Files\2016-07-11_IQ_20Msps_RZUSBSTICK';
c = 1;
data_location( c, 1) = { [common_Address '\RZ001']};
c = c + 1;
data_location( c, 1) = { [common_Address '\RZ002']};
% c = c + 1;
% data_location( c, 1) = { [common_Address '\RZ003']};
c = c + 1;
data_location( c, 1) = { [common_Address '\RZ004']};
close all
k = 1;
if k == 1
labels = [];
DataBase = [];
zero_Conversion_Threshold = .8;
number_of_subRegions = 32;
for device_Index = 1 : size (data_location, 1)
    
    device_Index
    current_data_location              = char   ( data_location( device_Index, 1) );

    Vertical_Structure_of_all_Bursts = Device_DataSet_Loader ( current_data_location, zero_Conversion_Threshold, number_of_subRegions );


    
%     [dataout,dataout_NC,dataraw,indices] = data_recover(current_data_location);
% 
%     [dataout] = cell_cleaner(dataout);
%     [dataout] = cellarray_filter(dataout);
%     asasdas
%     [dataout_NC] = cell_cleaner(dataout_NC);
%     [dataout_NC] = cellarray_filter(dataout_NC);
% 
%     [dataraw] = cell_cleaner(dataraw);
%     [dataraw] = cellarray_filter(dataraw);
% all_Bursts_for_a_Single_Device = dataraw';

% for burst_Index = 1 : size ( all_Bursts_for_a_Single_Device, 1 )
%     a_sing_Burst = all_Bursts_for_a_Single_Device ( burst_Index, 1 )';
%     
%     length_of_a_Single_subRegion = floor(size ( a_sing_Burst, 1 )/64);
%     for index = 1 : 33
%         if ( index <= 32 )
%              indices = ( index - 1 ) * length_of_a_Single_subRegion + 1 : index * length_of_a_Single_subRegion;
%              temp = a_sing_Burst ( indices, 1 );  
%              vertical_Structure_of_a_Single_Burst ( index, 1 ).a_Single_subRegion = abs (temp);
%             
%         else
%             
%             indices = ( index - 1 ) * length_of_a_Single_subRegion + 1 : (2 * (index-1)) * length_of_a_Single_subRegion;
%             temp = a_sing_Burst ( indices, 1 );            
%             vertical_Structure_of_a_Single_Burst ( index, 1 ).a_Single_subRegion =  abs (temp);
%         end
%         
%     end
%     
%     Vertical_Structure_of_all_Bursts ( burst_Index, 1 ).a_Single_Burst = vertical_Structure_of_a_Single_Burst;
%     
% end


    Vertical_Structure_of_all_Devices ( device_Index, 1 ).device_Index    = device_Index;
    Vertical_Structure_of_all_Devices ( device_Index, 1 ).a_Single_Device = Vertical_Structure_of_all_Bursts;

%     [F_a,F_phi,F_f] = gen_stat(dataout,1);

% %     [vect_out_m_a,vect_out_a] = stat_retrieve(F_a)
% %     [vect_out_m_phi,vect_out_phi] = stat_retrieve(F_phi)
% %     [vect_out_m_f,vect_out_f] = stat_retrieve(F_f)

%  temp_Matrix = cell2mat ( [ F_a',F_phi',F_f' ] );
%  temp_Matrix = temp_Matrix';
%  DataBase = [ DataBase temp_Matrix ];
%  labels = [ labels index*ones( 1, size(temp_Matrix, 2) )];
%  numbers_of_DataPoints_in_all_Classes (1, index ) = size(temp_Matrix, 2) ;

end

% save ('DataBase.mat','Vertical_Structure_of_all_Devices');
% save ('indices.mat','indices');
end
% svmtrain( DataBase_2(10:11, :), y_2, 'Showplot', 'true' )

[ target_Folder_Address, ~ ]     =      Folder_Address_Extractor ( 'ZigBee_Classifier_Project', 'DataSet_Folder' )
address_of_Saving_DataBase       =      sprintf ( '%s%s', target_Folder_Address{:}, '\DataSet.mat' )
save( address_of_Saving_DataBase, 'Vertical_Structure_of_all_Devices')






