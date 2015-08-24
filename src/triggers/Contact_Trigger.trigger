trigger Contact_Trigger on Contact (after insert, after update) {
	
	if ( trigger.isAfter && trigger.isInsert ) {
		//Pardot_API.afterInsert( trigger.new );
	}

	if ( trigger.isAfter && trigger.isUpdate ) {
		//Pardot_API.afterUpdate( trigger.new );
	}
}