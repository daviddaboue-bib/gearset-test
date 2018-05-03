@RestResource(urlMapping='/UploadController/*')
global class UploadController
{
    @HttpPost
    global static String doUpload()
    {
      RestRequest req = RestContext.request;

      Blob fileContent = req.requestBody;
      Attachment a = new Attachment (ParentId = '001d000001QYevc',Body = fileContent,Name = 'Hello');
      insert a;

      return a.Id;
    }
}