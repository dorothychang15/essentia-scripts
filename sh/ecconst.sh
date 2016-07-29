#!/bin/sh
# processes labor data

ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add ecconst 'LaborStats/suppl/ECI.ECCONST.TXT' --dateregex='[:%Y:]' --overwrite
ess summary ecconst
#ess cat 'LaborStats/suppl/ECI.ECCONST.TXT' | head -114
ess stream ecconst '*' '*' 'aq_pp -f,+114,eok,qui - -d i,trm:year sep:"................................." s,trm:march sep:"    " s,trm:june sep:"   " s,trm:sept sep:"   " s,trm:dec sep:"    " s,trm:march3 sep:"    " s,trm:june3 sep:"    " s,trm:sept3 sep:"    " s,trm:dec3 sep:"   " s,trm:march12 sep:"    " s,trm:june12 sep:"    " s,trm:sept12 sep:"    " s,trm:dec12' > ecconst.csv
