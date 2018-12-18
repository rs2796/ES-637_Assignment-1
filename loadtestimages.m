% This is a fucntion for loading test images. The dataset contains 40 folder and each folder has 10 
% different images of a particular person. The first seven images from each folder I have taken for training
% data set and the left three images I will use for test data set.


function [out1, out2] = loadtestimages()


persistent testing;
persistent testingmat;
persistent testinglabel;
if(isempty(testing))
    testmat=zeros(10304,120);
    testlabel = zeros(1,120);
    for i=1:40
        cd(strcat('Dataset'));
        cd(strcat('s',num2str(i)));
        for j=8:10
            image=imread(strcat(num2str(j),'.pgm'));
            testmat(:,(i-1)*3+(j-7))=reshape(image,size(image,1)*size(image,2),1);
            testlabel((i-1)*3+(j-7)) = i;
        end
        
        cd ..
        cd ..
    end
    testingmat=uint8(testmat); % Convert to unsigned 8 bit numbers to save memory.
    testinglabel = uint8(testlabel);
end
testing=1;  % Set 'loaded' to aviod loading the database again. 
out1 = testingmat;
out2  =testinglabel;
end
