@RestResource(urlMapping='/uploader/*')
global class RestServiceUploader 
{
	@HttpPost
	global static void doUpload()
	{
		RestRequest req = RestContext.request;
		system.debug('REQ::'+req);
	}

}