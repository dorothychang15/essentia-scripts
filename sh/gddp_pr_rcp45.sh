#!/bin/bash
# uses objcnv to process GDDP climate projections for precipitation based on rcp4.5

echo "set cluster to local"
ess cluster set local
echo "select a s3 repository"
ess select s3://nasanex --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
echo "create category gddp_pr_rcp45"
ess category add gddp_pr_rcp45 "NEX-GDDP/BCSD/rcp45/day/atmos/pr/r1i1p1/v1.0/*.json" --delimiter=',' --dateformat=auto --preprocess="jsncnv -f,eok - -d s:datetime:creation_date s:tracking_id:tracking_id" --overwrite
echo "show category summary"
ess summary gddp_pr_rcp45
echo "display first 5 lines"
ess stream gddp_pr_rcp45 '*' '*' | head -5
