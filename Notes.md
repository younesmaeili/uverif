1. In TabbyCAD there is no **ilang_backend.h** anymore so I did switch to use **rtlil_backend.h**.

2. **(solved)** Again, in new TabbyCAD the **mkhash** function is no longer accepts more than one arguments. Please refer to `/home/$USER/tabby/share/yosys/include/kernel/hashlib.h`

3. We have to fix hashing and for this purpose we should refer to [Hashing](https://github.com/YosysHQ/yosys/blob/main/docs/source/yosys_internals/hashing.rst) for more information.
   
4. **(solved)** `util.h` and `dataflow.h` in `/src_revised` require modification since they use **mkhash** and mkhash has been **deprecated** in TabbyCAD (refer to `/home/$USER/tabby/share/yosys/include/kernel/hashlib.h` line 287).

5. I have replaced deprecated mkhash with new Hasher method fixing util.h and dataflow.h. Those files will be updated along with an instruction.

6. The `util_verilogbackend.h` should be modified. Since older Yosys versions used direct `data.bits` member access, while newer versions require using `data.size()` and `data[i]` methods instead. So we should replace all `data.bits.size()` with `data.size()` and all `data.bits[i]` with `data[i]`.

7. Directly accessing `initval.bits` is no longer allowed in newer yosys versions becasuse `bits` are private now. So for a fix we can store bits in a `std::vector<RTLIL::State>` first, then construct `RTLIL::Const` from it. I have modified the `util_verilogbackend.h` to have all of these updates.

8. **(solved)** `FfData` struct has been changed in newer yosys versions. We should look into `/home/$USER/tabby/share/yosys/include/kernel/ff.h` and find eqivalences of `has_d`, `has_en`, `pol_en`, `sig_en` and possibly more. The `util_verilogbackend.h` file should be modified based on this renaming that occured in new yosys versions.

9. For naming consistency, in newer versions of Yosys `_en` has changed to `_ce` (clock enabled) so I did replace all `has_en`s with `has_ce`, all `pol_en`s with `pol_ce` and `sig_en`s with `sig_ce` thus resolving the issue. Moreover, `has_d` was redundant and it is completely removed from yosys. Because `sig_d` being present already implies it has a sync data input. So I replaced `has_d`s with `sig_d.is_fully_const()` to imply the same thing.

10. Replaced `cell->hash()` with `run_hash(cell->name.str())` for correct modern implementation in `cdfg.h` file to fix many errors.

11. I rewrote `mkhash` fixes to solve another four implementation errors. Changes are apparent in `util.h` and `dataflow.h`.

12. **(FIX)**`make init` now works perfectly fine and we can generate `main.so` file in the `build` directory successfully.

13. Many changes to `intra_hbi.py` and `RUN_JG.sh`. To fix some deprecated features of `pandas` and make jaspergold compatible with Ubuntu 22.04.

14. Modified the makefiles a bit to be more general and avoid unnecessary copy and paste.

15. Modified `inter_hbi.py` as well to fix deprecated `.apprend()` in pandas.
