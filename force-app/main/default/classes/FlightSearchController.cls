public with sharing class FlightSearchController {
  @AuraEnabled(cacheable=true)
      public static List<AirLine__c> searchFlight(String departureAirport, 
      String arrivalAirport, Date departureDate){
          return[select Name, City_From__c, City_To__c,Departure_Date__c, Price__c from AirLine__c
          where City_From__c =: departureAirport and City_To__c =: arrivalAirport and 
          Departure_Date__c =: departureDate];
  }
  @AuraEnabled
  public static void createBooking(Id flightId, String Name, String Email, String Phone,
  String departureAirport, String arrivalAirport, Date departureDate, Decimal Price){
      Booking__c newBooking = new Booking__c();
      newBooking.AirLine_Name__c = flightId;
      newBooking.Name = Name;
      newBooking.Email__c = Email;
      newBooking.Phone_No__c = Phone;
      newBooking.City_From__c = departureAirport;
      newBooking.City_To__c = arrivalAirport;
      newBooking.Departure_Date__c = departureDate;
      newBooking.Price__c = Price;

      try {
          insert newBooking;
          System.debug('Booking record created successfully '+ newBooking.Id);
      } catch (Exception e) {
          System.debug('Error creating booking record'+ e.getMessage());
      }
  }
}