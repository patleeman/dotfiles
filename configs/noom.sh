# AWSCLI SSO Login
function awslogin {
    ACCOUNT="dev-engineer"
    if [[ ! -z "$1"  ]]; then
        ACCOUNT=$1
    fi;

    echo "Logging into AWS via SSO and setting AWS_PROFILE=$ACCOUNT"
    echo "For more information see: https://github.com/noom/noom-aws-access/blob/master/cli/README.md"
    echo ""
    export AWS_PROFILE=$ACCOUNT
    aws sso login
}