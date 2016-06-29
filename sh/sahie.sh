#!/bin/bash
# extracts desired fields, trims "state" field data, selects category by filtering for geo, age, race, sex, ipr

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]]--aws_secret_access_key [[secret access key]]
ess category add sahie "USCensus/SAHIE_American_Community_Survey/*" --exclude "USCensus/SAHIE_American_Community_Survey/*_*" --delimiter=',' --dateregex='[:%Y:]' --overwrite 
ess stream sahie '*' '*' 'aq_pp -f,+4,eok,qui,csv - -d i@1:year i@3:geo i@4:age i@5:race i@6:sex i@7:ipr s,trm@8:state f@17:pctin -filt "geo==40" -filt "age==0 && race==0 && sex==0 && ipr==0" -o,notitle,noq - -c year state pctin' > sahie.csv
