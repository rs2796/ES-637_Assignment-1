% This is a fucntion for loading test images. The dataset contains 40 folder and each folder has 10 
% different images of a particular person. For training data set I will be 
% using first seven images of each folder and the rest three images of each folder
% will be used for test data set. 



function [out1, out2] = loadtrainingimages()


persistent training;
persistent trainingmat;
persistent traininglabel;
if(isempty(training))
    trainmat=zeros(10304,280);
    trainlabel = zeros(1,280);
    for i=1:40
        cd(strcat('Dataset'));
        cd(strcat('s',num2str(i)));
        for j=1:7
            image=imread(strcat(num2str(j),'.pgm'));
            trainmat(:,(i-1)*7+j)=reshape(image,size(image,1)*size(image,2),1);
            trainlabel((i-1)*7+j) = i;
        end
        cd ..
        cd ..
    end
    trainingmat=uint8(trainmat); % Convert to unsigned 8 bit numbers to save memory.
    traininglabel = uint8(trainlabel);
end
training=1;  % Set 'loaded' to aviod loading the database again. 
out1 = trainingmat;
out2  = traininglabel;
end
