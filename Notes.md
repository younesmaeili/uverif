1. In TabbyCAD there is no **ilang_backend.h** anymore so I did switch to use **rtlil_backend.h**.

2. Again, in new TabbyCAD the **mkhash** function is no longer accepts more than one arguments. Please refer to `/home/$USER/tabby/share/yosys/include/kernel/hashlib.h`

3. We have to fix hashing and for this purpose we should refer to [Hashing](https://github.com/YosysHQ/yosys/blob/main/docs/source/yosys_internals/hashing.rst) for more information.
   
4. util.h and dataflow.h in `/src_revised` require modification since they use **mkhash** and mkhash has been **deprecated** in TabbyCAD (refer to `/home/$USER/tabby/share/yosys/include/kernel/hashlib.h` line 287).

