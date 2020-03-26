%ÂË²¨Æ÷
[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters('coif3');
subplot(2,2,1);
stem(Lo_D);grid;
title('(a)')
subplot(2,2,2);
stem(Lo_R);grid;
title('(c)')
subplot(2,2,3);
stem(Hi_D);grid;
title('(b)')
subplot(2,2,4);
stem(Hi_R);grid;
title('(d)4')


