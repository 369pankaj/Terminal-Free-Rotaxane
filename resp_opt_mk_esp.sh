#!/bin/bash
#PBS -N axleoptresp
#PBS -l nodes=1:ppn=64
#PBS -o list.log
#PBS -q hmqueue

cd $PBS_O_WORKDIR
module load gaussian/16


g16 < ../../inputs/axle_opt.gjf > axle_opt.log
g16 < ../../inputs/axle_esp.gjf > axle_esp.log

export PATH=/apps/codes/miniforge3/envs/ambertools24/bin:$PATH

# 1 produce GAFF mol2 with RESP Charges 
antechamber -i axle_esp.log -fi gout -o axle_resp.mol2 -fo mol2 -c resp -rn AXL -at gaff -nc 4

# 2 check missing params
parmchk2 -i axle_resp.mol2 -f mol2 -o axle.frcmod

# 3: run tleap
tleap -f tleap.in

# 4: convert to gmx format
acpype -p axle_resp.prmtop -x axle_resp.inpcrd -o gmx
