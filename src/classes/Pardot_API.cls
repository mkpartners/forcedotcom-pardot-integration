public with sharing class Pardot_API {

	//public static final String BASE_ENDPOINT = 'https://pi.pardot.com/api/';
	//public static final Integer INSERT_BATCH_SIZE = 25;
	//public static final Integer UPDATE_BATCH_SIZE = 25;
	//public static final String API_KEY_ERROR = 'err';

	//// Map for Contact fields : SFDC => Pardot
	//public static Map<String, String> fieldMap = new Map<String, String> {
	//		'Id' => 'Id' 
	//		,	'Salutation' => 'salutation' 
	//		,	'FirstName' => 'first_name' 
	//		,	'LastName' => 'last_name' 
	//		,	'Email' => 'email' 
	//		,	'Department' => 'department' 
	//		,	'MailingStreet' => 'address_one' 
	//		,	'MailingCity' => 'city' 
	//		,	'MailingState' => 'state' 
	//		,	'MailingCountry' => 'country' 
	//		,	'MailingPostalCode' => 'zip' 
	//		,	'Phone' => 'phone' 
	//		,	'Fax' => 'fax' 
	//		,	'LeadSource' => 'source' 
	//		,	'OwnerId' => 'crm_owner_fid' 
	//		,	'AccountId' => 'crm_account_fid' 
	//		,	'HasOptedOutOfEmail' => 'is_do_not_email' 
	//		,	'DoNotCall' => 'is_do_not_call'
	//};

	public static void afterInsert( List<Contact> newList ) {
		List<List<Id>> batchList = new List<List<Id>>();

	}

	@future(callOut=true)
	public static void sendToPardotLater( List<Id> newList ) {
		List<Contact> contacts = [SELECT Id, Email FROM Contact WHERE Id IN :newList];
		List<Contact> contactInserts = new List<Contact>();
		for ( Contact c : contacts ) {
			// write any fields?
			//contactInserts.add( sendToPardotNow( c ) );
		}
	}

	public static void sendToPardotNow( Contact c ) {
		Httprequest req = new HttpRequest();
		req.setEndpoint( 'https://pi.pardot.com/prospect/sync/email/' + EncodingUtil.urlEncode(c.Email, 'UTF-8') + '?contact_id=' + c.Id + '&sessionid=' + UserInfo.getSessionId() + '&serverurl=' + c.Partner_Server_URL__c + '&redirect_location='+getPageURL(c) );
		req.setMethod( 'GET' );
		HttpResponse res = new Http().send( req );
		System.Debug('res: ' + res);
		System.Debug('res.getBody(): ' + res.getBody());
	}

	public static String getPageURL(Contact c) {
		return 'https://na15.salesforce.com/' + c.Id;
	    String hostVal  = ApexPages.currentPage().getHeaders().get('Host');
	    String urlVal = Apexpages.currentPage().getUrl();
	    String URLL = 'https://' + hostVal+ urlVal;
	    return URLL;
	}

	///**
 //   * @description Called from Trigger Contact_Trigger after insert
 //   * @param newList the list of Contacts being inserted
 //   */
	//public static void afterInsert2( List<Contact> newlist ) {
	//	List<List<Id>> batchList = new List<List<Id>>();
	//	for ( Integer i=0; i < newList.size(); i++ ){
	//		if ( batchList.size() == 0 || batchList[batchList.size()-1].size() == INSERT_BATCH_SIZE ){
	//			batchList.add( new List<Id>() );
	//		}
	//		batchList[batchList.size()-1].add(newList[i].Id);
	//	}
	//	if ( batchList.size() > 0 ){
	//		for ( List<Id> li : batchList ){
	//			insertContactsInPardotLater(li);
	//		}
	//	}
	//}

	///**
 //   * @description Called from Trigger Contact_Trigger after update
 //   * @param newList the list of Contacts being updated
 //   */
	//public static void afterUpdate( List<Contact> newlist ) {
	//	// Do I need to do any validation checks?  Assert external ID, time check ? etc
	//	List<List<Id>> batchList = new List<List<Id>>();
	//	for ( Integer i=0; i < newlist.size(); i++ ){
	//		if ( batchList.size() == 0 || batchList[batchList.size()-1].size() == UPDATE_BATCH_SIZE ){
	//			batchList.add( new List<Id>() );
	//		}
	//		batchList[batchList.size()-1].add(newlist[i].Id);
	//	}
	//	if ( batchList.size() > 0 ){
	//		for ( List<Id> li : batchList ){
	//			updateContactsInPardotLater(li);
	//		}
	//	}
	//}

	//@future(callout=true)
	//public static void insertContactsInPardotLater( List<Id> contactIds ) {
	//	String api_key = getAPIKey();
	//	if ( api_key != API_KEY_ERROR ) {
	//		//List<Contact> contacts = Database.query( 'SELECT Id, Email FROM Contact WHERE Id IN :contactIds' );
	//		List<Contact> contacts = Database.query( getContactSelectQuery( contactIds ) );
	//		List<Contact> contactInserts = new List<Contact>();
	//		for ( Contact c : contacts ) {
	//			// write any fields?
	//			contactInserts.add( insertContactInPardotNow( c ) );
	//		}
	//		//if ( contactInserts.size() > 0 ) {
	//		//	update contactUpdates;
	//		//}
	//	}

	//}

	//@future(callout=true)
	//public static void updateContactsInPardotLater( List<Id> contactIds ) {
	//	String api_key = getAPIKey();
	//	if ( api_key != API_KEY_ERROR ) {
	//		List<Contact> contacts = Database.query( getContactSelectQuery( contactIds ) );
	//		List<Contact> contactUpdates = new List<Contact>();
	//		for ( Contact c : contacts ) {
	//			// write any fields?
	//			contactUpdates.add( updateContactInPardotNow( c ) );
	//		}
	//	}
	//}

	//public static Contact insertContactInPardotNow( Contact c ) {
	//	String method = 'POST';
	//	String endpoint = BASE_ENDPOINT + 'prospect/version/3/do/create';
	//	String body = 'api_key='+getAPIKey()+'&user_key='+getUser_Key()+'&email='+c.email;
	//	for ( String s : fieldMap.keySet() ) {
	//		if ( s.toLowerCase() != 'email' && c.get(s) != null ) {
	//			body += '&' + fieldMap.get(s) + '=' + c.get(s);
	//		}
	//	}
	//	HttpResponse response = callOut( method, endpoint, body);
	//	System.Debug('insert response: ' + response.getBody());
	//	return c;
	//}

	//public static Contact updateContactInPardotNow( Contact c ) {
	//	String method = 'POST';
	//	String endpoint = BASE_ENDPOINT + 'prospect/version/3/do/update'; // use the Pardot ID to update? Need to sync back to salesforce?
	//	String body = 'api_key='+getAPIKey()+'&user_key='+getUser_Key()+'&email='+c.email;
	//	for ( String s : fieldMap.keySet() ) {
	//		if ( s.toLowerCase() != 'email' && c.get(s) != null ) {
	//			body += '&' + fieldMap.get(s) + '=' + c.get(s);
	//		}
	//	}
	//	HttpResponse response = callOut( method, endpoint, body);
	//	System.Debug('insert response: ' + response.getBody());
	//	return c;
	//}

	//public static String getContactSelectQuery( List<Id> contactIds ) {
	//	String result = 'SELECT ';
	//	Boolean firstField = true;
	//	for ( String s : fieldMap.keySet() ) {
	//		if ( firstField ) {
	//			result += s;
	//			firstField = false;
	//		}
	//		else {
	//			result += ', ' + s;
	//		}
	//	}
	//	result += ' FROM Contact WHERE Id IN :contactIds';
	//	return result;
	//}


	//// Do callout method
	//public static HttpResponse callOut( String method, String endpoint, String body ){
	//	Httprequest req = new HttpRequest();
	//	req.setEndpoint( endpoint );
	//	req.setMethod( method );
	//	req.setBody(body);
	//	HttpResponse res = new Http().send( req );
	//	return res;
	//}

	//// Gets value from Callout
	//private static String getAPIKey() {
	//	Dom.XMLNode rootElement = callOut( 'POST', 
	//										BASE_ENDPOINT + 'login/version/3', 
	//										'email='+getEmail()+'&password='+getPassword()+'&user_key='+getUser_Key() ).getBodyDocument().getRootElement();
	//	return 
	//		( rootElement.getAttributeValue( 'stat', rootElement.getNamespace() ).toLowerCase() == 'ok' ) 
	//			? rootElement.getChildElement( 'api_key', rootElement.getNamespace() ).getText() 
	//			: API_KEY_ERROR;
	//}

	//// Gets value from Custom Setting
	//private static String getEmail() {
	//	return Pardot_Settings__c.getInstance('email').Value__c;
	//}

	//// Gets value from Custom Setting
	//private static String getPassword() {
	//	return Pardot_Settings__c.getInstance('password').Value__c;
	//}

	//// Gets value from Custom Setting
	//private static String getUser_Key() {
	//	return Pardot_Settings__c.getInstance('user_key').Value__c;
	//}
}