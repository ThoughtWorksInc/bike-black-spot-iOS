# BikeBlackspot app

## Ship.io build status
<a href='https://app.ship.io/dashboard#/jobs/8929/history' target='_blank'><img src='https://app.ship.io/jobs/Y2bPZLCgeFCln1Uh/build_status.png' style='width:160px' /></a>

Ship.io was chosen for the build pipeline due to its integration with HockeyApp and Slack and because it works with iOS. 

##Setup
You will need to setup your xcode to have your apple developer account.

run: gem install cocoapods

You will need a Google Maps API key https://developers.google.com/maps/documentation/ios/start?hl=en
Put this key in the AppDelegate class where the comment indicates.

##Adding new pods
1. Add to podfile
2. run: pod install

##Running tests
CMD + u

## Sensitive information
The file for storing sensitive information (passwords etc) is secrets.yml and is located in the repository for the web app called "bike-black-spot". 
