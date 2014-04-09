#Copyright (c) 2013-2014, Arnaud Poret
#All rights reserved.
function [edge,node]=go(fedge,fnode,node0,kmax,p,q,repeat,plot_label)
    for i_repeat=1:repeat
        node(:,1,i_repeat)=(node0==-1).*unifrnd(0,1,size(node0,1),1)+(node0==0).*0+(node0==1).*unifrnd(0,1/3,size(node0,1),1)+(node0==2).*unifrnd(1/3,2/3,size(node0,1),1)+(node0==3).*unifrnd(2/3,1,size(node0,1),1)+(node0==4).*1;
        edge(:,1,i_repeat)=feval(fedge,node(:,:,i_repeat),1);
        pbis=(p==-1).*unifrnd(0,1,size(edge,1),1)+(p==1).*unifrnd(0,1/3,size(edge,1),1)+(p==2).*unifrnd(1/3,2/3,size(edge,1),1)+(p==3).*unifrnd(2/3,1,size(edge,1),1);
        qbis=(q==-1).*unifrnd(0,1,size(edge,1),1)+(q==0).*0+(q==1).*unifrnd(0,1/3,size(edge,1),1)+(q==2).*unifrnd(1/3,2/3,size(edge,1),1)+(q==3).*unifrnd(2/3,1,size(edge,1),1)+(q==4).*1;
        for k=1:kmax-1
            edge(:,k+1,i_repeat)=(1-pbis).*edge(:,k,i_repeat)+qbis.*pbis.*feval(fedge,node(:,:,i_repeat),k);
            node(:,k+1,i_repeat)=feval(fnode,edge(:,:,i_repeat),k);
        endfor
    endfor
    for i_figure=1:ceil(numel(plot_label)/9)
        figure(i_figure)
        clf(i_figure)
    endfor
    for i_node=1:numel(plot_label)
        for i_repeat=1:repeat
            NODE(i_repeat,:)=node(i_node,:,i_repeat);
        endfor
        figure(ceil(i_node/9))
        subplot(3,3,i_node-9*(ceil(i_node/9)-1))
        plot((1:kmax)',NODE')
        axis([1,kmax,-0.2,1.2])
        legend(plot_label{i_node})
    endfor
endfunction
################################################################################
##############################       LICENSE      ##############################
##############################    BSD 3-Clause    ##############################
################################################################################

#Copyright (c) 2013-2014, Arnaud Poret
#All rights reserved.

#Redistribution and use in source and binary forms, with or without modification,
#are permitted provided that the following conditions are met:

#1. Redistributions of source code must retain the above copyright notice, this
#list of conditions and the following disclaimer.

#2. Redistributions in binary form must reproduce the above copyright notice,
#this list of conditions and the following disclaimer in the documentation and/or
#other materials provided with the distribution.

#3. Neither the name of the copyright holder nor the names of its contributors
#may be used to endorse or promote products derived from this software without
#specific prior written permission.

#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
#ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
#ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
#ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
