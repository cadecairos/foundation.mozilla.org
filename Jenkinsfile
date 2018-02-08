pipeline {

    agent any

    parameters {
        string(name: 'DEPLOY_TO', defaultValue: 'dev', description: 'Environment to deploy to')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-terraform-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-terraform-secret-access-key')
        HEROKU_API_KEY        = credentials('terraform-heroku-api-key')

        S3_BUCKET = 'bucket=mofo-terraform'
        S3_REGION = 'region=us-east-1'

        DEV_APP_CONFIG_FILE        = 'dev.tfvars'
        STAGING_APP_CONFIG_FILE    = 'staging.tfvars'
        PRODUCTION_APP_CONFIG_FILE = 'dev.tfvars'

        DEV_INFRA_CONFIG_FILE        = 'dev.infrastructure.tfvars'
        STAGING_INFRA_CONFIG_FILE    = 'staging.infrastructure.tfvars'
        PRODUCTION_INFRA_CONFIG_FILE = 'dev.infrastructure.tfvars'

        DEV_RESOURCE        = 'foundation/dev'
        STAGING_RESOURCE    = 'foundation/staging'
        PRODUCTION_RESOURCE = 'foundation/production'

        DEV_STATE_KEY        = 'key=foundation-mozilla-org/dev.tfstate'
        STAGING_STATE_KEY    = 'key=foundation-mozilla-org/staging.tfstate'
        PRODUCTION_STATE_KEY = 'key=foundation-mozilla-org/production.tfstate'

        DEV_PLAN        = 'dev.tfplan'
        STAGING_PLAN    = 'staging.tfplan'
        PRODUCTION_PLAN = 'production.tfplan'

        DEV_DEPLOY_URL        = "https://git.heroku.com/foundation-mofodev-net.git"
        STAGING_DEPLOY_URL    = "https://git.heroku.com/foundation-mofostaging-net.git"
        PRODUCTION_DEPLOY_URL = "https://git.heroku.com/foundation-mozilla-org.git"

        HEROKU_DEPLOY_CREDENTIALS = 'heroku-deploy-key'
    }

    stages {
        stage('Init') {
            when {
                branch 'terraform'
            }
            steps {
                echo 'running init....'
                sh '''
                   cd ops
                   terraform init -input=false
                   '''
            }
        }

        stage('Plan - dev') {
            when {
                branch 'terraform'
                environment name: 'DEPLOY_TO', value: 'dev'
            }

            steps {
                echo 'planning dev...'
                s3Download file: $DEV_APP_CONFIG_FILE, bucket: $S3_BUCKET, path: $PROJECT_S3_PATH, force: true
                s3Download file: $DEV_INFRA_CONFIG_FILE, bucket: $S3_BUCKET, path: $PROJECT_S3_PATH, force: true
                sh '''
                   cd ops
                   terraform remote config -backend=S3 -backend-config='$S3_BUCKET' -backend-config='$DEV_STATE_KEY' -backend-config='$S3_REGION'
                   terraform plan \
                       --resource='$DEV_RESOURCE' \
                       -out='$DEV_PLAN' \
                       -var-file='$DEV_APP_CONFIG_FILE' \
                       -var-file='$DEV_INFRA_CONFIG_FILE' \
                       -var='heroku_api_key=$HEROKU_API_KEY' \
                       -input=false
                   '''
            }
        }

        stage('Deploy - Dev') {
            when {
                branch 'terraform'
                environment name: 'DEPLOY_TO', value: 'dev'
            }

            steps {
                echo 'Deploying Dev...'
                sh '''
                   cd ops
                   terraform remote config -backend=S3 -backend-config='$S3_BUCKET' -backend-config='$STAGING_STATE_KEY' -backend-config='$S3_REGION'
                   terraform apply -lock=false -input=false $STAGING_PLAN
                   '''
                gitPublisher branchesToPush: [[branchName: 'master']], credentialsId: '$HEROKU_DEPLOY_CREDENTIALS', url: '$DEV_DEPLOY_URL'
            }
        }

        stage('Plan - Staging') {
            when {
                branch 'terraform'
                environment name: 'DEPLOY_TO', value: 'staging'
            }

            steps {
                echo 'planning staging...'
                s3Download file: $STAGING_APP_CONFIG_FILE, bucket: $S3_BUCKET, path: $PROJECT_S3_PATH, force: true
                s3Download file: $STAGING_INFRA_CONFIG_FILE, bucket: $S3_BUCKET, path: $PROJECT_S3_PATH, force: true
                sh '''
                   cd ops
                   terraform remote config -backend=S3 -backend-config='$S3_BUCKET' -backend-config='$STAGING_STATE_KEY' -backend-config='$S3_REGION'
                   terraform plan \
                       --resource='$DEV_RESOURCE' \
                       -out='$STAGING_PLAN' \
                       -var-file='$STAGING_APP_CONFIG_FILE' \
                       -var-file='$STAGING_INFRA_CONFIG_FILE' \
                       -var='heroku_api_key=$HEROKU_API_KEY' \
                       -input=false
                   '''
            }
        }

        stage('Deploy - Staging') {
            when {
                branch 'terraform'
                environment name: 'DEPLOY_TO', value: 'staging'
            }

            steps {
                echo 'Deploying...'
                sh '''
                   cd ops
                   terraform remote config -backend=S3 -backend-config='$S3_BUCKET' -backend-config='$STAGING_STATE_KEY' -backend-config='$S3_REGION'
                   terraform apply -lock=false -input=false $STAGING_PLAN
                   '''
                gitPublisher branchesToPush: [[branchName: 'master']], credentialsId: '$HEROKU_DEPLOY_CREDENTIALS', url: '$STAGING_DEPLOY_URL'
            }
        }

        stage('Promote to Production') {
            when {
                branch 'terraform'
                environment name: 'DEPLOY_TO', value: 'staging'
            }
            steps {
                input 'Promote Staging to Production?'
                submitter 'foundation-deploy'
                ok '#ShipIt'
            }
        }

        stage('plan - production') {
            when {
                branch 'terraform'
                environment name: 'DEPLOY_TO', value: 'staging'
            }

            steps {
                echo 'planning production...'
                s3Download file: $PRODUCTION_APP_CONFIG_FILE, bucket: $S3_BUCKET, path: $PROJECT_S3_PATH, force: true
                s3Download file: $PRODUCTION_INFRA_CONFIG_FILE, bucket: $S3_BUCKET, path: $PROJECT_S3_PATH, force: true
                sh '''
                   cd ops
                   terraform remote config -backend=S3 -backend-config='$S3_BUCKET' -backend-config='$PRODUCTION_STATE_KEY' -backend-config='$S3_REGION'
                   terraform plan \
                       --resource='$DEV_RESOURCE' \
                       -out='$PRODUCTION_PLAN' \
                       -var-file='$PRODUCTION_APP_CONFIG_FILE' \
                       -var-file='$PRODUCTION_INFRA_CONFIG_FILE' \
                       -var='heroku_api_key=$HEROKU_API_KEY' \
                       -input=false
                   '''
            }
        }

        stage('Deploy - Production') {
            when {
                branch 'terraform'
                environment name: 'DEPLOY_TO', value: 'staging'
            }

            steps {
                echo 'Deploying production....'
                sh '''
                   cd ops
                   terraform remote config -backend=S3 -backend-config='$S3_BUCKET' -backend-config='$PRODUCTION_STATE_KEY' -backend-config='$S3_REGION'
                   terraform apply -lock=false -input=false $PRODUCTION_PLAN
                   '''
                gitPublisher branchesToPush: [[branchName: 'master']], credentialsId: '$HEROKU_DEPLOY_CREDENTIALS', url: '$PRODUCTION_DEPLOY_URL'
            }
        }
    }
}
