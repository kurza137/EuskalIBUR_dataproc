#$ -S /bin/bash
#$ -cwd
#$ -m be
#$ -M s.moia@bcbl.eu

module load singularity/3.3.0

##########################################################################################################################
##---START OF SCRIPT----------------------------------------------------------------------------------------------------##
##########################################################################################################################

date

task=$1

wdir=/bcbl/home/public/PJMASK_2/preproc
scriptdir=/bcbl/home/public/PJMASK_2/EuskalIBUR_dataproc

cd ${scriptdir}

logname=falff_${sub}_${ses}_pipe

# Preparing log folder and log file, removing the previous one
if [[ ! -d "${wdir}/log" ]]; then mkdir ${wdir}/log; fi
if [[ -e "${wdir}/log/${logname}" ]]; then rm ${wdir}/log/${logname}; fi

echo "************************************" >> ${wdir}/log/${logname}

exec 3>&1 4>&2

exec 1>${wdir}/log/${logname} 2>&1

date
echo "************************************"

singularity exec -e --no-home \
-B ${wdir}:/data -B ${scriptdir}:/scripts \
-B /export/home/smoia/scratch:/tmp \
euskalibur.sif 05.second_level_analysis/06.quick_correlation_Mennes.sh ${task}