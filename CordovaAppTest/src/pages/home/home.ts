import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';

declare var NavitiaSDKUX: any;

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  constructor(public navCtrl: NavController) {
      var config = {
          token: '9e304161-bb97-4210-b13d-c71eaf58961c',
      };

      NavitiaSDKUX.init(config, function() {}, function(error) {
          console.log(error);
      });

      var journeyParams = {
          initOrigin: 'My Home',
          initOriginId: '2.3665844;48.8465337',
          initDestinationId: '2.2979169;48.8848719',
      };

      NavitiaSDKUX.invokeJourneyResults(journeyParams, function() {}, function(error) {
          console.log(error);
      });
  }

}
