function vertical_Structure_of_all_DataPoints_for_all_Devices = DataSet_Loader ( dataSet_Folder_Address, selected_Prefix_for_name_of_DataSet, name_of_Saving_DataSet_Folder, do_You_Want_to_Save_the_DataSet )
addpath('E:\Documnet_References\36_1_Ph.D.Project\Project_References\PHD_Project\ZigBee_Classifier_Project\Tools\Programing');
selected_Prefix_for_name_of_DataSet = 'RZ';
clc
    dataSet_Folder_Address = 'E:\Documnet_References\36_1_Ph.D.Project\Project_References\PHD_Project\ZigBee_Classifier_Project\Resources\2_Raw_DataSet_Mathieu_and_Guillaume';
    do_You_Want_to_Save_the_DataSet = 1;
    name_of_Saving_DataSet_Folder = '1_DataSet';
    
    %% Section 1: 
        [ names_of_all_Extracted_Folders_and_SubFolders ] = Folders_and_SubFolders_List_Extractor ( dataSet_Folder_Address );
         slash_Indices             = strfind ( dataSet_Folder_Address, '\' );
         dataSet_Folder_Name = dataSet_Folder_Address ( 1, slash_Indices ( 1, end ) + 1 : end );
         Resources_Folder_Address = dataSet_Folder_Address ( 1, 1 : slash_Indices ( 1, end ) - 1 )
         
        vertical_Structure_of_all_DataPoints_for_all_Devices = [];        
        for index = 1: size ( names_of_all_Extracted_Folders_and_SubFolders, 1 )
            current_subFolder_Address = char ( names_of_all_Extracted_Folders_and_SubFolders ( index, 1 ) );
            slash_Indices = strfind ( current_subFolder_Address , '\' );
            name_of_Deepest_Folder = current_subFolder_Address ( 1, slash_Indices ( 1, end ) + 1 : end );
            

            if ( strcmp ( name_of_Deepest_Folder ( 1, 1 : size ( selected_Prefix_for_name_of_DataSet, 2 ) ) , selected_Prefix_for_name_of_DataSet ) == 1 ) 
                vertical_Cell_of_Contents_of_DBFolder_for_Current_Device = dir ( current_subFolder_Address );
                
                for inner_Index = 3 : size ( vertical_Cell_of_Contents_of_DBFolder_for_Current_Device, 1 )
                    name_of_Current_DataPoint = char ( vertical_Cell_of_Contents_of_DBFolder_for_Current_Device ( inner_Index, 1 ).name );
                    address_of_currrent_DataPoint_for_Current_Device = sprintf ( '%s%s%s', current_subFolder_Address, '\', name_of_Current_DataPoint ) ;   
                    
                    address_of_all_DataPoints_for_Current_Device ( inner_Index - 2 , 1 ). name = address_of_currrent_DataPoint_for_Current_Device;
           
                    name_of_Current_DataPoint_Dot_Indices    = strfind ( name_of_Current_DataPoint, '.' );
                    name_of_Current_DataPoint_Slash_Indices = strfind ( name_of_Current_DataPoint, '_' );
                    index_of_all_DataPoints_for_Current_Device ( inner_Index - 2, 1 ) = str2double ( name_of_Current_DataPoint ( 1, name_of_Current_DataPoint_Slash_Indices ( 1, end ) + 1 : name_of_Current_DataPoint_Dot_Indices ( 1, end ) - 1 ) );
                    
                 end

                 [~, indices] = sort ( index_of_all_DataPoints_for_Current_Device, 'Ascend' );
                 address_of_all_DataPoints_for_Current_Device = address_of_all_DataPoints_for_Current_Device ( indices, 1 );
 
                 matrix_of_all_DataPoints_for_Current_Device= [];
                 for inner_Index = 1 : size ( address_of_all_DataPoints_for_Current_Device, 1 )
                     temp_Structure_of_Content_of_Current_DataPoint =  load ( address_of_all_DataPoints_for_Current_Device ( inner_Index , 1 ). name );
                     vertical_Vector_of_Content_of_Current_DataPoint  = temp_Structure_of_Content_of_Current_DataPoint. sparse_matrix;
                     
                     if ( inner_Index > 1 )
                         if ( size( matrix_of_all_DataPoints_for_Current_Device, 1 ) >= size( vertical_Vector_of_Content_of_Current_DataPoint, 1 ) )
                             matrix_of_all_DataPoints_for_Current_Device = [ matrix_of_all_DataPoints_for_Current_Device( 1 : size( vertical_Vector_of_Content_of_Current_DataPoint, 1 ), :  )  vertical_Vector_of_Content_of_Current_DataPoint ];
                         else
                             matrix_of_all_DataPoints_for_Current_Device = [ matrix_of_all_DataPoints_for_Current_Device                                                                                                   vertical_Vector_of_Content_of_Current_DataPoint( 1 : size( matrix_of_all_DataPoints_for_Current_Device, 1 ), 1  )  ];
                             
                         end
                         
                     else
                         matrix_of_all_DataPoints_for_Current_Device ( :, inner_Index ) = vertical_Vector_of_Content_of_Current_DataPoint;
                         
                     end
                                          
                 end
                 
                 vertical_Structure_of_all_DataPoints_for_all_Devices ( size( vertical_Structure_of_all_DataPoints_for_all_Devices, 1) + 1, 1 ).dataPoints_for_each_Device = matrix_of_all_DataPoints_for_Current_Device;
     
            end
            
        end
        
        if ( do_You_Want_to_Save_the_DataSet == 1) 
            save( sprintf ( '%s\\%s\\%s.mat', Resources_Folder_Address, name_of_Saving_DataSet_Folder, dataSet_Folder_Name ), 'vertical_Structure_of_all_DataPoints_for_all_Devices' );
            
        end
end