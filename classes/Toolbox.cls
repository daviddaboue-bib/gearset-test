public class Toolbox 
{
	public static List<String> extensions = new List<String>{'.com','.ca', '.bf', '.net', '.org'};
	public static String random_ext = extensions[generateNumber(0,extensions.size()-1)];

	public static Boolean isValidId(String param) 
	{
        String id = String.escapeSingleQuotes(param);
        return ((id.length() == 15 || id.length() == 18) && Pattern.matches('^[a-zA-Z0-9]*$', id)) ;
	}

	public static Boolean generateBoolean()
	{
		return (Math.random() > 0.5) 
		? true : false;
	}

	public static Integer generateNumber(Integer min, Integer max)
	{
		return min + (Integer)(Math.random()*(max - min + 1));
	}

	public static Decimal generateDecimal()
	{
		return 1000 * Math.random();
	}

	public static Date generateDate()
	{
		return Date.today();
	}

	public static Datetime generateDateTime()
	{
		return Datetime.now();
	}

	public static Time generateTime()
	{
		return Datetime.now().time();
	}

	public static String generateEmail()
	{
		Integer rd = generateNumber(2,10);
		return generateWord(rd) +'@'+ generateWord(rd) +  extensions[generateNumber(0,extensions.size()-1)];
	}

	public static String generateWord(Integer nbChars)
	{
		String ret = ''; 
		List<String> chars = new List<String>{
			'a','b','c','d','e','f','g','h','i','j','k','l','m',
			'n','o','p','q','r','s','t','u','v','w','x','y','z'
		};

		for(Integer i=0; i < nbChars; i++)
		{
			ret += chars[generateNumber(0,chars.size()-1)];
		}

		return ret;
	}

	public static String generateText(Integer nbWords)
	{
		List<String> ret = new List<String>(); 
		for(Integer i=0; i < nbWords; i++)
		{
			ret.add(generateWord(generateNumber(2,10)));
		}

		return String.join(ret, ' ');
	}

	public static String generatePhone()
	{
		List<String> chars = new List<String>{'1','2','3','4','5','6','7','8','9'};
		String ret = chars[generateNumber(0,chars.size()-1)]; 
		chars.add('0');
		
		for(Integer i=0; i < 9; i++)
		{
			ret += chars[generateNumber(0,chars.size()-1)];
		}

		return ret;
	}

	public static String generateURL()
	{
		return 'http://www.'+generateWord(generateNumber(3,20))+extensions[generateNumber(0,extensions.size()-1)]; 
	}

	public static List<String> getPicklistValues(String objectName, String fieldName)
	{
		Schema.DescribeFieldResult fieldDetails = Schema.getGlobalDescribe()
			.get(objectName)
			.getDescribe()
			.fields
			.getMap()
			.get(fieldName)
			.getDescribe();

		List<String> ret = new List<String>(); 
		Schema.DisplayType fieldType = fieldDetails.getType(); 
		if(fieldType == Schema.DisplayType.Picklist || fieldType == Schema.DisplayType.MultiPicklist)
		{
			for(Schema.PicklistEntry pe : fieldDetails.getPicklistValues())
			{
				if(pe.isActive())
				{
					ret.add(pe.getValue());
				}
			}
		}

		return ret;
	}

	public static sObject setRecordValue(String objectName, Schema.DescribeFieldResult fieldDetails, sObject record)
	{
		if(!fieldDetails.isCreateable())
		{
			return record;
		}

		Schema.DisplayType fieldType = fieldDetails.getType(); 
		System.debug('Field:'+fieldDetails.getName()+':'+fieldType);

		if(fieldType == Schema.DisplayType.Picklist || fieldType == Schema.DisplayType.MultiPicklist)
		{
			List<String> pickListValues  = getPicklistValues(objectName, fieldDetails.getName());
			Integer randomIndex = (Math.random() * (pickListValues.size() - 1)).intValue();
			record.put(fieldDetails.getSobjectField(), pickListValues[randomIndex]);	
		}
		else if(fieldType == Schema.DisplayType.Boolean)
		{
			record.put(fieldDetails.getSobjectField(), generateBoolean());
		}
		else if(fieldType == Schema.DisplayType.Date)
		{
			record.put(fieldDetails.getSobjectField(), generateDate());
		}
		else if(fieldType == Schema.DisplayType.Datetime)
		{
			record.put(fieldDetails.getSobjectField(), generateDateTime());
		}
		else if(fieldType == Schema.DisplayType.Time)
		{
			record.put(fieldDetails.getSobjectField(), generateTime());
		}
		else if(fieldType == Schema.DisplayType.Double || fieldType == Schema.DisplayType.Currency || fieldType == Schema.DisplayType.Percent)
		{
			record.put(fieldDetails.getSobjectField(), generateDecimal());
		}
		else if(fieldType == Schema.DisplayType.String || fieldType == Schema.DisplayType.TextArea)
		{
			record.put(fieldDetails.getSobjectField(), generateText(2));
		}
		else if(fieldType == Schema.DisplayType.Phone)
		{
			record.put(fieldDetails.getSobjectField(), generatePhone());
		}
		else if(fieldType == Schema.DisplayType.Email)
		{
			record.put(fieldDetails.getSobjectField(), generateEmail());
		}
		else if(fieldType == Schema.DisplayType.URL)
		{
			record.put(fieldDetails.getSobjectField(), generateURL());
		}
		else if(fieldType == Schema.DisplayType.Reference)
		{
			List<Schema.sObjectType> references = fieldDetails.getReferenceTo();
			Schema.sObjectType referenceType = references[0];
			
			System.debug('referenceType::'+referenceType);
			sObject referenceRecord = generateRecord(referenceType.getDescribe().getName());
			System.debug('referenceRecord::'+referenceRecord);
		}

		return record;
	}

	public static sObject generateRecord(String objectName)
	{
		Map<String, Schema.SObjectType> objectsMap = Schema.getGlobalDescribe(); 

		if(objectsMap.containsKey(objectName))
		{
			Schema.SObjectType objectType = objectsMap.get(objectName); 	

			sObject record = objectType.newSObject();

			Map <String, Schema.SObjectField> fieldMap = objectType.getDescribe().fields.getMap();
			for(String f : fieldMap.keySet())
			{
				Schema.DescribeFieldResult fieldDetails = Schema.getGlobalDescribe()
					.get(objectName)
					.getDescribe()
					.fields
					.getMap()
					.get(f)
					.getDescribe();
				
				record = setRecordValue(objectName, fieldDetails, record);
			}

			//insert record;
				
			return record;
		}

		return null;
	}
}