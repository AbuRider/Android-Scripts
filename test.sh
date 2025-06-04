#!/bin/bash
git clone https://github.com/ProjectMatrixx/android_vendor_lineage-priv_keys-template.git -b master vendor/lineage-priv/keys
cd vendor/lineage-priv/keys
./generate.sh
