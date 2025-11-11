
%Surge
RefModZeta1 = 1.1;
%Sway
RefModZeta2 = 1.0;
%Yaw
RefModZeta3 = 1.0;

%Surge
RefModOmega1 = 0.03;
%Sway
RefModOmega2 = 0.03;
%Yaw
RefModOmega3 = 0.03;

%Surge
RefModDotSaturation1 = 10;
%Sway 
RefModDotSaturation2 = 10;
%Yaw
RefModDotSaturation3 = 10;


%Surge
RefModDotDotSaturation1 = 5;
%Sway 
RefModDotDotSaturation2 = 5;
%Yaw
RefModDotDotSaturation3 = 5;



RefModDelta = diag([RefModZeta1,RefModZeta2,RefModZeta3]);

RefModOmega = diag([RefModOmega1,RefModOmega2,RefModOmega3]);

RefModSaturationDot = diag([RefModDotSaturation1,RefModDotSaturation2,RefModDotSaturation3]);

RefModSaturationDotDot = diag([RefModDotDotSaturation1,RefModDotDotSaturation2,RefModDotDotSaturation3]);
