function vertical_Structure_of_Selected_Statistics_for_a_Single_Burst = Static_Extractor_for_a_Single_Burst (    vertical_Structure_of_a_Single_Burst,               ...
                                                                                                                 vertical_Cell_of_Instantaneous_Elements_Names,    ...
                                                                                                                 vertical_Cell_of_Statistics_Names )                                                                                   
                                                                                                                                                                                                                                                               
% clc
% clear all
% warning off MATLAB:namelengthmaxexceeded
% addpath('D:\ZigBee_Classifier_Project\Tools\Instantaneous_Elements')
% addpath('D:\ZigBee_Classifier_Project\RF_Fingerprint_Generator\4_Instantaneous_Elements_Extractor_for_a_Single_Burst')
% addpath('D:\ZigBee_Classifier_Project\RF_Fingerprint_Generator\5_Instantaneous_Elements_Extractor_for_a_Single_subRegion')
% addpath('D:\ZigBee_Classifier_Project\Tools\Probability_Statistics')
% addpath('D:\ZigBee_Classifier_Project\Tools\Programing')
% vertical_Cell_of_Instantaneous_Elements_Names = {'Amplitude_Element', 'Phase_Element', 'Amplitude_Element'};
% vertical_Cell_of_Statistics_Names = {'Skewness', 'Variance', 'Mean'};

% Description:
%                              1 Burst (Structure)
%  ___________________________________            ___________________
%  |  Sigma_A_1     |  Sigma_A_2     |      ...   |  Sigma_A_33      |
%  |  Gamma_A_1     |  Gamma_A_2     |      ...   |  Gamma_A_33      |
%  |  Kurtosis_A_1  |  Kurtosis_A_2  |      ...   |  Kurtosis_A_33   |
%  |                |                |            |
%  |  Sigma_Phi_1   |  Sigma_Phi_2   |      ...   |  Sigma_Phi_33    |
%  |  Gamma_Phi_1   |  Gamma_Phi_2   |      ...   |  Gamma_Phi_33    |
%  |  Kurtosis_Phi_1|  Kurtosis_Phi_2|      ...   |  Kurtosis_Phi_33 |
%  |                |                |            |                  |
%  |  Sigma_F_1     |  Sigma_F_2     |      ...   |  Sigma_F_33      |
%  |  Gamma_F_1     |  Gamma_F_2     |      ...   |  Gamma_F_33      |
%  |  Kurtosis_F_1  |  Kurtosis_F_2  |      ...   |  Kurtosis_F_33   |
%  ___________________________________            ____________________
%     subRegion_1      subRegion_2                    subRegion_33

    %% Section 1: Initial Parameter Extraction
    
        % Level 1: Extraction of 'structure_of_Selected_Instantaneous_Elements_for_a_Single_Burst'
            structure_of_Selected_Instantaneous_Elements_for_a_Single_Burst = Instantaneous_Elements_Extractor_for_a_Single_Burst ( vertical_Cell_of_Instantaneous_Elements_Names,   ... 
                                                                                                                                             vertical_Structure_of_a_Single_Burst );
                                                                                                                                         
        % Level 2: Converting 'structure_of_Selected_Instantaneous_Elements_for_a_Single_Burst' to Vertical Case 
            structure_of_Selected_Instantaneous_Elements_for_a_Single_Burst = Converter_to_Horizontal_or_Vertical_Vector( structure_of_Selected_Instantaneous_Elements_for_a_Single_Burst, 'Vertical', 'vertical_Structure_of_a_Single_Burst' );                
                                                         
        % Level 3: Converting 'vertical_Cell_of_Instantaneous_Elements_Names' to Vertical Case 
            vertical_Cell_of_Instantaneous_Elements_Names = Converter_to_Horizontal_or_Vertical_Vector( vertical_Cell_of_Instantaneous_Elements_Names, 'Vertical', 'vertical_Structure_of_a_Single_Burst' );                
          
        % Level 4: Converting 'vertical_Cell_of_Statistics_Names' to Vertical Case             
            vertical_Cell_of_Statistics_Names             = Converter_to_Horizontal_or_Vertical_Vector( vertical_Cell_of_Statistics_Names,             'Vertical', 'vertical_Structure_of_a_Single_Burst' );                
 
    %% Section 2: Calling Selected 'Instantaneous Elements' for selected 'sub Region'        
        for index = 1 : size ( vertical_Cell_of_Statistics_Names, 1 )
            current_Statistic_Name     = vertical_Cell_of_Statistics_Names { index, 1 };
            current_Statistic_Function = str2func ( current_Statistic_Name );
                        
            for subRegion_Index = 1 : size ( structure_of_Selected_Instantaneous_Elements_for_a_Single_Burst, 1 )
                vertical_Structure_of_Selected_Instantaneous_Elements_for_a_Single_subRegion = structure_of_Selected_Instantaneous_Elements_for_a_Single_Burst ( subRegion_Index, 1 ). Instantaneous_Elements_of_a_Single_subRegion;
                
                number_of_Instantaneous_Elements = size ( vertical_Structure_of_Selected_Instantaneous_Elements_for_a_Single_subRegion, 1 );
                for Instantaneous_Element_Index = 1 : number_of_Instantaneous_Elements
                    
                    current_Instantaneous_Element_Name_for_this_subRegion  = vertical_Structure_of_Selected_Instantaneous_Elements_for_a_Single_subRegion (Instantaneous_Element_Index, 1 ).element_Name;
                    instantaneous_Element_Value_for_Current_subRegion = [vertical_Structure_of_Selected_Instantaneous_Elements_for_a_Single_subRegion(Instantaneous_Element_Index, 1 ).element_Value]; 

                    value_of_Current_Statistic_for_a_Single_Subregion = current_Statistic_Function ( instantaneous_Element_Value_for_Current_subRegion, 0 );
                    the_name_of_Current_Statitic = sprintf ( '%s_of_%s', current_Statistic_Name, current_Instantaneous_Element_Name_for_this_subRegion );

                    temp_Structure = struct ( 'element_Name', the_name_of_Current_Statitic, 'element_Value', value_of_Current_Statistic_for_a_Single_Subregion );
                    vertical_Structure_of_Selected_Instantaneous_Elements_for_a_Single_subRegion = [ vertical_Structure_of_Selected_Instantaneous_Elements_for_a_Single_subRegion; temp_Structure ];
                
                end

                temp_Str_of_Selected_Instantaneous_Elements_for_a_Single_Burst ( subRegion_Index, index ).Instantaneous_Elements_of_a_Single_subRegion = vertical_Structure_of_Selected_Instantaneous_Elements_for_a_Single_subRegion;
                
            end
                        
        end
        
        
    %% Section 3: Concatenating all 'Statistics' related to each 'subRegion' to each Other
        for row_Index = 1 : size ( temp_Str_of_Selected_Instantaneous_Elements_for_a_Single_Burst, 1 )

            for column_Index = 1 : size ( temp_Str_of_Selected_Instantaneous_Elements_for_a_Single_Burst, 2 )
                temp_1 = temp_Str_of_Selected_Instantaneous_Elements_for_a_Single_Burst( row_Index, column_Index ).Instantaneous_Elements_of_a_Single_subRegion;

                for index = 1 : size ( temp_1, 1 )
                    vertical_Structure_of_Selected_Statistics_for_a_Single_Burst ( row_Index, 1 ). (temp_1(index, 1).element_Name) = temp_1(index, 1).element_Value;

                end

            end

        end

        vertical_Structure_of_Selected_Statistics_for_a_Single_Burst = vertical_Structure_of_Selected_Statistics_for_a_Single_Burst';
end