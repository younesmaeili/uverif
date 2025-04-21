1. In TabbyCAD there is no **ilang_backend.h** anymore so I did switch to use **rtlil_backend.h**.

2. Again, in new TabbyCAD the **mkhash** function is no longer accepts more than one arguments. Please refer to `/home/$USER/tabby/share/yosys/include/kernel/hashlib.h`

3. We have ti fix hashing for this purpose I am adding the following temporary information:
[Hashing](https://github.com/YosysHQ/yosys/blob/main/docs/source/yosys_internals/hashing.rst)
