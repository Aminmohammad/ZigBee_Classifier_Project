function vertical_Structure_of_FingerPrintf_DataBank_for_all_Devices = FingerPrint_Production_Manager (   vertical_Cell_of_Instantaneous_Elements_Names,                ...
                                                                                             vertical_Cell_of_Statistics_Names,                            ...
                                                                                             selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst,  ...
                                                                                             Vertical_Structure_of_all_Devices)


% Add_Pather ( 'U:\MAHAB\Ph.D._Files\ZigBee_Classifier_Project' )

% addpath('D:\ZigBee_Classifier_Project\Tools\Instantaneous_Elements')
% addpath('D:\ZigBee_Classifier_Project\RF_Fingerprint_Generator\4_Instantaneous_Elements_Extractor_for_a_Single_Burst')
% addpath('D:\ZigBee_Classifier_Project\RF_Fingerprint_Generator\5_Instantaneous_Elements_Extractor_for_a_Single_subRegion')
% addpath('D:\ZigBee_Classifier_Project\RF_Fingerprint_Generator\3_Static_Extractor_for_a_Single_Burst')
% addpath('D:\ZigBee_Classifier_Project\RF_Fingerprint_Generator\2_Calculation_of_Statistics_for_all_Bursts')
% addpath('D:\ZigBee_Classifier_Project\RF_Fingerprint_Generator\2_FingerPrint_for_a_Single_Device')
% addpath('D:\ZigBee_Classifier_Project\RF_Fingerprint_Generator\1_FingerPrint_for_Multi_Devices')
% addpath('D:\ZigBee_Classifier_Project\Tools\Probability_Statistics')
% addpath('D:\ZigBee_Classifier_Project\Tools\Programing')

vertical_Cell_of_Instantaneous_Elements_Names = {'Amplitude_Element', 'Phase_Element', 'Amplitude_Element'};
vertical_Cell_of_Statistics_Names = {'Skewness', 'Variance', 'Mean'};
selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst = 'Skewness';

% 
% % % % % Generation of By=ursts
% % % %     for device_Index = 1 : 100
% % % %         for burst_Index = 1 : 5
% % % % 
% % % %             for number_of_subRegions = 1 : 33
% % % %                 if ( number_of_subRegions ~= 33)
% % % %                     vertical_Structure_of_a_Single_Burst( number_of_subRegions, 1 ).a_Single_subRegion = rand ( 1, 100 );
% % % %                 else
% % % %                     vertical_Structure_of_a_Single_Burst( number_of_subRegions, 1 ).a_Single_subRegion = rand ( 1, 3200 );
% % % %                 end
% % % %             end
% % % % 
% % % %             Vertical_Structure_of_all_Bursts ( burst_Index, 1 ). a_Single_Burst = vertical_Structure_of_a_Single_Burst;
% % % % 
% % % %         end  
% % % % 
% % % %         Vertical_Structure_of_all_Devices ( device_Index, 1 ).a_Single_Device = Vertical_Structure_of_all_Bursts;
% % % % 
% % % %     end
load ( 'DataSet.mat' )
    %% Section 1: Initial Paramater Extractions
        % Level 1: Management of Input
            Vertical_Structure_of_all_Devices = Converter_to_Horizontal_or_Vertical_Vector ( Vertical_Structure_of_all_Devices, 'Vertical', 'Multi Device Characteristic Extraction' );                       

    %% Section 2: Generation of 'DataBank'
        vertical_Structure_of_FingerPrintf_DataBank_for_all_Devices =  FingerPrint_for_Multi_Devices ( vertical_Cell_of_Instantaneous_Elements_Names,                ...
                                                                                                       vertical_Cell_of_Statistics_Names,                            ...
                                                                                                       selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst,  ...
                                                                                                       Vertical_Structure_of_all_Devices);

    %% Section 3: Saving DataBank
        [ target_Folder_Address, ~ ]     =      Folder_Address_Extractor ( 'ZigBee_Classifier_Project', 'DataBank_FingerPrint_Folder' )
        address_of_Saving_DataBank       =      sprintf ( '%s%s', target_Folder_Address{:}, '\DataBank_FingerPrint.mat' )
        save( address_of_Saving_DataBank, 'vertical_Structure_of_FingerPrintf_DataBank_for_all_Devices')
        
end
    
    
    
    