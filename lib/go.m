function [edge,node]=go(f_edge,f_node,node0,k_end,p,q,r,plot_label)
    global k_EGF k_HRG
    for i_r=1:r
        node(:,1,i_r)=(node0==-1).*unifrnd(0,1,size(node0,1),1)+(node0==0)*0+(node0==1).*unifrnd(0,0.25,size(node0,1),1)+(node0==2).*unifrnd(0.25,0.5,size(node0,1),1)+(node0==3).*unifrnd(0.5,0.75,size(node0,1),1)+(node0==4).*unifrnd(0.75,1,size(node0,1),1)+(node0==5)*1;
        edge(:,1,i_r)=feval(f_edge,node(:,:,i_r),1);
        pbis=(p==-1).*unifrnd(0,1,size(edge,1),1)+(p==0)*0+(p==1).*unifrnd(0,0.25,size(edge,1),1)+(p==2).*unifrnd(0.25,0.5,size(edge,1),1)+(p==3).*unifrnd(0.5,0.75,size(edge,1),1)+(p==4).*unifrnd(0.75,1,size(edge,1),1)+(p==5)*1;
        qbis=(q==-1).*unifrnd(0,1,size(edge,1),1)+(q==0)*0+(q==1).*unifrnd(0,0.25,size(edge,1),1)+(q==2).*unifrnd(0.25,0.5,size(edge,1),1)+(q==3).*unifrnd(0.5,0.75,size(edge,1),1)+(q==4).*unifrnd(0.75,1,size(edge,1),1)+(q==5)*1;
        EGF_no_dist=0;
        HRG_no_dist=0;
        EGF_dist=unifrnd(0.25,0.5,1,1);
        HRG_dist=0;
        for k=1:k_end-1
            edge(:,k+1,i_r)=(1-pbis).*edge(:,k,i_r)+qbis.*pbis.*feval(f_edge,node(:,:,i_r),k);
            node(:,k+1,i_r)=feval(f_node,edge(:,:,i_r),k);
            node(1,k+1,i_r)=(k>=k_EGF)*EGF_dist+(k<k_EGF)*EGF_no_dist;
            node(2,k+1,i_r)=(k>=k_HRG)*HRG_dist+(k<k_HRG)*HRG_no_dist;
        endfor
    endfor
    for i_figure=1:ceil(numel(plot_label)/9)
        figure(i_figure)
        clf(i_figure)
    endfor
    for i_node=1:numel(plot_label)
        for i_r=1:r
            NODE(i_r,:)=node(i_node,:,i_r);
        endfor
        figure(ceil(i_node/9))
        subplot(3,3,i_node-9*(ceil(i_node/9)-1))
        plot((1:k_end)',NODE')
        axis([1,k_end,-0.1,1.1],"ticy","labely")
        title(plot_label{i_node})
    endfor
endfunction

