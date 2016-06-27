#!/bin/bash
# measures value by commodity type

ess server reset
ess create database commodity --ports=1
ess create vector vector1 s,pkey:commodity_type i,+add:ctotal
ess server commit
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add commodity 'USTransportation/common/"Commodity Flow Survey"/*1997*' --exclude 'USTransportation/common/"Commodity Flow Survey"/CFS*' --dateregex=Y --preprocess='aq_pp -f,+1,csv,eok,qui - -d x: s:commodity_type s:transport_mode i:value -filt "value>0" -eval i:ctotal value -udb_imp commodity:vector1' --overwrite
ess summary commodity
aq_udb -exp commodity:vector1 -sort ctotal -dec > commodity_ctotal.csv
