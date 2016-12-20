function [ matrix_of_Selected_Statistics_for_all_Bursts, matrix_of_FingerPrints_for_all_Bursts  ]  = Calculation_of_Statistics_for_all_Bursts (    vertical_Cell_of_Instantaneous_Elements_Names,                    ...                                          ... used here
                                                                                                                                                   vertical_Cell_of_Statistics_Names,                                ... used here
                                                                                                                                                                                                                     ...
                                                                                                                                                   selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst,      ... used in: Instantaneous_Element_Extractor / selected_Instantaneous_Element_Function 
                                                                                                                                                   Vertical_Structure_of_all_Bursts)
                                                                                                                                                                           
% clc
% clear all
% warning off MATLAB:namelengthmaxexceeded
% addpath('D:\ZigBee_Classifier_Project\Tools\Instantaneous_Elements')
% addpath('D:\ZigBee_Classifier_Project\RF_Fingerprint_Generator\4_Instantaneous_Elements_Extractor_for_a_Single_Burst')
% addpath('D:\ZigBee_Classifier_Project\RF_Fingerprint_Generator\5_Instantaneous_Elements_Extractor_for_a_Single_subRegion')
% addpath('D:\ZigBee_Classifier_Project\RF_Fingerprint_Generator\3_Static_Extractor_for_a_Single_Burst')
% addpath('D:\ZigBee_Classifier_Project\Tools\Probability_Statistics')
% addpath('D:\ZigBee_Classifier_Project\Tools\Programing')
% vertical_Cell_of_Instantaneous_Elements_Names = {'Amplitude_Element', 'Phase_Element', 'Amplitude_Element'};
% vertical_Cell_of_Statistics_Names = {'Skewness', 'Variance', 'Mean'};
% selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst = 'Skewness';
% 
% for burst_Index = 1 : 5
%     
%     for number_of_subRegions = 1 : 33
%         if ( number_of_subRegions ~= 33)
%             vertical_Structure_of_a_Single_Burst( number_of_subRegions, 1 ).subRegion = rand ( 1, 100 );
%         else
%             vertical_Structure_of_a_Single_Burst( number_of_subRegions, 1 ).subRegion = rand ( 1, 3200 );
%         end
%     end
%     
%     Vertical_Structure_of_all_Bursts ( burst_Index, 1 ). a_Single_Burst = vertical_Structure_of_a_Single_Burst;
%     
% end



