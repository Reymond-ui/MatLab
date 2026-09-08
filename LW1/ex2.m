W1 = tf(0.0067, [1 0]);
W1_f = feedback(W1, 21, -1);
W2 = tf(14,[0.15 1]);
W2_s = series(W2, W1_f);
W2_f = feedback(W2_s, 36, -1);
W22 = tf(1,[1 0]);
W3 = series(W2_f, W22);
W4 = 59 * W3;
W5 = feedback(W4, 1, -1)





