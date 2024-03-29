#!/bin/bash

## DO NOT MODIFY
## COPYRIGHT 2023. SPITHA Inc. ALL RIGHTS RESERVED.
## ----------

## runtime env
set -e
umask 0002

echo ${!DATAGEN*} ${!TOPIC*} ${!PRODUCER*} ${!BOOTSTRAP*} | /config/gomplate -d config=stdin: -f /config/in/datagen.yaml.tmpl -o /config/datagen.yaml

## execute
umask 0755 && exec /app/datagen -config=/config/datagen.yaml
## ----------
## END OF FILE
