function Vertical_Structure_of_all_Bursts = Device_DataSet_Loader ( device_DatSet_Address, zero_Conversion_Threshold, number_of_subRegions )
  
    % Extracting the Address of all Records in the 'DataSet Folder' for a Single Device
        device_DataSet_DataBase = dir ( device_DatSet_Address );
        list_of_Records         = {device_DataSet_DataBase(3:end, :).name};
    
        list_of_Records = list_of_Records(:);
    
    Vertical_Structure_of_all_Bursts =[ ];    
    for records_Index = 1 : size ( list_of_Records, 1 )
        name_of_Current_Record    = char ( list_of_Records ( records_Index, 1 ) );
        address_of_Current_Record = sprintf ( '%s/%s', device_DatSet_Address, name_of_Current_Record );

        % Loading a Single Record
            content_of_Current_Record = load ( address_of_Current_Record );

            content_of_Current_Record = content_of_Current_Record.sparse_matrix;
            content_of_Current_Record = content_of_Current_Record (:)';                                

        % Extracting the 'Bursts' and 'subRegions' of a Single Record
            % indices_of_Bursts = find (content_of_Current_Record > .1 * max ( content_of_Current_Record ) );

            record = abs ( content_of_Current_Record );
            bursts_Indices_Matrix = burst_Index_Extractor ( record, zero_Conversion_Threshold * max ( record ) );
           
            for burst_Index = 1 : size ( bursts_Indices_Matrix, 1 )

                % Single Burst
                    curretn_Burst = content_of_Current_Record( 1, bursts_Indices_Matrix(burst_Index, 1 ) : bursts_Indices_Matrix(burst_Index, 2 ) );
                    curretn_Burst = curretn_Burst(:);

                % subRegionsof 'current_Burst'
                    length_of_a_Single_subRegion = floor(size ( curretn_Burst, 1 )/ number_of_subRegions );

                    vertical_Structure_of_a_Single_Burst = struct ( 'a_Single_subRegion', []); 
                    vertical_Structure_of_a_Single_Burst = repmat ( vertical_Structure_of_a_Single_Burst, number_of_subRegions + 1, 1 );
                    for subRegion_Index = 1 : number_of_subRegions + 1
                        if ( subRegion_Index <= number_of_subRegions )
                             indices = ( subRegion_Index - 1 ) * length_of_a_Single_subRegion + 1 : subRegion_Index * length_of_a_Single_subRegion;
                             temp = curretn_Burst ( indices, 1 );  
                             vertical_Structure_of_a_Single_Burst ( subRegion_Index, 1 ).a_Single_subRegion = temp;

                        else

                             vertical_Structure_of_a_Single_Burst ( subRegion_Index, 1 ).a_Single_subRegion =  curretn_Burst;
                        end

                    end
                 
                % saving the Single Burst                    
                    Vertical_Structure_of_all_Bursts ( size ( Vertical_Structure_of_all_Bursts, 1 ) + 1, 1 ).a_Single_Burst = vertical_Structure_of_a_Single_Burst;
    

            end

       
        
    end
    
    
end