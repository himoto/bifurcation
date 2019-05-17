using PyPlot;

rc("figure",figsize = (9,6));
rc("font",family = "Arial");
rc("font",size = 20);
rc("axes",linewidth = 1);
rc("lines",linewidth = 2);

plot(fp[1][1:br[1][1]-1,VN+1],fp[1][1:br[1][1]-1,p27T+1],"r-");
plot(fp[1][br[1],VN+1],fp[1][br[1],p27T+1],"r--");
plot(fp[1][br[1][end]+1:end,VN+1],fp[1][br[1][end]+1:end,p27T+1],"r-");

for i=2:5
  plot(fp[i][1:br[i][1]-1,VN+1],fp[i][1:br[i][1]-1,p27T+1],"-",color="silver");
  plot(fp[i][br[i],VN+1],fp[i][br[i],p27T+1],"--",color="silver");
  plot(fp[i][br[i][end]+1:end,VN+1],fp[i][br[i][end]+1:end,p27T+1],"-",color="silver");
end

xlabel("CycE level");
ylabel("p27 level");

xlim(0.0,1.0);
xticks([0,0.5,1]);
ylim(0.0,2.05);
yticks([0,1,2]);
