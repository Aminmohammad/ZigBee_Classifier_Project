function [ frequency_Values_Horizontal_Vector, FFT_Horizontal_Vector] = Spectrum_Calculator_function ( input_Signal, Sampling_Frequency )

    %%% This function assumes that input signal is in a Row form, or converts it to a Row form, itself...

    %% Section 1: Extracting Essential Parameters
        % Level 1: Input Signal ( It Should Be Horizontal non-empty Input )
            if ( isvector ( input_Signal ) == 1 )
                    input_Signal = reshape ( input_Signal, 1, size ( input_Signal, 1 ) * size ( input_Signal, 2 ) );

            else
                error ( '%s', 'Input Signal to "Spectrum Calculator function" Should be non-empty Horizontal Vector!' )

            end
            
        % Level 2: Determination of 'Number of Points'
            number_of_FFT_Points = 2 ^ nextpow2 ( size ( input_Signal, 2 ) ); 

    %% Section 2: Start of Calculation of one Sided Spectrum amplitude and its Relevant frequencies    >>
        FFTTempVector = abs ( fft ( input_Signal, number_of_FFT_Points ) ) / size( input_Signal, 2 );
        FrequencyTempVector = Sampling_Frequency/2 * linspace (0, 1, number_of_FFT_Points/2+1);

    %% Section 3: Start of Calculation of Second Side of Spectrum amplitude and its Relevant frequencies    >>
        % Level 1:
           [~,Half_of_FFTTempVector_ColNum] = size(FFTTempVector(1,1:(number_of_FFT_Points/2)+1));
           FFT_Horizontal_Vector = zeros(1,(2*Half_of_FFTTempVector_ColNum)-1);
           [~,FFTMatrix_ColNum] = size(FFT_Horizontal_Vector);
           FFT_Horizontal_Vector(1,FFTMatrix_ColNum-Half_of_FFTTempVector_ColNum+1:FFTMatrix_ColNum) = FFTTempVector(1,1:(number_of_FFT_Points/2)+1);
           FFTTempVector_Prime = FFTTempVector(1,1:(number_of_FFT_Points/2)+1);
           for i = 1:FFTMatrix_ColNum-Half_of_FFTTempVector_ColNum
               FFT_Horizontal_Vector(1,i)=FFTTempVector_Prime(1,Half_of_FFTTempVector_ColNum-(i-1));
               
           end

        % Level 2:           
           [~,FrequencyTempVector_ColNum]=size(FrequencyTempVector);
           frequency_Values_Horizontal_Vector=zeros(1,(2*FrequencyTempVector_ColNum)-1);
           [~,FrequencyMatrix_ColNum]=size(frequency_Values_Horizontal_Vector);
           frequency_Values_Horizontal_Vector(1,FrequencyMatrix_ColNum-FrequencyTempVector_ColNum+1:FrequencyMatrix_ColNum)=FrequencyTempVector;
           for i=1:FrequencyMatrix_ColNum-FrequencyTempVector_ColNum
               frequency_Values_Horizontal_Vector(1,i)=-1*FrequencyTempVector(1,FrequencyTempVector_ColNum-(i-1));
           end
