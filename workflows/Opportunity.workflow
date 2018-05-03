<?xml version="1.0" encoding="utf-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata"><fieldUpdates>
        <fullName>stage_is_set_to_Scheduled</fullName>
        <description>stage is set to Scheduled.</description>
        <field>StageName</field>
        <literalValue>Scheduled</literalValue>
        <name>stage is set to Scheduled.</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>true</protected>
    </fieldUpdates><fieldUpdates>
        <fullName>stage_to_Negotiation_Rejected</fullName>
        <description>set the stage to Negotiation Rejected</description>
        <field>StageName</field>
        <literalValue>Negotiation Rejected</literalValue>
        <name>stage to Negotiation Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates><tasks>
        <fullName>review_the_fulfillment</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>review the fulfillment</subject>
    </tasks></Workflow>