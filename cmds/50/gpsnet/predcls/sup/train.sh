export SG=$(pwd)
export EXP=$SG/work_dirs

OUTPATH=$EXP/50/gpsnet/predcls/sup/sup
mkdir -p $OUTPATH

python tools/relation_train_net.py \
  --config-file "configs/sup-50.yaml" \
  MODEL.ROI_RELATION_HEAD.USE_GT_BOX True \
  MODEL.ROI_RELATION_HEAD.USE_GT_OBJECT_LABEL True \
  MODEL.ROI_RELATION_HEAD.PREDICTOR GPSNetPredictor \
  SOLVER.PRE_VAL False \
  SOLVER.IMS_PER_BATCH 12 \
  TEST.IMS_PER_BATCH 1 \
  DTYPE "float16" \
  SOLVER.MAX_ITER 50000 \
  SOLVER.VAL_PERIOD 2000 \
  SOLVER.CHECKPOINT_PERIOD 2000 \
  GLOVE_DIR $SG/datasets/glove \
  MODEL.PRETRAINED_DETECTOR_CKPT $SG/datasets/vg/pretrained_faster_rcnn/model_final.pth \
  OUTPUT_DIR $OUTPATH \
  TEST.METRIC "R"
