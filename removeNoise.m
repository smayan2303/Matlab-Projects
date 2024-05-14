

function [ rad ] = removeNoise( rad, n )
    %removeNoise Removes noise from a matrix of radiation values by
    %  applying an nxn mean filter three times.
    %       n: The size of the filter (e.g. if n=3, use a 3x3 filter)
    %     rad: a matrix of numbers representing the radiation
    %          measurements from the scanner.
    %          NOTE: A matrix obtained from a call to the scan_radiation()
    %          may be used as an input argument when calling this function,
    %          but you should NOT call scan_radiation() inside of this
    %          function!
 

    %create a matrix of all ones and divide it by the size of the filter
    %matrix squared so each square in the matrix is equivalent and totals
    %to 1
    filterMatrix = ones(n) ;
    filterMatrix = filterMatrix / (n^2);
    %use the imfilter function 3 times to reduce noise in the image
    rad = imfilter(rad,filterMatrix,'replicate');
    rad = imfilter(rad,filterMatrix,'replicate');
    rad = imfilter(rad,filterMatrix,'replicate');
end
