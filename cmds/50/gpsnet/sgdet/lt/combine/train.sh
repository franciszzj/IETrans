export SG=$(pwd)
export EXP=$SG/work_dirs

OUTPATH=$EXP/50/gpsnet/sgdet/lt/combine/combine
mkdir -p $OUTPATH
cp $EXP/50/gpsnet/predcls/lt/combine/relabel/em_E.pk $OUTPATH/em_E.pk

python tools/relation_train_net.py \
  --config-file "configs/wsup-50.yaml" \
  DATASETS.TRAIN \(\"50DS_VG_VGKB_train\",\) \
  MODEL.ROI_RELATION_HEAD.USE_GT_BOX False \
  MODEL.ROI_RELATION_HEAD.USE_GT_OBJECT_LABEL False \
  MODEL.ROI_RELATION_HEAD.PREDICTOR GPSNetPredictor \
  SOLVER.IMS_PER_BATCH 12 \
  TEST.IMS_PER_BATCH 1 \
  DTYPE "float32" \
  SOLVER.MAX_ITER 50000 \
  SOLVER.VAL_PERIOD 2000 \
  SOLVER.CHECKPOINT_PERIOD 2000 \
  GLOVE_DIR $SG/datasets/glove \
  MODEL.PRETRAINED_DETECTOR_CKPT $SG/datasets/vg/pretrained_faster_rcnn/model_final.pth \
  OUTPUT_DIR $OUTPATH \
  MODEL.ROI_RELATION_HEAD.NUM_CLASSES 51 \
  SOLVER.PRE_VAL False \
  MODEL.ROI_RELATION_HEAD.PREDICT_USE_BIAS True \
  TEST.INFERENCE "SOFTMAX" \
  IETRANS.RWT False \
  WSUPERVISE.LOSS_TYPE ce \
  WSUPERVISE.DATASET InTransDataset \
  WSUPERVISE.SPECIFIED_DATA_FILE $OUTPATH/em_E.pk
