export SG=$(pwd)
export EXP=$SG/work_dirs

OUTPATH=$EXP/50/transformer/predcls/sup/sup
mkdir -p $OUTPATH

python tools/relation_train_net.py \
  --config-file "configs/sup-50.yaml" \
  MODEL.ROI_RELATION_HEAD.USE_GT_BOX True \
  MODEL.ROI_RELATION_HEAD.USE_GT_OBJECT_LABEL True \
  MODEL.ROI_RELATION_HEAD.PREDICTOR TransformerPredictor \
  SOLVER.PRE_VAL False \
  SOLVER.SCHEDULE.TYPE WarmupMultiStepLR \
  SOLVER.IMS_PER_BATCH 16 \
  TEST.IMS_PER_BATCH 1 \
  DTYPE "float16" \
  SOLVER.MAX_ITER 16000 \
  SOLVER.VAL_PERIOD 2000 \
  SOLVER.CHECKPOINT_PERIOD 2000 \
  GLOVE_DIR $SG/datasets/glove \
  MODEL.PRETRAINED_DETECTOR_CKPT $SG/datasets/vg/pretrained_faster_rcnn/model_final.pth \
  OUTPUT_DIR $OUTPATH \
  SOLVER.BASE_LR 0.005 \
  TEST.METRIC "R"


