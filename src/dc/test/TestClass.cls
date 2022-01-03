/// Test Class
Class dc.test.TestClass Extends %Persistent
{

/// name
Property Name As %String;

/// Write hello
ClassMethod Hello() As %Status
{
    Set sc = $$$OK
    Write "Hello"
    Return sc
}

Storage Default
{
<Data name="TestClassDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^dc.test.TestClassD</DataLocation>
<DefaultData>TestClassDefaultData</DefaultData>
<IdLocation>^dc.test.TestClassD</IdLocation>
<IndexLocation>^dc.test.TestClassI</IndexLocation>
<StreamLocation>^dc.test.TestClassS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
