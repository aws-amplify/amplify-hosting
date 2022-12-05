### Scripts

**DEPRECATED-amplifyPush.sh:** A deprecated helper script that runs the Amplify CLI during the backend deployment phase of the build. Amplify Hosting used to run the `amplifyPush.sh` build script in the build container, but now manages full-stack deployments. You have two options:
1. Automated - Let Amplify Hosting manage your fullstack deployments (Recommended). In order to maintain backwards compatibility, we will look for `amplifyPush --simple` in your [amplify.yml](https://docs.aws.amazon.com/amplify/latest/userguide/build-settings.html#frontend-with-backend) and use that as an indicator that you want us to manage your backend builds. Please note: we are not running the old amplifyPush.sh script anymore. 
2. Manual - Run Amplify CLI headlessly yourself. To manually run the Amplify CLI in headless mode, please refer to the [documentation](https://docs.amplify.aws/cli/usage/headless/).
