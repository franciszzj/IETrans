export SG=$(pwd)
export EXP=$SG/work_dirs

OUTPATH=$EXP/50/motif/predcls/sup/sup # replace with your own directory

#cd $SG
python tools/relation_test_net.py \
  --config-file "configs/sup-50.yaml" \
  MODEL.ROI_RELATION_HEAD.USE_GT_BOX True \
  MODEL.ROI_RELATION_HEAD.USE_GT_OBJECT_LABEL True \
  MODEL.ROI_RELATION_HEAD.PREDICTOR MotifPredictor \
  TEST.IMS_PER_BATCH 1 \
  DTYPE "float16" \
  GLOVE_DIR $SG/datasets/glove \
  MODEL.PRETRAINED_DETECTOR_CKPT $OUTPATH \
  OUTPUT_DIR $OUTPATH
