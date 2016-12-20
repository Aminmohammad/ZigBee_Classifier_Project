function [ matrix_of_Selected_Statistics_for_Current_Device, matrix_of_FingerPrints_this_Device  ] =  FingerPrints_for_a_Single_Device (   vertical_Cell_of_Instantaneous_Elements_Names,                    ...                                          ... used here
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
% addpath('D:\ZigBee_Classifier_Project\RF_Fingerprint_Generator\2_Calculation_of_Statistics_for_all_Bursts')
% addpath('D:\ZigBee_Classifier_Project\Tools\Probability_Statistics')
% addpath('D:\ZigBee_Classifier_Project\Tools\Programing')
% vertical_Cell_of_Instantaneous_Elements_Names = {'Amplitude_Element', 'Phase_Element', 'Amplitude_Element'};
% vertical_Cell_of_Statistics_Names = {'Skewness', 'Variance', 'Mean'};
% selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst = 'Skewness';
% 
% % Generation of By=ursts
%     for burst_Index = 1 : 5
% 
%         for number_of_subRegions = 1 : 33
%             if ( number_of_subRegions ~= 33)
%                 vertical_Structure_of_a_Single_Burst( number_of_subRegions, 1 ).subRegion = rand ( 1, 100 );
%             else
%                 vertical_Structure_of_a_Single_Burst( number_of_subRegions, 1 ).subRegion = rand ( 1, 3200 );
%             end
%         end
% 
%         Vertical_Structure_of_all_Bursts ( burst_Index, 1 ). a_Single_Burst = vertical_Structure_of_a_Single_Burst;
% 
%     end
      
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
    
    
    %% Section 1: Collecting Essential Parameters
        % Level 1: Converting the 'Vertical_Structure_of_all_Bursts' to 'Vertical Case'
            Vertical_Structure_of_all_Bursts = Converter_to_Horizontal_or_Vertical_Vector( Vertical_Structure_of_all_Bursts, 'Vertical', 'vertical_Structure_of_a_Single_Burst' );     
            

    %% Section 2: Calculation of 'FingerPrint for current device'
    [ matrix_of_Selected_Statistics_for_Current_Device, matrix_of_FingerPrints_this_Device  ]  = Calculation_of_Statistics_for_all_Bursts (    vertical_Cell_of_Instantaneous_Elements_Names,                    ...                                          ... used here
                                                                                                                                               vertical_Cell_of_Statistics_Names,                                ... used here
                                                                                                                                                                                                                 ...
                                                                                                                                               selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst,      ... used in: Instantaneous_Element_Extractor / selected_Instantaneous_Element_Function 
                                                                                                                                               Vertical_Structure_of_all_Bursts);
                                                                                                                                                                           
    
    
end