export SG=$(pwd)
export EXP=$SG/work_dirs

OUTPATH=$EXP/50/vctree/predcls/sup/sup

python tools/relation_test_net.py \
  --config-file "configs/sup-50.yaml" \
  MODEL.ROI_RELATION_HEAD.USE_GT_BOX True \
  MODEL.ROI_RELATION_HEAD.USE_GT_OBJECT_LABEL True \
  MODEL.ROI_RELATION_HEAD.PREDICTOR VCTreePredictor \
  TEST.IMS_PER_BATCH 1 \
  DTYPE "float32" \
  GLOVE_DIR $SG/datasets/glove \
  MODEL.PRETRAINED_DETECTOR_CKPT $OUTPATH \
  OUTPUT_DIR $OUTPATH
