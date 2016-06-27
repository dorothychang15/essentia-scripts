#!/bin/bash
# organizes climate data: air temperature, converts data from C to F
# These data were obtained from the NASA Langley Research Center Atmospheric Science Data Center Surface meteorological and Solar Energy (SSE) web portal supported by the NASA LaRC POWER Project.

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add t10 "climate/NASA_SSE/NASA_SSE_CLIMATE_1983-2005/22yr_T10M.gz" --dateregex='[:%Y:]' --overwrite --noprobe --archive='*.csv'
echo "These data were obtained from the NASA Langley Research Center Atmospheric Science Data Center Surface meteorological and Solar Energy (SSE) web portal supported by the NASA LaRC POWER Project." > t10.csv
ess stream t10 '*' '*' 'aq_pp -f,+14,eok,qui - -d s:lat sep:" " s:lon sep:" " f:jan sep:" " f:feb sep:" " f:mar sep:" " f:apr sep:" " f:ma sep:" " f:jun sep:" " f:jul sep:" " f:aug sep:" " f:sep sep:" " f:oct sep:" " f:nov sep:" " f:dec sep:" " f:annual -eval f:January "jan*1.8+32" -eval f:February "feb*1.8+32" -eval f:March "mar*1.8+32" -eval f:April "apr*1.8+32" -eval f:May "ma*1.8+32" -eval f:June "jun*1.8+32" -eval f:July "jul*1.8+32" -eval f:August "aug*1.8+32" -eval f:September "sep*1.8+32" -eval f:October "oct*1.8+32" -eval f:November "nov*1.8+32" -eval f:December "dec*1.8+32" -o - -c lat lon January February March April May June July August September October November December' >> t10.csv
echo "Los Angeles" > t10cities.csv
ess query 'select * from t10:*:* where lat=="34" and lon=="118"' >> t10cities.csv
