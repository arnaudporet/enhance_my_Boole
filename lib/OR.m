#Copyright (c) 2013, Arnaud Poret
#All rights reserved.
function y=OR(varargin)
    y=varargin{1};
    for i_varargin=2:numel(varargin)
        y=y+varargin{i_varargin}-y*varargin{i_varargin};
    endfor
endfunction
