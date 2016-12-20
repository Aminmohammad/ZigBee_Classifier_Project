function vertical_Structure_of_Selected_Instantaneous_Elements_for_a_Single_Burst = Instantaneous_Elements_Extractor_for_a_Single_Burst ( vertical_Cell_of_Instantaneous_Elements_Names,             ...
                                                                                                                                          vertical_Structure_of_single_Burst)                        ... used in: 'selected_Characteristic_Function'                                                                                                                                                              
                                                                                                                                                             
% clc
% addpath('E:\Documnet_References\36_1_Ph.D.Project\Project_References\PHD_Project\ZigBee_Classifier_Project\Tools\Instantaneous_Elements')
% addpath('E:\Documnet_References\36_1_Ph.D.Project\Project_References\PHD_Project\ZigBee_Classifier_Project\RF_Fingerprint_Generator\5_Instantaneous_Element_Extractor')
% addpath('E:\Documnet_References\36_1_Ph.D.Project\Project_References\PHD_Project\ZigBee_Classifier_Project\Tools\Programing')
% vertical_Cell_of_Instantaneous_Elements_Names = {'Amplitude_Element', 'Phase_Element'};
% 
% for index = 1 : 10
%     vertical_Structure_of_single_Burst(index, 1).subRegion = rand ( 1, 100 );
% end

    %% Section 0: Preliminaries
        % Level 1: Management of Input
            vertical_Cell_of_Instantaneous_Elements_Names = Converter_to_Horizontal_or_Vertical_Vector ( vertical_Cell_of_Instantaneous_Elements_Names, 'Vertical', 'Instantaneous Elements Extractor for a Single Burst' ); 
            vertical_Structure_of_single_Burst            = Converter_to_Horizontal_or_Vertical_Vector ( vertical_Structure_of_single_Burst,                   'Vertical', 'Instantaneous Elements Extractor for a Single Burst' ); 

    %% Section 1: Calling Selected Characteristics
        for subRegion_Index = 1 : size ( vertical_Structure_of_single_Burst, 1 )            
            current_SubRegion = [vertical_Structure_of_single_Burst( subRegion_Index, 1 ).a_Single_subRegion];
            
            calculated_Instantaneous_Elements_for_Current_subRegion = Instantaneous_Element_Extractor_for_a_Single_subRegion ( current_SubRegion, vertical_Cell_of_Instantaneous_Elements_Names );

%             vertical_Structure_of_Selected_Instantaneous_Elements_for_a_Single_Burst ( subRegion_Index, 1 ).device_Index               = device_Index;
%             vertical_Structure_of_Selected_Instantaneous_Elements_for_a_Single_Burst ( subRegion_Index, 1 ).fingerPrint_Index          = fingerPrint_Index;
%             vertical_Structure_of_Selected_Instantaneous_Elements_for_a_Single_Burst ( subRegion_Index, 1 ).sub_Region_Index           = sub_Region_Index;
%             vertical_Structure_of_Selected_Instantaneous_Elements_for_a_Single_Burst ( subRegion_Index, 1 ).instantaneous_Element_Name = instantaneous_Element_Name;
            vertical_Structure_of_Selected_Instantaneous_Elements_for_a_Single_Burst ( 1, subRegion_Index ).Instantaneous_Elements_of_a_Single_subRegion = calculated_Instantaneous_Elements_for_Current_subRegion;            
            
        end
% vertical_Structure_of_Selected_Instantaneous_Elements_for_a_Single_Burst = calculated_Instantaneous_Elements_for_Current_subRegion;
end