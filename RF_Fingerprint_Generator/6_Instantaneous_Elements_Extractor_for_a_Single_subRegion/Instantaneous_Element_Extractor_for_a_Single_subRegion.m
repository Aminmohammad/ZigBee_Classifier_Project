function vertical_Structure_of_Selected_Instantaneous_Elements_for_Mentioned_Single_sub_Region = Instantaneous_Element_Extractor_for_a_Single_subRegion (    horizontal_Vector_of_Single_sub_Region,        ...  used in:  'selected_Instantaneous_Element_Function'                                                                                                                                                             ,                                  ...  used in: 'selected_Instantaneous_Element_Function'
                                                                                                                                                             vertical_Cell_of_Instantaneous_Elements_Names  ... used here
                                                                                                                                                         )
% clc
% addpath('E:\Documnet_References\36_1_Ph.D.Project\Project_References\PHD_Project\ZigBee_Classifier_Project\Tools\Instantaneous_Elements')
% addpath('E:\Documnet_References\36_1_Ph.D.Project\Project_References\PHD_Project\ZigBee_Classifier_Project\Tools\Programing')
% vertical_Cell_of_Instantaneous_Elements_Names = {'Amplitude_Element', 'Phase_Element'};
% horizontal_Vector_of_Single_sub_Region = rand ( 1, 100 );
    %% Section 1: Initial Parameter Extraction
        % Level 1: Management of Input
            vertical_Cell_of_Instantaneous_Elements_Names = Converter_to_Horizontal_or_Vertical_Vector( vertical_Cell_of_Instantaneous_Elements_Names, 'Vertical', 'Instantaneous Element' );                
          
    %% Section 2: Calling Selected Instantaneous Elements
        for vertical_Cell_of_Instantaneous_Elements_Names_Index = 1 : size ( vertical_Cell_of_Instantaneous_Elements_Names, 1 )            
            selected_Instantaneous_Element_Function             = str2func ( vertical_Cell_of_Instantaneous_Elements_Names{ vertical_Cell_of_Instantaneous_Elements_Names_Index, 1 } );
            selected_Instantaneous_Element_Value                = selected_Instantaneous_Element_Function( horizontal_Vector_of_Single_sub_Region );  % selected_Instantaneous_Element_Function: like ( Amplitude, Phase, Frequency ) 
            
            vertical_Structure_of_Selected_Instantaneous_Elements_for_Mentioned_Single_sub_Region ( vertical_Cell_of_Instantaneous_Elements_Names_Index, 1 ) . element_Name  = char ( vertical_Cell_of_Instantaneous_Elements_Names ( vertical_Cell_of_Instantaneous_Elements_Names_Index, 1 ) ); %#ok<*AGROW>
            vertical_Structure_of_Selected_Instantaneous_Elements_for_Mentioned_Single_sub_Region ( vertical_Cell_of_Instantaneous_Elements_Names_Index, 1 ) . element_Value = selected_Instantaneous_Element_Value;
            
        end

end