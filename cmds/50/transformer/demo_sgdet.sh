export SG=$(pwd)
export EXP=$SG/work_dirs

OUTPATH=./visualization/demo
mkdir -p $OUTPATH

python tools/demo.py \
  --config-file "configs/sup-50.yaml" \
  MODEL.ROI_RELATION_HEAD.USE_GT_BOX False \
  MODEL.ROI_RELATION_HEAD.USE_GT_OBJECT_LABEL False \
  MODEL.ROI_RELATION_HEAD.PREDICTOR TransformerPredictor \
  SOLVER.PRE_VAL False \
  MODEL.ROI_RELATION_HEAD.PREDICT_USE_BIAS True \
  SOLVER.IMS_PER_BATCH 8 \
  TEST.IMS_PER_BATCH 1 \
  DTYPE "float16" \
  SOLVER.MAX_ITER 40000 \
  SOLVER.VAL_PERIOD 2000 \
  SOLVER.CHECKPOINT_PERIOD 2000 \
  GLOVE_DIR $SG/datasets/glove \
  MODEL.PRETRAINED_DETECTOR_CKPT $SG/datasets/vg/pretrained_faster_rcnn/model_final.pth \
  OUTPUT_DIR $OUTPATH \
  TEST.METRIC "R" \
  TEST.CUSTUM_EVAL True \
  TEST.CUSTUM_PATH $1 \
  DETECTED_SGG_DIR $OUTPATH
