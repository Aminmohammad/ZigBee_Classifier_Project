close all
clear all
clc

a = load('U:\MAHAB\Ph.D._Files\Matlab_Codes\PHD_Project\ZigBee_Classifier_Project\Resources\1_DatSet\2_Raw_DataSet_Mathieu_and_Guillaume.mat');
b = a.vertical_Structure_of_all_DataPoints_for_all_Devices;

DataSet = [];
labels    =[];
for index = 1 : size ( b, 1 )    
%     b( index, 1).dataPoints_for_each_Device
    temp_Matrix = [ b( index, 1).dataPoints_for_each_Device ];
    
    if index > 1
        if ( size( DataSet, 1 ) >= size( temp_Matrix, 1 ) )
            DataSet = [ DataSet( 1 : size( temp_Matrix, 1 ), :  )  temp_Matrix ];            

        else
            DataSet = [ DataSet                                               temp_Matrix( 1 : size( DataSet, 1 ), : )  ];

        end
        
        labels    = [ labels       index*ones( 1, size ( temp_Matrix, 2 ) ) ];
        
    else        
        DataSet = temp_Matrix;
        labels    = index * ones ( 1, size ( temp_Matrix, 2 ) );
        
    end
    
end

input_DataSet = [ DataSet( 10000:10001, 1: 400 ); labels( 1, 1: 400 ) ];
selected_Kernel_Function = 'mlp';
drawing_Graph_Strategy = true ;

Matlab_SVM ( input_DataSet, selected_Kernel_Function, drawing_Graph_Strategy )