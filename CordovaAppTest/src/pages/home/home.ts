import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';

declare var NavitiaSDKUX: any;

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {
  config;

  constructor(public navCtrl: NavController) {
      this.config = {
          token: '9e304161-bb97-4210-b13d-c71eaf58961c',
      };


  }

  launchJourney(ev) {
      NavitiaSDKUX.init(this.config, function() {}, function(error) {
          console.log(error);
      });

      var journeyParams = {
          originLabel: 'My Home',
          originId: '2.3665844;48.8465337',
          destinationId: '2.2979169;48.8848719',
      };

      NavitiaSDKUX.invokeJourneyResults(journeyParams, function() {}, function(error) {
          console.log(error);
      });
  }
}
