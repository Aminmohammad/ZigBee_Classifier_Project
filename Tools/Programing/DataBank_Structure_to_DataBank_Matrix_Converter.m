function matrix_of_FingerPrintf_DataBank_for_all_Devices = DataBank_Structure_to_DataBank_Matrix_Converter ( vertical_Structure_of_FingerPrintf_DataBank_for_all_Devices ) 

    FingerPrintf_DataBank_for_all_Devices =[];
    class_Label_for_all_Devices = [];
    for device_Index = 1 : size ( vertical_Structure_of_FingerPrintf_DataBank_for_all_Devices, 1 )
        temp = [ vertical_Structure_of_FingerPrintf_DataBank_for_all_Devices( device_Index, 1 ).fingerPrint_for_a_Single_Device ];
        FingerPrintf_DataBank_for_all_Devices = [ FingerPrintf_DataBank_for_all_Devices temp ];
        class_Label_for_all_Devices           = [ class_Label_for_all_Devices ones( 1, size ( temp, 2 ))*device_Index ];
        
    end
    matrix_of_FingerPrintf_DataBank_for_all_Devices = [ FingerPrintf_DataBank_for_all_Devices; class_Label_for_all_Devices ];
    
end