% Description:    'matrix_of_Selected_Statistics_for_all_Burst'
%                              all Bursts ( Matrix )
%              _________________________________________________________________________________________________________________________________________________________________________________________________________________                     ________________________________________________________________________________________________________________________________________________________________________________________________________________
% Amplitude:   | Sigma_A_1       Sigma_A_2           ...     Sigma_A_33      |       Gamma_A_1       Gamma_A_2           ...     Gamma_A_33     |         Kurtosis_A_1      Kurtosis_A_2          ...     Kurtosis_A_33         |        ...        |Sigma_A_1       Sigma_A_2           ...     Sigma_A_33      |       Gamma_A_1       Gamma_A_2           ...     Gamma_A_33     |         Kurtosis_A_1      Kurtosis_A_2          ...     Kurtosis_A_33         |
%                                                                                                                                                                                        
% Phase:       | Sigma_Phi_1     Sigma_Phi_2         ...     Sigma_Phi_33    |       Gamma_Phi_1     Gamma_Phi_2         ...     Gamma_Phi_33   |         Kurtosis_Phi_1    Kurtosis_Phi_2        ...     Kurtosis_Phi_33       |        ...        |Sigma_Phi_1     Sigma_Phi_2         ...     Sigma_Phi_33    |       Gamma_Phi_1     Gamma_Phi_2         ...     Gamma_Phi_33   |         Kurtosis_Phi_1    Kurtosis_Phi_2        ...     Kurtosis_Phi_33       |
%                                                                
% Frequency:   | Sigma_F_1       Sigma_F_2           ...     Sigma_F_33      |       Gamma_F_1       Gamma_F_2           ...     Gamma_F_33     |         Kurtosis_F_1      Kurtosis_F_2          ...     Kurtosis_F_33         |        ...        |Sigma_F_1       Sigma_F_2           ...     Sigma_F_33      |       Gamma_F_1       Gamma_F_2           ...     Gamma_F_33     |         Kurtosis_F_1      Kurtosis_F_2          ...     Kurtosis_F_33         |
%              _________________________________________________________________________________________________________________________________________________________________________________________________________________                     _________________________________________________________________________________________________________________________________________________________________________________________________________________
%
%                                                                      Burst_1                                                                                                                                                                                                                                  Burst_N
%
% Description:    'matrix_of_FingerPrints_for_all_Bursts'
%                              all Bursts ( Matrix )
%              _______________              ________________
% Amplitude:   | Amplitude_FP |     ...     | Amplitude_FP |
%                                                                                                                                                                                        
% Phase:       |    Phi_FP    |     ...     |    Phi_FP    |       
%                                                                
% Frequency:   | Frequency_FP |     ...     | Frequency_FP |       
%              _______________              ________________
%               
%                  Burst_1                      Burst_N 


    %% Section 0: Preliminaries

    %% Section 1: Collecting Essential Parameters
        % Level 1: Converting the 'Vertical_Structure_of_all_Bursts' to 'Vertical Case'
            Vertical_Structure_of_all_Bursts = Converter_to_Horizontal_or_Vertical_Vector( Vertical_Structure_of_all_Bursts, 'Vertical', 'vertical_Structure_of_a_Single_Burst' );     
        
    %% Section 2: Calculation of 'Statistic' for all 'Bursts'
        matrix_of_Selected_Statistics_for_all_Bursts= [];
        for burst_Index = 1 : size ( Vertical_Structure_of_all_Bursts, 1 )
            
            % Level 1: Extraction of a Single Burst
                vertical_Structure_of_a_Single_Burst                         = Vertical_Structure_of_all_Bursts ( burst_Index, 1 ). a_Single_Burst;
            
            % Level 2: Extraction of 'Statistics' for a Single Burst                
                vertical_Structure_of_Selected_Statistics_for_a_Single_Burst = Static_Extractor_for_a_Single_Burst ( vertical_Structure_of_a_Single_Burst,               ...
                                                                                                                     vertical_Cell_of_Instantaneous_Elements_Names,      ...
                                                                                                                     vertical_Cell_of_Statistics_Names );
                                                                                                                 
            % Level 3: Concatenation of fields in a Single Burst which have the same 'Instantaneous Element'
                 fields = fieldnames (vertical_Structure_of_Selected_Statistics_for_a_Single_Burst);

                 matrix_of_Selected_Statistics_for_a_Single_Burst =[];
                 vertical_Cell_of_all_previously_Discovered_Instantaneous_element =cell(0,0);
                 for field_Index = 1 : size ( fields, 1 )
                    
                     continue_Allowed = 1;
                     current_Field = char ( fields ( field_Index, 1 ));
                     underline_Indices = strfind ( current_Field, '_');
                     if ( size ( underline_Indices, 2 ) > 1 ) % This line omits the 'pure instantaneous elements' like : 'Amplitude_Element' and 'Phase_Element' and 'Frequency_Element'
                     
                         current_Instantaneous_element = current_Field ( 1, underline_Indices (1, end - 1) : end );

                         % Checking to Passby the loop or not, if the 'Instantaneous Element' is sweeped before
                             for index = 1 : size ( vertical_Cell_of_all_previously_Discovered_Instantaneous_element, 1 )
                                 if ( strfind ( char(vertical_Cell_of_all_previously_Discovered_Instantaneous_element( index, 1 )), current_Instantaneous_element ) == 1 )
                                     continue_Allowed = 0;

                                 end
                             end
                         
                             if ( continue_Allowed == 0 )
                                 continue;
                             end
                         
                         vertical_Cell_of_all_previously_Discovered_Instantaneous_element ( size ( vertical_Cell_of_all_previously_Discovered_Instantaneous_element, 1 ) + 1, 1 ) = {current_Instantaneous_element};
                         
                         found_Indices =[];
                         temp_matrix_of_Selected_Statistics_for_a_Single_Burst = [];
                         for element_Index = 1 : size (  fields, 1)

                            found_Index = strfind ( char(fields ( element_Index, 1 ) ), current_Instantaneous_element );
                            if ( isempty ( found_Index ) == 0  )    
                                
                                temp  = [vertical_Structure_of_Selected_Statistics_for_a_Single_Burst(:).(char(fields( element_Index, 1 )))];
                               
                                temp_matrix_of_Selected_Statistics_for_a_Single_Burst ( 1, size ( temp_matrix_of_Selected_Statistics_for_a_Single_Burst, 2 ) + 1 : size ( temp_matrix_of_Selected_Statistics_for_a_Single_Burst, 2 ) + size ( temp, 2 ) ) = temp;

                                
                            end

                         end
                         
                         matrix_of_Selected_Statistics_for_a_Single_Burst  = [ matrix_of_Selected_Statistics_for_a_Single_Burst; temp_matrix_of_Selected_Statistics_for_a_Single_Burst ];
           
                     end
                     
                    
                 end
                 
                     matrix_of_Selected_Statistics_for_all_Bursts = [ matrix_of_Selected_Statistics_for_all_Bursts matrix_of_Selected_Statistics_for_a_Single_Burst ];
                     
                     matrix_of_FingerPrints_for_all_Bursts ( :, burst_Index ) = FingerPrint_Generation_fro_a_Single_Burst ( matrix_of_Selected_Statistics_for_a_Single_Burst, selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst );
                     

        end

end


function FingerPrint_for_a_Single_Burst = FingerPrint_Generation_fro_a_Single_Burst ( matrix_of_Selected_Statistics_for_a_Single_Burst, selected_Algorithm_for_Making_FingerPrint_of_a_Burst )

    current_Statistic_Name     = selected_Algorithm_for_Making_FingerPrint_of_a_Burst;
    current_Statistic_Function = str2func ( current_Statistic_Name );
    
    for row_Index = 1 : size ( matrix_of_Selected_Statistics_for_a_Single_Burst, 1 )
        current_Row = matrix_of_Selected_Statistics_for_a_Single_Burst ( row_Index, : );
        FingerPrint_for_a_Single_Burst ( row_Index, 1 )  = current_Statistic_Function ( current_Row, 0 );
    end

end