#!/bin/bash

# vars | anisble template
export ORACLE_HOME="{{ oracle_home }}"
export STAGE="{{ target_stage_path }}"
export PATCH="p{{ apply_opatch.number }}*{{ apply_opatch.mos_regexp }}*"

# header
echo "OPatch update utility:"
echo "----------------------"
echo "Oracle home: $ORACLE_HOME"
echo "Executing: ${date}"
echo ""

# tasks
cd $ORACLE_HOME
echo "Current Opatch version:"
date; OPatch/opatch version

echo "Backup existing OPatch"
zip -qr OPatch_$(date "+%Y%m%d_%H%M%S").zip OPatch
ls -l OPatch_$(date "+%Y%m%d")*.zip


echo "Extracting OPatch from patch ${STAGE}/${PATCH}"
rm -Rf OPatch
unzip -qo ${STAGE}/${PATCH}
date; OPatch/opatch version