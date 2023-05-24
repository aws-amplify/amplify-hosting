#!/usr/bin/env bash
set -e
IFS='|'

help_output () {
    echo "usage: $(basename "$0") <--environment|-e <name>> <--simple|-s>"
    echo "  --environment  The name of the Amplify environment to use"
    echo "  --simple  Optional simple flag auto-includes stack info from env cache"
    exit 1
}

init_env () {
    ENV=$1
    AMPLIFY=$2
    PROVIDERS=$3
    CODEGEN=$4
    AWSCONFIG=$5
    CATEGORIES=$6

    echo "# Start initializing Amplify environment: ${ENV}"
    if [[ -z ${STACKINFO} ]];
    then
        echo "# Initializing new Amplify environment: ${ENV} (amplify init)"
        if [[ -z ${CATEGORIES} ]]; then amplify init --amplify "${AMPLIFY}" --providers "${PROVIDERS}" --codegen "${CODEGEN}" --yes --forcePush; else amplify init --amplify "${AMPLIFY}" --providers "${PROVIDERS}" --codegen "${CODEGEN}" --categories "${CATEGORIES}" --yes --forcePush; fi
        echo "# Environment ${ENV} details:"
        amplify env get --name "${ENV}"
    else
        echo "STACKINFO=${STACKINFO}"
        echo "# Importing Amplify environment: ${ENV} (amplify env import)"
        amplify env import --name "${ENV}" --config "${STACKINFO}" --awsInfo "${AWSCONFIG}" --yes;
        echo "# Initializing existing Amplify environment: ${ENV} (amplify init)"
        if [[ -z ${CATEGORIES} ]]; then amplify init --amplify "${AMPLIFY}" --providers "${PROVIDERS}" --codegen "${CODEGEN}" --yes --forcePush; else amplify init --amplify "${AMPLIFY}" --providers "${PROVIDERS}" --codegen "${CODEGEN}" --categories "${CATEGORIES}" --yes --forcePush; fi
        echo "# Environment ${ENV} details:"
        amplify env get --name "${ENV}"
    fi
    echo "# Done initializing Amplify environment: ${ENV}"
}

ENV=""
IS_SIMPLE=false
POSITIONAL=()
while [[ $# -gt 0 ]];
    do
    key="$1"
    case ${key} in
        -e|--environment)
        ENV=$2
        shift
        ;;
        -r|--region)
        REGION=$2
        shift
        ;;
        -s|--simple)
        IS_SIMPLE=true
        shift
        ;;
        *)
        POSITIONAL+=("$1")
        shift
        ;;
    esac
done
set -- "${POSITIONAL[@]}"

# if no provided environment name, use default env variable, then user override
if [[ ${ENV} = "" ]];
then
    ENV=${AWS_BRANCH}
fi

if [[ ${USER_BRANCH} != "" ]];
then
    ENV=${USER_BRANCH}
fi

# strip slashes and dashes, limit to 10 chars
ENV=$(echo "${ENV}" | sed 's;\\;;g ; s;\/;;g ; s;-;;g' | cut -c -10)

# Check valid environment name
if [[ -z ${ENV} || "${ENV}" =~ [^a-zA-Z0-9]+ ]] ; then help_output ; fi

read -r -d 'END' AWSCONFIG << EOM
{
  "configLevel":"project",
  "useProfile":true,
  "profileName":"default",
  "AmplifyAppId":"${AWS_APP_ID}"
}END
EOM
read -r -d 'END' AMPLIFY << EOM
{
  "envName":"${ENV}",
  "appId":"${AWS_APP_ID}"
}END
EOM
read -r -d 'END' PROVIDERS << EOM
{
  "awscloudformation":${AWSCONFIG}
}END
EOM
read -r -d 'END' CODEGEN << EOM
{
  "generateCode":false,
  "generateDocs":false
}END
EOM
CATEGORIES=""
if [[ -z ${AMPLIFY_FACEBOOK_CLIENT_ID} && -z ${AMPLIFY_GOOGLE_CLIENT_ID} && -z ${AMPLIFY_AMAZON_CLIENT_ID} ]]; then
    CATEGORIES=""
else
    read -r -d 'END' AUTHCONFIG << EOM
{
  "facebookAppIdUserPool":"${AMPLIFY_FACEBOOK_CLIENT_ID}",
  "facebookAppSecretUserPool":"${AMPLIFY_FACEBOOK_CLIENT_SECRET}",
  "googleAppIdUserPool":"${AMPLIFY_GOOGLE_CLIENT_ID}",
  "googleAppSecretUserPool":"${AMPLIFY_GOOGLE_CLIENT_SECRET}",
  "amazonAppIdUserPool":"${AMPLIFY_AMAZON_CLIENT_ID}",
  "amazonAppSecretUserPool":"${AMPLIFY_AMAZON_CLIENT_SECRET}"
}END
EOM
    read -r -d 'END' CATEGORIES << EOM
{
  "auth":$AUTHCONFIG
}END
EOM
fi
# Handle old or new config file based on simple flag
if [[ ${IS_SIMPLE} ]];
then
    echo "# Getting Amplify CLI Cloud-Formation stack info from environment cache"
    STACKINFO="$(envCache --get stackinfo)"
    export STACKINFO
    init_env "${ENV}" "${AMPLIFY}" "${PROVIDERS}" "${CODEGEN}" "${AWSCONFIG}" "${CATEGORIES}"
    echo "# Store Amplify CLI Cloud-Formation stack info in environment cache"
    STACKINFO="$(amplify env get --json --name "${ENV}")"
    envCache --set stackinfo "${STACKINFO}"
    echo "STACKINFO=${STACKINFO}"
else
    # old config file, above steps performed outside of this script
    init_env "${ENV}" "${AMPLIFY}" "${PROVIDERS}" "${CODEGEN}" "${AWSCONFIG}" "${CATEGORIES}"
fi
