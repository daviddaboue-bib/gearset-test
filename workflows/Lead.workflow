<?xml version="1.0" encoding="utf-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata"><rules>
        <fullName>Lead COnverted</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Lead.IsConverted</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules></Workflow>