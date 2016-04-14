# Enhancing Boolean networks with fuzzy operators and edge tuning

Copyright (c) 2014-2016, [Arnaud Poret](https://github.com/arnaudporet)

All rights reserved.

This work is licensed under the [BSD 2-Clause License](https://opensource.org/licenses/BSD-2-Clause).

## How to

1. read my article (all is explained inside), freely available on [arXiv](https://arxiv.org/) and [HAL](https://hal.archives-ouvertes.fr/):
    * https://arxiv.org/abs/1407.1135
    * https://hal.archives-ouvertes.fr/hal-01018236
2. clone enhance_my_Boolean (or [download](https://github.com/arnaudporet/enhance_my_Boolean/archive/master.zip) it if you do not use [Git](https://git-scm.com/)):
    * `git clone https://github.com/arnaudporet/enhance_my_Boolean.git`
3. open the file `example.r`
4. (optional) if your equations are encoded exactly (include case sensitivity and no spaces) as in the file `equations`:
    * replace the contents of the file `equations` by your own equations
    * run the script `name2x.py`: `python name2x.py`
    * it will produce the file `equations.xed`
    * open the file `equations.xed` and paste its contents at its right place

This work is tested with [R](https://www.r-project.org/) version 3.2.4 under [Arch Linux](https://www.archlinux.org/).

How to get R: https://www.r-project.org/

Most [Linux distributions](https://distrowatch.com/) provide R in their official repositories.
