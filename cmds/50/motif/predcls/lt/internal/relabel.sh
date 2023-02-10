export SG=$(pwd)
export EXP=$SG/work_dirs

OUTPATH=$EXP/50/motif/predcls/lt/internal/relabel
mkdir -p $OUTPATH
cp $EXP/50/motif/predcls/sup/sup/last_checkpoint $OUTPATH/last_checkpoint

python tools/internal_relabel.py \
  --config-file "configs/wsup-50.yaml"  \
  DATASETS.TRAIN \(\"50DS_VG_VGKB_train\",\) \
  MODEL.ROI_RELATION_HEAD.USE_GT_BOX True \
  MODEL.ROI_RELATION_HEAD.USE_GT_OBJECT_LABEL True \
  MODEL.ROI_RELATION_HEAD.PREDICTOR MotifPredictor \
  SOLVER.IMS_PER_BATCH 12 \
  TEST.IMS_PER_BATCH 1 \
  DTYPE "float16" \
  SOLVER.MAX_ITER 50000 \
  SOLVER.VAL_PERIOD 2000 \
  SOLVER.CHECKPOINT_PERIOD 2000 \
  GLOVE_DIR $SG/datasets/glove \
  MODEL.PRETRAINED_DETECTOR_CKPT $SG/datasets/vg/pretrained_faster_rcnn/model_final.pth \
  OUTPUT_DIR $OUTPATH  \
  MODEL.ROI_RELATION_HEAD.NUM_CLASSES 51 \
  SOLVER.PRE_VAL False \
  MODEL.ROI_RELATION_HEAD.PREDICT_USE_BIAS True \
  WSUPERVISE.DATASET InTransDataset \
  EM.MODE E \
  WSUPERVISE.SPECIFIED_DATA_FILE datasets/vg/50/vg_sup_data.pk


cd $OUTPATH
cp $SG/tools/ietrans/internal_cut.py ./
cp $SG/datasets/vg/50/VG-SGG-dicts-with-attri.json ./
python internal_cut.py 0.7