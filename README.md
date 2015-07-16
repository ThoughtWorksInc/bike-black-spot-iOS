# BikeBlackspot app

## Ship.io build status
<a href='https://app.ship.io/dashboard#/jobs/8929/history' target='_blank'><img src='https://app.ship.io/jobs/Y2bPZLCgeFCln1Uh/build_status.png' style='width:160px' /></a>

Ship.io was chosen for the build pipeline due to its integration with HockeyApp and Slack and because it works with iOS. 
It has been set up with a developer certificate and a provisioning profile under Sarah Nelson's apple developer account, which allows the app to be tested on Sarah's iPhone 5 and Frenchie's iPhone 6. It should now deploy to HockeyApp automatically.

## Sensitive information
The file for storing sensitive information (passwords etc) is secrets.yml and is located in the repository for the web app called "bike-black-spot". 