#!/usr/bin/tcsh -f
#-------------------------------------------
# qflow exec script for project /home/afeld/git_clones/qflow-tutorial
#-------------------------------------------

# /usr/lib/qflow/scripts/synthesize.sh /home/afeld/git_clones/qflow-tutorial merger /home/afeld/git_clones/qflow-tutorial/source/merger.v || exit 1
# /usr/lib/qflow/scripts/placement.sh -d /home/afeld/git_clones/qflow-tutorial merger || exit 1
# /usr/lib/qflow/scripts/opensta.sh  /home/afeld/git_clones/qflow-tutorial merger || exit 1
# /usr/lib/qflow/scripts/vesta.sh -a /home/afeld/git_clones/qflow-tutorial merger || exit 1
# /usr/lib/qflow/scripts/router.sh /home/afeld/git_clones/qflow-tutorial merger || exit 1
# /usr/lib/qflow/scripts/opensta.sh  -d /home/afeld/git_clones/qflow-tutorial merger || exit 1
# /usr/lib/qflow/scripts/vesta.sh -a -d /home/afeld/git_clones/qflow-tutorial merger || exit 1
# /usr/lib/qflow/scripts/migrate.sh /home/afeld/git_clones/qflow-tutorial merger || exit 1
# /usr/lib/qflow/scripts/drc.sh /home/afeld/git_clones/qflow-tutorial merger || exit 1
/usr/lib/qflow/scripts/lvs.sh /home/afeld/git_clones/qflow-tutorial merger || exit 1
# /usr/lib/qflow/scripts/gdsii.sh /home/afeld/git_clones/qflow-tutorial merger || exit 1
# /usr/lib/qflow/scripts/cleanup.sh /home/afeld/git_clones/qflow-tutorial merger || exit 1
# /usr/lib/qflow/scripts/display.sh /home/afeld/git_clones/qflow-tutorial merger || exit 1
