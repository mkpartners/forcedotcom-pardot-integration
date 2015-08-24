@isTest
public with sharing class Pardot_Tests {
	
	static testmethod void Pardot_API_UnitTest() {

		Test.startTest();

		Contact c = new Contact( Email='test@test.test', LastName='test', FirstName='test' );
		insert c;
		List<Contact> contacts = new List<Contact> { c };

		Pardot_Settings__c setting_email = new Pardot_Settings__c( Name='email', Value__c='test' );
		Pardot_Settings__c setting_password = new Pardot_Settings__c( Name='password', Value__c='test' );
		Pardot_Settings__c setting_user_key = new Pardot_Settings__c( Name='user_key', Value__c='test' );

		insert setting_email;
		insert setting_password;
		insert setting_user_key;


		Pardot_API.afterInsert( contacts );
		Pardot_API.afterUpdate( contacts );

		Test.stopTest();
		
	}

}