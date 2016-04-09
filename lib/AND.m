% Copyright (c) 2014-2016, Arnaud Poret
% All rights reserved.
% This work is licensed under the BSD 2-Clause License.
function y=AND(varargin)
    y=varargin{1};
    for i_varargin=2:numel(varargin)
        y=y*varargin{i_varargin};
    endfor
endfunction
