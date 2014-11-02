function y=AND(varargin)
    y=varargin{1};
    for i_varargin=2:numel(varargin)
        y=y*varargin{i_varargin};
    endfor
endfunction
