#!/usr/bin/env bash


sub=$1
ses=$2
wdr=${3:-/data}

nTE=${4:-5}

### Main ###
cwd=$( pwd )

cd ${wdr}

echo "Denoising sub ${sub} ses ${ses} optcom"
fdir=sub-${sub}/ses-${ses}/func_preproc

func=${fdir}/00.sub-${sub}_ses-${ses}_task-breathhold_optcom_bold_native_preprocessed
bold=sub-${sub}_ses-${ses}_task-breathhold_meica_bold

fsl_regfilt -i ${func} \
-d ${fdir}/sub-${sub}_ses-${ses}_task-breathhold_echo-1_bold_RPI_bet_meica/meica_mix.1D \
-f "$( cat sub-${sub}_ses-${ses}_rejected.1D )" \
-o ${fdir}/${bold}_bet
# fsl_regfilt -i ${func} \
# -d ${fdir}/sub-${sub}_ses-${ses}_task-breathhold_echo-1_bold_RPI_bet_meica/meica_mix.1D \
# -f "$( cat sub-${sub}_ses-${ses}_vascular.1D )" \
# -o ${fdir}/${bold}_bet_vascular
# fsl_regfilt -i ${func} \
# -d ${fdir}/sub-${sub}_ses-${ses}_task-breathhold_echo-1_bold_RPI_bet_meica/meica_mix.1D \
# -f "$( cat sub-${sub}_ses-${ses}_networks.1D )" \
# -o ${fdir}/${bold}_bet_network

${cwd}/11.func_spc.sh ${bold}_bet ${fdir}

immv ${fdir}/${bold}_bet ${fdir}/00.${bold}_native_preprocessed
immv ${fdir}/${bold}_bet_SPC ${fdir}/01.${bold}_native_SPC_preprocessed


for e in $( seq 1 ${nTE} )
do
	echo "Denoising sub ${sub} ses ${ses} echo ${e}"
	func=${fdir}/00.sub-${sub}_ses-${ses}_task-breathhold_echo-${e}_bold_native_preprocessed
	bold=sub-${sub}_ses-${ses}_task-breathhold_meica_echo-${e}_bold

	fsl_regfilt -i ${func} \
	-d ${fdir}/sub-${sub}_ses-${ses}_task-breathhold_echo-${e}_bold_RPI_bet_meica/meica_mix.1D \
	-f "$( cat sub-${sub}_ses-${ses}_rejected.1D )" \
	-o ${fdir}/${bold}_bet
	# fsl_regfilt -i ${func} \
	# -d ${fdir}/sub-${sub}_ses-${ses}_task-breathhold_echo-${e}_bold_RPI_bet_meica/meica_mix.1D \
	# -f "$( cat sub-${sub}_ses-${ses}_vascular.1D )" \
	# -o ${fdir}/${bold}_bet_vascular
	# fsl_regfilt -i ${func} \
	# -d ${fdir}/sub-${sub}_ses-${ses}_task-breathhold_echo-${e}_bold_RPI_bet_meica/meica_mix.1D \
	# -f "$( cat sub-${sub}_ses-${ses}_networks.1D )" \
	# -o ${fdir}/${bold}_bet_network

	${cwd}/11.func_spc.sh ${bold}_bet ${fdir}

	immv ${fdir}/${bold}_bet ${fdir}/04.${bold}_native_preprocessed
	immv ${fdir}/${bold}_bet_SPC ${fdir}/05.${bold}_native_SPC_preprocessed
done

cd ${cwd}