function [edge,node]=go(f_edge,f_node,node0,k_end,p,q,r,plot_label,dist,k_dist,plot_all)
    k_dist=k_dist.*k_end/10;
    for i_r=1:r
        node(:,1,i_r)=(node0==-1).*unifrnd(0,1,size(node0,1),1)+(node0==0)*0+(node0==1).*unifrnd(0,0.25,size(node0,1),1)+(node0==2).*unifrnd(0.25,0.5,size(node0,1),1)+(node0==3).*unifrnd(0.5,0.75,size(node0,1),1)+(node0==4).*unifrnd(0.75,1,size(node0,1),1)+(node0==5)*1;
        edge(:,1,i_r)=feval(f_edge,node(:,:,i_r),1);
        p_bis=(p==-1).*unifrnd(0,1,size(edge,1),1)+(p==0)*0+(p==1).*unifrnd(0,0.25,size(edge,1),1)+(p==2).*unifrnd(0.25,0.5,size(edge,1),1)+(p==3).*unifrnd(0.5,0.75,size(edge,1),1)+(p==4).*unifrnd(0.75,1,size(edge,1),1)+(p==5)*1;
        q_bis=(q==-1).*unifrnd(0,1,size(edge,1),1)+(q==0)*0+(q==1).*unifrnd(0,0.25,size(edge,1),1)+(q==2).*unifrnd(0.25,0.5,size(edge,1),1)+(q==3).*unifrnd(0.5,0.75,size(edge,1),1)+(q==4).*unifrnd(0.75,1,size(edge,1),1)+(q==5)*1;
        dist_bis=(dist==-1).*unifrnd(0,1,size(dist,1),1)+(dist==0)*0+(dist==1).*unifrnd(0,0.25,size(dist,1),1)+(dist==2).*unifrnd(0.25,0.5,size(dist,1),1)+(dist==3).*unifrnd(0.5,0.75,size(dist,1),1)+(dist==4).*unifrnd(0.75,1,size(dist,1),1)+(dist==5)*1;
        for k=1:k_end-1
            edge(:,k+1,i_r)=(1-p_bis).*edge(:,k,i_r)+q_bis.*p_bis.*feval(f_edge,node(:,:,i_r),k);
            node(:,k+1,i_r)=not(and(k_dist(:,1)<=k,k<=k_dist(:,2))).*feval(f_node,edge(:,:,i_r),k,node(:,:,i_r))+and(k_dist(:,1)<=k,k<=k_dist(:,2)).*dist_bis;
        endfor
    endfor
    if plot_all
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
    endif
endfunction

