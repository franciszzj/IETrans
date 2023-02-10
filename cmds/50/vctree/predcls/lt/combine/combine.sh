export SG=$(pwd)
export EXP=$SG/work_dirs

OUTPATH=$EXP/50/vctree/predcls/lt/combine/relabel
mkdir -p $OUTPATH
cd $OUTPATH
cp $SG/tools/ietrans/combine.py ./
python combine.py vctree
