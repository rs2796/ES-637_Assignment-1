
prompt = ' Enter Number of eigen faces: ';
num = input(prompt);
[r1,r2] = loadtrainingimages(); % Load training data set

[s1,s2] = loadtestimages(); % Load test data set

O=uint8(ones(1,size(r1,2))); 
m=uint8(mean(r1,2));   % Mean image (average of n faces)              
r11=r1-uint8(single(m)*single(O)); % subtarcting the average from each face
[U,S,K] = svd(single(r11.')/sqrt(size(r1,2))); % singular value decomposition of r11.transpose/(n^.5)

P1 = transpose(K);
P1 = P1(1:num,:);
P2 = P1*single(r11);
H = single(zeros(size(s1,2),size(r1,2)));
E = 0;

%This for loop compares every image in test data set with every image in
%the training data set. Basicall each image in training data set is
%represented by a feature descrpitor which is vector of length = Number
%entered at the beginning. And the training image which is most closest to
%our test image will be displayed.

for i = 1:size(s1,2);
    ve = s1(:,i) - m ;
    ne = P1*single(ve);
    for j = 1:size(P2,2);
        H(i,j) = norm(P2(:,j)-ne);
    end
    
    subplot(121); 
    imshow(reshape(s1(:,i),112,92));title('Looking for ...','FontWeight','bold','Fontsize',16,'color','red');
    [Min, index] = min(H(i,:));
    
    if r2(index) == s2(i);
        E = E + 1;
        subplot(122); 
        imshow(reshape(r1(:,index),112,92));title('Matched','FontWeight','bold','Fontsize',16,'color','blue');
        drawnow;
        pause(1);
    else
        subplot(122);
        
        imshow(reshape(r1(:,index),112,92));title('Not Matched','FontWeight','bold','Fontsize',16,'color','blue');
        drawnow;
        pause(3);
        
    
    end
end

efficiency = (E/size(s1,2))*100;
fprintf('Effiency');
disp(efficiency);


    
    
        