pub = rospublisher('/raw_vel'); %Publisher
sub_encoders = rossubscriber('/encoders'); %Subscriber
sub_bump = rossubscriber('/bump');


msgOut = rosmessage(pub);
msgOut.Data = [0.1, 0.1];
send(pub, msgOut);

msgIn = receive(sub_encoders);
origPos = msgIn.Data;
d = .25;
x0 = 0;
y0 = 0;
x_tot = 0;
y_tot = 0;

tstart = tic
while 1
    bump_message = receive(sub_bump);
    if (bump_message.Data(1) == 1 || ...
        bump_message.Data(2) == 1 || ...
        bump_message.Data(3) == 1 || ...
        bump_message.Data(4) == 1)
        msgOut.Data = [0, 0];
        send(pub, msgOut);
        break;
    end
        
        
    t = toc(tstart)
        speed = (4*(29 - 20*cos(t/5))^(1/2))/125;
        omega =  -(30*cos(t/5) - 54)/(100*cos(t/5) - 145);

        vR = ((d*omega)/2)+ speed;
        vR = vR;
        vL = speed - ((d*omega)/2);
        vL = vL;
        

        msgOut.Data = [vL, vR];
        send(pub, msgOut);         
end


% fprintf('x total is  %d.\n',x_tot)
% fprintf('y total is  %d.\n',y_tot)