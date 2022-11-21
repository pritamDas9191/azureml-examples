pipeline=$1
folder=$2

SCRIPT_PATH="${BASH_SOURCE[0]:-$0}"
SCRIPT_DIR="$( cd "$( dirname "${SCRIPT_PATH}" )" && pwd )"

cp $pipeline.yml ${pipeline}-registry-components.yml
sed -i -r "s/component:.+\/(.+).yml|azureml:(.+)@latest/component: azureml:\/\/registries\/$REGISTRY_NAME\/components\/\1\2_$folder\/versions\/1/g" ${pipeline}-registry-components.yml
cat ${pipeline}-registry-components.yml

bash $SCRIPT_DIR/run-job.sh ${pipeline}-registry-components.yml
