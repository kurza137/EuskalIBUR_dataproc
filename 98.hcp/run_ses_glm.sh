#$ -S /bin/bash
#$ -cwd
#$ -m be
#$ -M s.moia@bcbl.eu

module load singularity/3.3.0

##########################################################################################################################
##---START OF SCRIPT----------------------------------------------------------------------------------------------------##
##########################################################################################################################

date

sub=$1
ses=$2

wdr=/bcbl/home/public/PJMASK_2/preproc
sdr=/bcbl/home/public/PJMASK_2/EuskalIBUR_dataproc

cd ${sdr}

logname=glm_${sub}_${ses}_pipe

# Preparing log folder and log file, removing the previous one
if [[ ! -d "${wdr}/log" ]]; then mkdir ${wdr}/log; fi
if [[ -e "${wdr}/log/${logname}" ]]; then rm ${wdr}/log/${logname}; fi

echo "************************************" >> ${wdr}/log/${logname}

exec 3>&1 4>&2

exec 1>${wdr}/log/${logname} 2>&1

date
echo "************************************"

for task in motor pinel simon
do
singularity exec -e --no-home \
-B ${wdr}:/data -B ${sdr}:/scripts \
-B /export/home/smoia/scratch:/tmp \
euskalibur.sif 04.first_level_analysis/08.run_task_glm.sh ${sub} ${ses} ${task} /data /tmp
done
