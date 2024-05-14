
function [ img ] = zones( img, rad )
    %zones Generates an image colored according to radiation threat 
    %  zones. Values from rad are used to determine the zone, and the hue
    %  value in img is set accordingly.
    %     img: a 3-dimensional matrix of numbers representing an image in
    %          RGB (red-green-blue) format, which forms the background for
    %          to which the heatmap colors are applied.
    %     rad: a matrix of numbers representing the radiation
    %          measurements, between 0 and 100 millisieverts.
    %          It is has the same width and height as the img parameter.


    %convert the image to hsv format
    hsvimg = rgb2hsv(img);
    %copy the hue channel into another variable
    hue = hsvimg(: , : , 1);
    % change the hue values based on the thresholds from the radiation
    % channel
    hue(rad < 20) = 0.6;
    hue(rad >= 20 & rad < 50) = 0.4;
    hue(rad >= 50 & rad < 70) = 0.2;
    hue(rad >= 70 & rad < 90) = 0.1;
    hue(rad >= 90) = 0;
    %copy the saturation channel into a variable
    sat = hsvimg(:,:,2);
    %set saturation to the max
    sat = 1;
    %copy in the new hue and saturation channels into the original image
    hsvimg(:,:,1) = hue;
    hsvimg(:,:,2) = sat;
    %convert it back into rgb format
    img = hsv2rgb(hsvimg);
end

