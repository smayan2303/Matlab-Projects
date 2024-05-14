
function [ hasTumor ] = detectTumor( brain )
    %detectTumor Returns whether or not a tumor was found in the image.
    %     brain: a matrix of numbers representing a grayscale image of a 
    %            brain scan. Bright areas may be tumors and need to
    %            be flagged for further testing.
    %            To get test data for this function, you may call the
    %            provided scan_brain() function and pass the value it
    %            returns into this function. However, DO NOT call
    %            scan_brain() in the code for this function itself.




    % make a variable that counts the number of values above a certain
    % threshold
    counter = 0;
    %make the brain scan smaller to remove all unnecessary data
    brain = brain(100:400,100:400);
    %remove noise in the brain scan to get rid of all the outlier data that
    %might skew the results

    brain = removeNoise(brain , 15);

    %use two for loops to loop through the rows and columns of the matrix
    %and if a value is above a certain threshold increase the number on the
    %counter
    %set a threshold for the values to avoid hard coding
    threshold = 0.5;
    for row = 1:size(brain,1)
        for col = 1:size(brain,2)
            if (brain(row,col) > threshold)
                counter = counter + 1;
            end
        end
    end
    % If the counter(number of values above the threshold) exceeds a
    % certain amount then the image has a tumor
    maxValue = max(max(brain));
    if counter > 4000 & maxValue > 0.7
        hasTumor = 1;
    %If the counter(number of values above the threshold) does not exceed a
    % certain amount then the image does not have a tumor
    else 
        hasTumor = 0;
    end
end

