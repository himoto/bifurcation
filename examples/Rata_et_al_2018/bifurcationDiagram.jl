function diagram()

    rc("figure",figsize = (20,3));
    rc("font",family = "Arial");
    rc("font",size = 14);
    rc("axes",linewidth = 1);
    rc("lines",linewidth = 2);

    for i=1:4
        if length(br[i]) > 0
            intermediate_ss = [];
            for j=2:length(br[i])
                if br[i][j] - br[i][j-1] != 1
                    intermediate_ss = br[i][j-1]:br[i][j];
                end
            end
        end

        subplot(1,4,i);

        if i==1
            plot(fp[i][1:br[i][1]-1,VN+1],fp[i][1:br[i][1]-1,V.Subp+1],color="royalblue");
            plot(fp[i][br[i][1]:intermediate_ss[1]-1,VN+1],fp[i][br[i][1]:intermediate_ss[1]-1,V.Subp+1],color="darkgray","--");
            plot(fp[i][intermediate_ss,VN+1],fp[i][intermediate_ss,V.Subp+1],color="darkorange");
            plot(fp[i][intermediate_ss[end]+1:br[i][end],VN+1],fp[i][intermediate_ss[end]+1:br[i][end],V.Subp+1],color="darkgray","--");
            plot(fp[i][br[i][end]+1:end,VN+1],fp[i][br[i][end]+1:end,V.Subp+1],color="crimson");

            xlim(0,0.81);
            xlabel("1NMPP1 (μM)");
            ylim(-0.05,1.05);
            yticks([0,0.5,1],[0,50,100]);
            ylabel("Sub-p (%)");
            title("Control",fontsize=18);

        elseif i==2
            plot(fp[i][1:br[i][1]-1,VN+1],fp[i][1:br[i][1]-1,V.Subp+1],color="royalblue");
            plot(fp[i][br[i],VN+1],fp[i][br[i],V.Subp+1],color="darkgray","--");
            plot(fp[i][br[i][end]+1:end,VN+1],fp[i][br[i][end]+1:end,V.Subp+1],color="crimson");

            xlim(0,0.81);
            xlabel("1NMPP1 (μM)");
            ylim(-0.05,1.05);
            yticks([0,0.5,1],[0,50,100]);
            title("Wee1 inhibition",fontsize=18);

        elseif i==3
            plot(fp[i][1:br[i][1]-1,VN+1],fp[i][1:br[i][1]-1,V.Subp+1],color="royalblue");
            plot(fp[i][br[i],VN+1],fp[i][br[i],V.Subp+1],color="darkgray","--");
            plot(fp[i][br[i][end]+1:end,VN+1],fp[i][br[i][end]+1:end,V.Subp+1],color="crimson");

            xlim(0,0.81);
            xlabel("1NMPP1 (μM)");
            ylim(-0.05,1.05);
            yticks([0,0.5,1],[0,50,100]);
            title("Gwl siRNA",fontsize=18);

        elseif i==4
            plot(fp[i][:,VN+1],fp[i][:,V.Subp+1],color="darkorange");

            xlim(0,0.81);
            xlabel("1NMPP1 (μM)");
            ylim(-0.05,1.05);
            yticks([0,0.5,1],[0,50,100]);
            title("Wee1 inhibition & Gwl siRNA",fontsize=18);
        end

    end

    show();
end